import 'dart:async';
import 'dart:io';
import 'package:web_socket_channel/io.dart';

class ApiConnectionService {
    static ApiConnectionService? _instance;
    static WebSocket? _socket;
    final Map<String, IOWebSocketChannel> _channels = {};

    ApiConnectionService._();

    static Future<ApiConnectionService> getInstance() async {
      if (_instance == null) {
        _instance = ApiConnectionService._();
        await _instance!._initWebSocket();
      }
      return _instance!;
    }

    Future<void> _initWebSocket() async {
      try {
         _socket = await WebSocket.connect('ws://185.233.107.253:5000/api')
            .timeout(const Duration(seconds: 20));
      } catch (e) {
        if (e is TimeoutException) {
          print('Error: Connection timed out');
        } else {
          print('Error: Connection failed. ${e.toString()}');
        }
      }
    }

    IOWebSocketChannel getChannel(String channelId){
      if(_socket == null){
        throw Exception('Socket not initialized. Call initWebSocket first.');
      }

      if(!_channels.containsKey(channelId)){
        _channels[channelId] = IOWebSocketChannel(_socket!);
      }

      return _channels[channelId]!;
    }
}






