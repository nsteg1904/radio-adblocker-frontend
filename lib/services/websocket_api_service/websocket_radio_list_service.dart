import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'dart:io';
import '../../model/radioStation.dart';
import '../../model/song.dart';
import 'websocket_connection_service.dart';

class WebSocketRadioListService {
  static WebSocket? _socket;
  static IOWebSocketChannel? _channel;
  static final StreamController<List<RadioStation>> _controller = StreamController<List<RadioStation>>();

  static Future<void> _initWebSocket() async {
    try {
      _socket = await WebSocket.connect('ws://185.233.107.253:5000/api')
          .timeout(const Duration(seconds: 20));

      _socket ??= throw Exception("ApiConnectionService: Socket could not be initialized");

    } catch (e) {
      if (e is TimeoutException) {
        print('ApiConnectionService: Connection Error: Connection timed out');
      } else {
        print('ApiConnectionService: Connection Error: ${e.toString()}');
      }
    }
  }

  /// Initializes the channel for the radio list.
  ///
  /// It gets the channel from the [WebSocketConnectionService].
  static Future<void> _initChannel() async {
    try {
      await _initWebSocket();
      _channel = IOWebSocketChannel(_socket!);
      //_channel = await WebSocketConnectionService.getChannel('radioList');

      _channel ??= throw Exception("RadioListService: Channel could not be initialized");
    } catch (e) {
      print(e.toString());
    }
  }


  /// Sends a request to the server to get the radio list.
  ///
  /// The [updateCount] is the number of updates that should be requested.
  static Future<void> requestRadioList(int updateCount) async {
    if(_channel == null){
      await _initChannel();
    }

    final message = jsonEncode({
      "type": "search_request",
      "requested_updates": updateCount
    });

    _channel?.sink.add(message);
  }


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


  // Funktioniert noch nicht korrekt
  static Stream<List<RadioStation>> getRadioList() {
    print("getRadioList");

    try {
      _channel ??= throw Exception("Channel not initialized");
      print(_channel);
      _channel?.stream.listen(
            (dynamic serverResponse) {
          var responseData = json.decode(serverResponse);
          print(responseData['radios'].toString() + "\n\n");
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
          print(radioStationList.toString() + "\n\n");
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