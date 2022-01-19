import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/conversation/conversation.dart';
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

Socket? socket;

void connectToServer() {
  try {
    // Configure socket transports must be sepecified
    socket = io('http://192.168.1.9:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to websocket
    socket!.connect();
    socket!.emit('signin', Boxes.getCurrentUserInfo()!.uid);

    // Handle socket! events
    socket!.on('connect', (_) => print('connect: ${socket!.id}'));
    socket!.on('location', handleLocationListen);
    socket!.on('typing', handleTyping);
    socket!.on('message', handleMessage);
    socket!.on('disconnect', (_) => print('disconnect'));
    socket!.on('fromServer', (_) => print(_));
  } catch (e) {
    print(e.toString());
  }
}

// Send Location to Server
sendLocation(Map<String, dynamic> data) {
  socket!.emit("location", data);
}

// Listen to Location updates of connected usersfrom server
handleLocationListen(dynamic data) async {
  print(data);
}

// Send update of user's typing status
sendTyping(bool typing) {
  socket!.emit("typing", {
    "id": Boxes.getCurrentUserInfo()!.uid,
    "typing": typing,
  });
}

// Listen to update of typing status from connected users
void handleTyping(dynamic data) {
  if (data['typing']) {
    print(data['id'] + " is typing");
  } else {
    print(data['id'] + " stopped typing");
  }
}

// Send a Message to the server
sendMessage(
    {required String message,
    required String sourceId,
    required String targetId,
    required String time}) {
  socket!.emit('message', {
    'message': message,
    'sourceId': sourceId,
    'targetId': targetId,
    'time': time,
  });
}

// Listen to all message events from connected users
 handleMessage(dynamic data) {
  var message = data['message'];
  var sourceId = data['sourceId'];
  var targetId = data['targetId'];
  var time = data['time'];
  var chatModel =  ChatModel(
    message: message,
    sentByMe: false,
    time: time,
  );
  Boxes.addCoversation(chatModel: chatModel, id: sourceId);
}
