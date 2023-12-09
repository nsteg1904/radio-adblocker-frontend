import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../model/radioStation.dart';
import '../model/song.dart';
import 'apiConnectionService.dart';

class RadioListService {
  IOWebSocketChannel? _channel;

  /// Initializes the channel for the radio list.
  ///
  /// It gets the channel from the [ApiConnectionService].
  Future<void> _initChannel() async {
    try {

      _channel = await ApiConnectionService.getChannel('radioList');

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
        artists: [radio["current_interpret"] ?? ""],
      ),
    );
  }


  // Funktioniert noch nicht korrekt
  Future<Stream<List<RadioStation>>> getRadioList(int updateCount) async {
    requestRadioList(updateCount);
    StreamController<List<RadioStation>> controller = StreamController<List<RadioStation>>();

    //(responseData["radios"] as List<dynamic>).map((radio) => _radioFromServer(radio)).toList();

    _channel?.stream.listen(
          (dynamic serverResponse) {
        try {
          var responseData = json.decode(serverResponse);
          print(responseData['radios'].toString() + "\n\n");
          List<RadioStation> radioStationList = [];

          for(var radio in responseData['radios']){
            radioStationList.add(
                _radioFromServer(radio)
            );
          }

          controller.add(radioStationList);
          print("the List of Radios: " + radioStationList.toString());
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