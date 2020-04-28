import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  bool isDarkMode = false;
  updateTheme(bool isDarkMode){
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}