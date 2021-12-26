// import 'dart:convert';

// import 'package:chat/hive/user_info.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedData {
//   static SharedPreferences? prefs;
//   static var theme;
//   static var defaultTheme;
//   static var isLoggedIn;
//   static var userInfo;
//   static UserInf? userObject;
  
//   static Future<void> init() async {
//     prefs??=await SharedPreferences.getInstance();
//     theme= await getTheme();
//     defaultTheme= await getDefaultTheme();
//     isLoggedIn= await getLoginStatus();
//     userInfo= await getUser();
//     userInfo = userInfo??'';
//     userObject = userInfo!=''?UserInf.fromJson(userInfo):null;

    
//     // userInfo = json.decode("{'name':'vishal'}");
//   }
//   static String _isDarkModeEnabled = "IsDark";
//   static String _defaultTheme = "dark";
//   static String _isLoggedIn = "isLogin";

//   static Future<dynamic> setLoginStatus(bool value) async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await init();
//     return prefs.setBool(_isLoggedIn, value);
//   }
//   static Future<dynamic> getLoginStatus() async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_isLoggedIn);
//   }

//   static Future<dynamic> setDefaultTheme(bool value)async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await init();
//     return await prefs.setBool(_defaultTheme, value);
//   }

 
//   static Future<dynamic> getDefaultTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_defaultTheme);
//   }


//   static Future<dynamic> setTheme(bool value)async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await init();
//     return await prefs.setBool(_isDarkModeEnabled, value);
//   }

 
//   static Future<dynamic> getTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_isDarkModeEnabled);
//   }

//   // Setting up UserInfo

//   static Future<dynamic> saveUser(Map<String, String> userInfo) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('name', userInfo['displayName'].toString());
//     prefs.setString('email', userInfo['email'].toString());
//     prefs.setString('phone', userInfo['phoneNumber'].toString());
//     prefs.setString('image', userInfo['photoUrl'].toString());
//     prefs.setString('uid', userInfo['uid'].toString());
//     await init();
//   }
//   static Future<dynamic> getUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Map<String, String> userInfo = {
//       'displayName': prefs.getString('name').toString(),
//       'email': prefs.getString('email').toString(),
//       'phoneNumber': prefs.getString('phone').toString(),
//       'photoUrl': prefs.getString('image').toString(),
//       'uid': prefs.getString('uid').toString(),
//     };
//     return userInfo;
//   }

// } 