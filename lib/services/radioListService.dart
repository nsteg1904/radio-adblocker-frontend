import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';

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

  Future<String?> getRadioList() async {
    // Erstelle einen Completer, um das Future manuell zu beenden
    Completer<String?> completer = Completer<String?>();

    // Höre auf Nachrichten vom Server
    var subscription = _channel?.stream.listen(
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

  Future<void> close() async {
    await Future.delayed(const Duration(seconds: 5));
    _channel?.sink.close();
  }



}