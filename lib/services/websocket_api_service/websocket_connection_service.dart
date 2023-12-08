import 'dart:async';
import 'dart:io';
import 'package:web_socket_channel/io.dart';

/// The API connection service.
///
/// This service is used to establish a connection to the API
/// and to get the channels for the different API endpoints.
class WebSocketConnectionService {

  /// The socket
  static WebSocket? _socket;

  /// The channels
  static final Map<String, IOWebSocketChannel?> _channels = {};


  /// Establishes a connection to the API.
  ///
  /// This function is called when the first channel is requested.
  /// It initializes the socket and saves it in [_socket].
  /// It throws an [TimeoutException] if the connection times out.
  /// It throws an [Exception] if the socket could not be initialized.
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

  /// Returns the channel for the given [channelId].
  ///
  /// This function is used to get the channel for the given [channelId].
  /// If the channel is not initialized yet, it will be initialized.
  /// It throws an [Exception] if the channel could not be initialized.
  /// It returns null if the channel could not be initialized.
  static Future<IOWebSocketChannel?> getChannel(String channelId) async {
    if (_socket == null) {
      await _initWebSocket();
    }

    try {
      // If the channel is not initialized yet, initialize it
      if (!_channels.containsKey(channelId)) {
        _channels[channelId] = IOWebSocketChannel(_socket!);
      }

      // If the channel is still not initialized, throw an exception
      _channels[channelId] ??= throw Exception("ApiConnectionService: Channel could not be initialized");
    } catch (e) {
      print(e.toString());
      return null;
    }

    return _channels[channelId];
  }
}
