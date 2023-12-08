import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../../model/radioStation.dart';
import '../../model/song.dart';
import 'websocket_connection_service.dart';

class RadioListService {
  IOWebSocketChannel? _channel;

  /// Initializes the channel for the radio list.
  ///
  /// It gets the channel from the [WebSocketConnectionService].
  Future<void> _initChannel() async {
    try {

      _channel = await WebSocketConnectionService.getChannel('radioList');

      _channel ??= throw Exception("RadioListService: Channel could not be initialized");
    } catch (e) {
      print(e.toString());
    }
  }


  /// Sends a request to the server to get the radio list.
  ///
  /// The [updateCount] is the number of updates that should be requested.
  Future<void> requestRadioList(int updateCount) async {
    if(_channel == null){
      await _initChannel();
    }

    final message = jsonEncode({
      "type": "search_request",
      "requested_updates": updateCount
    });

    _channel?.sink.add(message);
  }


  RadioStation _radioFromServer(Map<String, dynamic> radio) {
    return RadioStation.namedParameter(
      id: radio["id"] ?? 1,
      name: radio["name"] ?? "name",
      streamUrl: radio["stream_url"] ?? "stream_url",
      logoUrl: radio["logo_url"] ?? "logo_url",
      status: radio["status_id"]?.toString() ?? "2",
      song: Song.namedParameter(
        name: radio["currently_playing"] ?? "currently_playing",
        artist: radio["current_interpret"].toList() ?? [],
      ),
    );
  }

  // Funktioniert noch nicht korrekt
  Future<Stream<List<RadioStation>>> getRadioList() async {
    StreamController<List<RadioStation>> controller = StreamController<List<RadioStation>>();

    _channel?.stream.listen(
          (dynamic serverResponse) {
        try {
          Map<String, dynamic> responseData = json.decode(serverResponse);
          // print(responseData["radios"][0].runtimeType);
          List<RadioStation> rList = (responseData["radios"] as List<dynamic>)
              .map((radio) => _radioFromServer(radio))
              .toList();

          controller.add(rList);
        } catch (e) {
          print('Error parsing json data: $e');
        }
      },
      onDone: () {
        print('Stream closed');
        // closes streamController when the stream is closed
        controller.close();
      },
      onError: (error) {
        print('Error receiving data from server: $error');
        // close streamController with error
        controller.addError(error);
        controller.close();
      },
      cancelOnError: true,
    );

    return controller.stream;
  }

  Future<void> close() async {
    await Future.delayed(const Duration(seconds: 5));
    _channel?.sink.close();
  }



}