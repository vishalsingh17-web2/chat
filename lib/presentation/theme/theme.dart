import 'dart:async';

import 'package:chat/main.dart';
import 'package:flutter/material.dart';



class ThemeX {
  static ThemeData darkTheme() {
    return ThemeData(
      
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey,
      iconTheme: const IconThemeData(color: Colors.white),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
      accentColor: Colors.black,
      scaffoldBackgroundColor: const Color.fromRGBO(41, 47, 63, 1),
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        subtitle1: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        subtitle2: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        button: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        caption: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        overline: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blueGrey,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      tabBarTheme:const TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black54,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      
      ),
      accentColor: Colors.white,
      scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      textTheme:const TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          color: Colors.black,
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
        ),
        headline3: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        subtitle1: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        subtitle2: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        button: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        caption: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        overline: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  
}

