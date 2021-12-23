import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Constant{
  static bool isDark = true;
}
class SharedData {
  static SharedPreferences? prefs;
  static var theme;
  static var defaultTheme;



  
  static Future<void> init() async {
    prefs??=await SharedPreferences.getInstance();
    theme= await getTheme();
    defaultTheme= await getDefaultTheme();
  }





  static String _isDarkModeEnabled = "IsDark";
  static String _defaultTheme = "dark";

  static Future<dynamic> setDefaultTheme(bool value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_defaultTheme, value);
  }

  // //getting data from shared preferences
  static Future<dynamic> getDefaultTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_defaultTheme);
  }

// Saving Data to Shared preferences
  static Future<dynamic> setTheme(bool value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_isDarkModeEnabled, value);
  }

  // //getting data from shared preferences
  static Future<dynamic> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkModeEnabled);
  }

} 