
import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/user/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  late UserInf userInfo;
  UserProvider(){
    userInfo = Boxes.getCurrentUserInfo()!;
  }

}