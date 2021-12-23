import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Constant{
  static bool isDark = true;
}
class SharedData {
  static SharedPreferences? prefs;
  static var theme;
  static var defaultTheme;
  static var isLoggedIn;



  
  static Future<void> init() async {
    prefs??=await SharedPreferences.getInstance();
    theme= await getTheme();
    defaultTheme= await getDefaultTheme();
    isLoggedIn= await getLoginStatus();
  }
  static String _isDarkModeEnabled = "IsDark";
  static String _defaultTheme = "dark";
  static String _isLoggedIn = "isLogin";

  static Future<dynamic> setLoginStatus(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_isLoggedIn, value);
  }
  static Future<dynamic> getLoginStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedIn);
  }

  static Future<dynamic> setDefaultTheme(bool value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_defaultTheme, value);
  }

 
  static Future<dynamic> getDefaultTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_defaultTheme);
  }


  static Future<dynamic> setTheme(bool value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_isDarkModeEnabled, value);
  }

 
  static Future<dynamic> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkModeEnabled);
  }

} 