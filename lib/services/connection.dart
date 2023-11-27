import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'package:web_socket_channel/io.dart';

import '../model/radioStation.dart';

class Conncection {
  static Conncection? instance;
  IOWebSocketChannel? channel;

  Future<void> _initWebSocket() async {
    try {
      await WebSocket.connect('ws://185.233.107.253:5000/api')
          .timeout(Duration(seconds: 20))
          .then((ws) {
            channel = IOWebSocketChannel(ws);
      });
    } catch (e) {
      if (e is TimeoutException) {
        print('Error: Connection timed out');
      } else {
        print('Error: Connection failed. ${e.toString()}');
      }
    }
    return null;
  }

  IOWebSocketChannel? getChannel() {
    return channel;
  }

  static Conncection? getInstance() {
    if (instance == null) {
      instance = new Conncection();
      instance!._initWebSocket();
    }
    return instance;
  }
}

// class Connection {
//   static Connection? _instance;
//   IOWebSocketChannel? _mainChannel;
//   Map<String, IOWebSocketChannel> _channels = {};
//
//   Connection._(); // Privater Konstruktor
//
//   Future<void> _initWebSocket() async {
//     try {
//       final WebSocket ws = await WebSocket.connect('ws://185.233.107.253:5000/api')
//           .timeout(Duration(seconds: 20));
//
//       _mainChannel = IOWebSocketChannel(ws);
//     } catch (e) {
//       if (e is TimeoutException) {
//         print('Error: Connection timed out');
//       } else {
//         print('Error: Connection failed. ${e.toString()}');
//       }
//     }
//   }
//
//   IOWebSocketChannel? getMainChannel() {
//     return _mainChannel;
//   }
//
//   IOWebSocketChannel getChannel(String channelId) {
//     if (!_channels.containsKey(channelId)) {
//       if (_mainChannel == null) {
//         throw Exception('Main channel not initialized. Call initWebSocket first.');
//       }
//       _channels[channelId] = IOWebSocketChannel(_mainChannel!.streamController);
//     }
//     return _channels[channelId]!;
//   }
//
//   static Connection getInstance() {
//     if (_instance == null) {
//       _instance = Connection._();
//     }
//     return _instance!;
//   }
// }



