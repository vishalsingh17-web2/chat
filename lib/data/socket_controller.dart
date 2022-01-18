import 'package:chat/hive/boxes.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketIO {
  static Socket? socket;
  static void init() {
    SocketIO.socket = IO.io('http://192.168.1.9:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
    socket!.emit('signin', Boxes.getCurrentUserInfo()!.uid);
    
  }

  // static void signIn(String uid) {
  //   socket!.emit('signin', uid);
  // }

  static void sendMessage({
    required String message,
    required String sourceId,
    required String targetId,
    required String time,
  }) {
    socket!.emit('message', {
      'message': message,
      'sourceId': sourceId,
      'targetId': targetId,
      'time': time,
    });
  }
}