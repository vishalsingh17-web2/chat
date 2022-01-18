import 'package:chat/hive/boxes.dart';
import 'package:chat/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  late ThemeData themeData;
  ThemeProvider(){
    if(Boxes.getTheme()){
      themeData = ThemeX.darkTheme();
    }else{
      themeData = ThemeX.lightTheme();
    }
  }
  void changeTheme(){
    if(Boxes.getTheme()){
      Boxes.setlightTheme();
      themeData = ThemeX.lightTheme();
    }
    else{
      Boxes.setdarkTheme();
      themeData = ThemeX.darkTheme();
    }
    notifyListeners();
  }
  
}