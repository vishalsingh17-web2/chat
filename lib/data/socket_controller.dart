import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/conversation/conversation.dart';
import 'package:flutter/cupertino.dart';
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
    socket = io('https://glacial-fortress-22545.herokuapp.com/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to websocket
    socket!.connect();
    socket!.emit('signin', Boxes.getCurrentUserInfo()!.uid);

    // Handle socket! events
    socket!.on('connect', (_) => debugPrint('connect: ${socket!.id}'));
    socket!.on('location', handleLocationListen);
    socket!.on('typing', handleTyping);
    socket!.on('message', handleMessage);
    socket!.on('disconnect', (_) => debugPrint('disconnect'));
    socket!.on('fromServer', (_) => debugPrint(_));
    socket!.on('isOnline', (data) => handleOnline);
  } catch (e) {
    debugPrint(e.toString());
  }
}

// Send Location to Server
sendLocation(Map<String, dynamic> data) {
  socket!.emit("location", data);
}

// Send isOnline to Server
sendIsOnline({required bool isOnline}) {
  socket?.emit("isOnline", {
    "isOnline": isOnline,
    "uid": Boxes.getCurrentUserInfo()!.uid,
  });
}

// Listen to Location updates of connected usersfrom server
handleLocationListen(dynamic data) async {
  debugPrint(data);
}

// Send update of user's typing status
sendTyping({required String targetId, required bool isTyping}) {
  socket?.emit("typing", {
    "sourceId": Boxes.getCurrentUserInfo()!.uid,
    'targetId': targetId,
    "typing": isTyping,
  });
}

// Listen to update of typing status from connected users
handleTyping(dynamic data) {
  return data['typing'];
}
// listen to online status
handleOnline(data){
  return data['isOnline'];
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
