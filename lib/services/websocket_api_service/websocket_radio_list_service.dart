import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import '../../model/radio_station.dart';
import '../../model/song.dart';
import 'websocket_connection_service.dart';

class WebSocketRadioListService {
  static IOWebSocketChannel? _channel;
  static final StreamController<List<RadioStation>> _controller = StreamController<List<RadioStation>>();
  static int remainingUpdates = 0;

  /// Initializes the channel for the radio list.
  ///
  /// It gets the channel from the [WebSocketConnectionService].
  static Future<void> initChannel() async {
    try {
      _channel = await WebSocketConnectionService.getChannel('RadioList');

      _channel ??=
      throw Exception("RadioListService: Channel could not be initialized");
    } catch (e) {
      print(e.toString());
    }
  }


  /// Sends a request to the server to get the radio list.
  ///
  /// The [updateCount] is the number of updates that should be requested.
  static Future<void> requestRadioList(int updateCount) async {
    if(_channel == null){
      await initChannel();
    }

    final message = jsonEncode({
      "type": "search_request",
      "requested_updates": updateCount
    });

    remainingUpdates = updateCount;

    _channel?.sink.add(message);
  }

  /// Creates a [RadioStation] from the given map.
  ///
  /// The map [radio] contains the data of the radio station.
  static RadioStation _radioFromServer(Map<String, dynamic> radio) {
    return RadioStation.namedParameter(
      id: radio["id"] ?? 1,
      name: radio["name"] ?? "name",
      streamUrl: radio["stream_url"] ?? "stream_url",
      logoUrl: radio["logo_url"] ?? "logo_url",
      status: radio["status_id"]?.toString() ?? "2",
      song: Song.namedParameter(
        name: radio["currently_playing"] ?? "currently_playing",
        artist: radio["current_interpret"] ?? "",
      ),
    );
  }


  /// Returns a stream of the radio list from the Server.
  ///
  /// The stream contains a list of [RadioStation]s.
  static Stream<List<RadioStation>> getRadioList() {
    try {
      _channel ??= throw Exception("Channel not initialized");
      print(_channel);
      _channel?.stream.listen(
            (dynamic serverResponse) {
          var responseData = json.decode(serverResponse);
          //print("Remaining Updates for List: " + responseData['remaining_updates'].toString() + "\n\n");

          //Save Remaining Updates
          remainingUpdates = responseData['remaining_updates'];
          //Extract RadioStations
          List<RadioStation> radioStationList = [];
          if (responseData['radios'] != null) {
            for (var radio in responseData['radios']) {
              if (radio != null) {
                radioStationList.add(
                    _radioFromServer(radio)
                );
              }
            }
          }
          _controller.add(radioStationList);
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
    } catch (e) {
      print("Error in getRadioList(): " + e.toString());
    }

    return _controller.stream;
  }

  static Future<void> close() async {
    await Future.delayed(const Duration(seconds: 5));
    _channel?.sink.close();
  }
}