import 'package:chat/data/socket_controller.dart';
import 'package:flutter/cupertino.dart';

class TypingProvider extends ChangeNotifier {
  bool isTyping = false;
  String uid = '';
  TypingProvider() {
    
    socket!.on('typing', (data) {
      uid = data['sourceId'];
      isTyping = data['typing'];
      notifyListeners();
    });
  }
   checkTyping(){
    
    socket!.on('typing', (data) {
      uid = data['sourceId'];
      isTyping = data['isTyping'];
      notifyListeners();
      
    });
  }
}

class OnlineStatusProvider extends ChangeNotifier {
  bool isOnline = false;
  String uid = '';
  OnlineStatusProvider() {
    socket!.on('isOnline', (data) {
      uid = data['uid'];
      isOnline = data['isOnline'];
      notifyListeners();
    });
  }
}