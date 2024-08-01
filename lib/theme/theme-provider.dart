import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/theme/dark.dart';
import 'package:hello_world/theme/light.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if (_themeData == lightMode){
      themeData = darkMode;
    } else{
      themeData = lightMode;
    }
  }
}