import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../../model/radio_station.dart';
import '../../model/song.dart';
import '../client_data_storage_service.dart';
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
      listenForStreamableRadio();

      _channel ??=
          throw Exception("RadioStreamService: Channel could not be initialized");
    } catch (e) {
      print(e.toString());
    }
  }

  /// Creates the list of radio ids that are requested from the server.
  /// 
  /// The list contains the id of the requested radio and the favorite radios.
  static List<int> _createStreamRequestIds(int? reqRadioId, List<int> favRadioIds) {
    int? requestedRadioId = reqRadioId;

    // The favorite radio ids are copied to a new list.
    List<int> favoriteRadioIds = List.from(favRadioIds);

    favoriteRadioIds.remove(5);

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
  /// Sends a request to the server to get the radio stream.
  ///
  /// The request contains the id of the requested radio and the favorite radios.
  static Future<bool> streamRequest(int? requestedRadioId, List<int> favoriteRadioIds) async {
    List<int> streamRequestIds = _createStreamRequestIds(requestedRadioId, favoriteRadioIds);

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

  /// Extracts the radio from the server response.
  ///
  /// The server response is a json string. The radio is extracted from the json string.
  /// If the response contains an error, an exception is thrown.
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
    return _controller.stream;
  }

  /// Returns a stream of radios.
  ///
  /// The stream is created from the channel. The radios are extracted from the server response.
  static void listenForStreamableRadio() {
    try {
      _channel ??= throw Exception("Channel not initialized");

      _channel?.stream.listen(
            (dynamic serverResponse) {
          RadioStation radio = _extractRadioFromServerResponse(serverResponse);
          _controller.add(radio);
        },
        onDone: () {
          print('Stream closed');
          reconnect();
        },
        onError: (error) {
          print('Error receiving data from server: $error');
          _controller.addError(error);
          reconnect();
        },
        cancelOnError: true,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  /// Reconnects to the WebSocket server after a delay.
  static void reconnect() {
    Timer(const Duration(seconds: 5), () async {
      print('Trying to reconnect...');
      await initChannel();
      await initStreamRequest();
    });
  }

  static Future<void> initStreamRequest() async {
    final prefService = ClientDataStorageService();
    int? lastListenedRadio = await prefService.loadLastListenedRadio();
    List<int> favoriteRadioIds = await prefService.loadFavoriteRadioIds();

    await WebSocketRadioStreamService.streamRequest(
        lastListenedRadio, favoriteRadioIds);
  }



  static void closeStream(){
    _channel?.sink.close();
  }
}
