import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../model/radioStation.dart';
import '../model/song.dart';
import 'apiConnectionService.dart';

class RadioListService {
  IOWebSocketChannel? _channel;

  Future<void> _initChannel() async {
    ApiConnectionService con = await ApiConnectionService.getInstance();
    _channel = con.getChannel('radioList');
  }

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
        artists: radio["current_interpret"].toList() ?? [],
      ),
    );
  }

  // Funktioniert noch nicht korrekt
  Stream<List<RadioStation>> getRadioList() {
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