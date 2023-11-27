import 'dart:convert';
import 'dart:io';

//import 'dart:js';
import 'dart:typed_data';

// import 'socket_service.dart';
// import 'terminal_service.dart';
class ApiConnection {
  Socket? socket;

  ApiConncection() async {
    try {
      socket = await Socket.connect("185.233.107.253", 5000);
      // ? -> Nullaware, Handled Null anstatt Fehler zu werfen
      print('Connected to: ${socket?.remoteAddress.address}:${socket
          ?.remotePort}');
    } catch (e) {
      print('Error connecting to the server: $e');
    }
  }

  Future<void> connect() async {
    socket?.write(
        jsonEncode({"type": "search_request", "requested_updates": 1}));


    socket?.listen(
          (Uint8List data) {
        final serverResponse = String.fromCharCodes(data);
        final jsonData = jsonDecode(serverResponse);
        print(jsonData);
        /*
        finalvar parsedCommand = parseCommand(serverResponse);

        if (parsedCommand.key == SocketAction.successMessage) {
          print(parsedCommand.value.toString());
        }

         */
      },
      // handle errors
      onError: (error) {
        print(error);
        socket?.destroy();
      },


      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket?.destroy();
      },
    );
  }
}
/*

  Future<void> connect1() async {
    try {
      final socket = await Socket.connect("185.233.107.253", 5000);
      print(
          'Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

      // Send the search request
      final searchRequest = {
        "type": "search_request",
        "requested_updates": 1,
      };

      sendMessageToServer(socket, searchRequest);

      // Listen for server responses
      socket.listen(
            (List<int> data) {
          final serverResponse = JsonDecoder().convert(utf8.decode(data));
          // Handle the server response as needed
          print('Server Response: $serverResponse');
        },
        onError: (error) {
          print('Error: $error');
          socket.destroy();
        },
        onDone: () {
          print('Server left.');
          socket.destroy();
        },
      );
    } catch (e) {
      print('Error connecting to the server: $e');
    }
  }

  void sendMessageToServer(Socket socket, dynamic message) {
    final encodedMessage = JsonEncoder().convert(message);
    socket.add(utf8.encode(encodedMessage));
  }
}

 */
