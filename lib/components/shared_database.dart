import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Constant{
  static bool isDark = true;
}
class SharedData {
  static String isDarkModeEnabled = "IsDarkModeEnabled";
  static String loginKey = "ISLOGGEDIN";
  static String nameKey = "USERNAMEKEY";
  static String emailKey = "USERMAILKEY";
// Saving Data to Shared preferences
  static Future<dynamic> setTheme(bool value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(isDarkModeEnabled, value);
  }
  // static Future<dynamic> saveUsername(String isUsername)async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setString(nameKey, isUsername);
  // }
  // static Future<dynamic> saveUseremail(String isUseremail)async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setString(emailKey, isUseremail);
  // }

  // //getting data from shared preferences
  static Future<dynamic> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isDarkModeEnabled);
  }
  // static Future<dynamic> getUsername() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(nameKey);
  // }
  // static Future<dynamic> getUseremail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(emailKey);
  // }
} 