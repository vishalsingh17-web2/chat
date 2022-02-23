import 'package:chat/firebase/authentication.dart';
import 'package:chat/hive/user/user_info.dart';
import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier {
  List<UserInf> usersList = [];
  late String fcmToken;
  UserData(){
    init();
  }
  init() async {
    List<UserInf> list = [];
    var x = await FirebaseService.getUserList();
    for (var i in x) {
      list.add(UserInf.fromJson(i));
    }
    usersList = list;
    return list;
  }

   getUserFCMwithEmail(String email){
    for (var element in usersList) {
      if (element.email == email) {
        fcmToken = element.fcmToken;
      }
    }
    notifyListeners();
  }
}
