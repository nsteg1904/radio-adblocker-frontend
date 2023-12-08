import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'package:web_socket_channel/io.dart';

import '../../model/radioStation.dart';

class APIService {
  IOWebSocketChannel? channel;

  /// Establishes connection to the Websocket
  Future<void> initWebSocket() async {
    try {
      await WebSocket.connect('ws://185.233.107.253:5000/api')
          .timeout(Duration(seconds: 20))
          .then((ws) {
        channel = IOWebSocketChannel(ws);
        print('Connection established');
      });
    } catch (e) {
      if (e is TimeoutException) {
        print('Error: Connection timed out');
      } else {
        print('Error: Connection failed. ${e.toString()}');
      }
    }
  }


  /// Listens to the channel and returns the Server Response
  Future<String?> getServerMessage() async {
    // Erstelle einen Completer, um das Future manuell zu beenden
    Completer<String?> completer = Completer<String?>();

    // Höre auf Nachrichten vom Server
    var subscription = channel?.stream.listen(
          (event) {
        completer.complete(event);
      },
      onDone: () {
        completer
            .complete(null); // Setze auf null, wenn der Stream geschlossen wird
      },
    );

    // Warte auf die Fertigstellung des Future
    String? message = await completer.future;

    // Beende das Abonnement, um Ressourcen freizugeben
    await subscription?.cancel();

    return message;
  }

  /// Sends a message to the server
  void sendMessage(String message) async {
    channel?.sink.add(message);
  }

  /// closes the connection to the server
  void close() async {
    await Future.delayed(Duration(seconds: 5));
    channel?.sink.close();
  }

/// Returns a List of Radiostations
  Future<List<RadioStation>> getRadioStations() async {
    //Warte auf Servermessage
    sendMessage(jsonEncode({
      "type": "search_request",
      "requested_updates": 1
    }));
    String? data = await getServerMessage();
    List<RadioStation> radioStationList = [];
    if (data != null) {
      print('correct');
      var dataDecoded = jsonDecode(data);
      print('this is it: ' + dataDecoded['radios'][1]['id'].toString());

      int i = 0;
      for(var radio in dataDecoded['radios']){
        radioStationList[i] = RadioStation.namedParameter(
            id: radio['id'],
            name: radio['name'],
            streamUrl: radio['streamUrl'],
            logoUrl: radio['logoUrl'],
            genres: radio['genres'],
            status: radio['status'],
            song: radio['song']);

        i++;
      }
    }
    return radioStationList;
  }

/// Returns a List of Radios that are playable (currently no adds), sorted by preference

}

