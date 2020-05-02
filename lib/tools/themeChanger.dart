import 'package:flutter/material.dart';

// Changes Theme Mode with the help of Provider
class ThemeChanger extends ChangeNotifier {
  bool isDarkMode = false;

  updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}
