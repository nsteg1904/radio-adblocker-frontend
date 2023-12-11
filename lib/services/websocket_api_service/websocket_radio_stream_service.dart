import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../../model/radioStation.dart';
import '../../model/song.dart';
import 'websocket_connection_service.dart';

class WebSocketRadioStreamService {
  static IOWebSocketChannel? _channel;
  static final StreamController<RadioStation> _controller = StreamController<RadioStation>();

  /// Initializes the channel for the radio list.
  ///
  /// It gets the channel from the [WebSocketConnectionService].
  static Future<void> initChannel() async {
    try {
      _channel = await WebSocketConnectionService.getChannel('RadioStream');

      _channel ??=
          throw Exception("RadioListService: Channel could not be initialized");
    } catch (e) {
      print(e.toString());
    }
  }

  static List<int> _createStreamRequestIds(int? requestedRadioId, List<int> favoriteRadioIds) {
    // The stream request ids are the ids of the radios that are requested from the server.
    List<int> streamRequestIds = [];

    requestedRadioId = requestedRadioId ??
        1; // If the last listened radio is null, the id is set to 1.

    // The last listened radio is removed from the favorite radio ids, if it is in the list.
    favoriteRadioIds.contains(requestedRadioId)
        ? favoriteRadioIds.remove(requestedRadioId)
        : null;

    // The last listened radio is added at the beginning of the stream request ids.
    streamRequestIds.add(requestedRadioId);
    // The favorite radio ids are added to the stream request ids.
    streamRequestIds.addAll(favoriteRadioIds);

    return streamRequestIds;
  }

  static Future<bool> streamRequest(int? requestedRadioId, List<int> favoriteRadioIds) async {
    List<int> streamRequestIds = _createStreamRequestIds(requestedRadioId, favoriteRadioIds);
    print(streamRequestIds);

    if (_channel == null) {
      await initChannel();
    }

    try{
      final message = jsonEncode({
        "type": "stream_request",
        "preferred_radios": streamRequestIds,
        "preferred_experience": {
          "ad": false,
          "talk": true,
          "news": true,
          "music": true
        }
      });

      _channel?.sink.add(message);
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;

  }

  /// TODO: Find out when and why the following exception occurs: Unhandled Exception: Exception: type 'String' is not a subtype of type 'List<String>
  static RadioStation _extractRadioFromServerResponse(String serverResponse){
    try {
      Map<String, dynamic> responseData = json.decode(serverResponse);
      if(responseData['type'] == "error"){
        throw Exception(responseData['message']);
      }

      Map<String,dynamic> radioMap = responseData['switch_to'];
      RadioStation radio = RadioStation.namedParameter(
        id: radioMap["id"] ?? 1,
        name: radioMap["name"] ?? "name",
        streamUrl: radioMap["stream_url"] ?? "stream_url",
        logoUrl: radioMap["logo_url"] ?? "logo_url",
        status: radioMap["status_id"]?.toString() ?? "2",
        song: Song.namedParameter(
          name: radioMap["currently_playing"] ?? "currently_playing",
          artist: radioMap["current_interpret"] ?? "artist",
        ),
      );

      return radio;
    } catch (e) {
      print('Error parsing json data: $e');
      throw Exception(e);
    }
  }

  static Stream<RadioStation> getStreamableRadio() {

    try {
      _channel ??= throw Exception("Channel not initialized");

      _channel?.stream.listen(
            (dynamic serverResponse) {
          RadioStation radio = _extractRadioFromServerResponse(serverResponse);
          // print(radio);
          _controller.add(radio);
        },
        onDone: () {
          print('Stream closed');
          // closes streamController when the stream is closed
          _controller.close();
        },
        onError: (error) {
          print('Error receiving data from server: $error');
          // close streamController with error
          _controller.addError(error);
          _controller.close();
        },
        cancelOnError: true,
      );

      return _controller.stream;
    } catch (e) {
      print(e.toString());
    }

    return _controller.stream;
  }

  static void closeStream(){
    _channel?.sink.close();
  }
}
