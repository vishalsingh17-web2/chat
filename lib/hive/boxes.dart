import 'package:chat/hive/user_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes{
  static init()async{
    await Hive.openBox<UserInf>('userInfo');
    await Hive.openBox('theme');
  }
  static Box getThemeBox() => Hive.box('theme');

  static setdarkTheme() => getThemeBox().put('dark', true);
  static setlightTheme() => getThemeBox().put('dark', false);
  static getTheme() => getThemeBox().get('dark');
  

  // Setting user info list that is coming at Direct messages page 
  static const String userInfo = 'userInfo';
  static Box<UserInf> getUserInfoBox() => Hive.box<UserInf>(userInfo);

  static const String currentUser = 'currentUser';
  static UserInf? getCurrentUserInfo() => Hive.box<UserInf>(userInfo).get(currentUser);
  
}