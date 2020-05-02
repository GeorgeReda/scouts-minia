import 'package:flutter/material.dart';

class Constants {
  static String appName = "Scouts Minia";

  //Colors for theme
  static const Color darkPrimary = Color.fromRGBO(79, 23, 146, 1);
  static const Color lightPrimary = Color.fromRGBO(110, 32, 160, 1);
  static const Color lightBG = Colors.white;
  static const Color lighterBlack = Color.fromRGBO(30, 30, 30, 1);
  static const Color darkBG = Color.fromRGBO(18, 18, 18, 1);
  static const Color lightCursor = Color.fromRGBO(79, 23, 146, 0.7);
  static const Color lightTextSelection = Color.fromRGBO(79, 23, 146, 0.4);
  static const Color darkCursor = Color.fromRGBO(79, 23, 146, 0.7);
  static const Color darkTextSelection = Color.fromRGBO(79, 23, 146, 0.4);
  static const Color darkText = Color.fromRGBO(198, 200, 204, 1);
  static const double DividerIndent = 10;

  static ThemeData lightTheme = ThemeData(
      primaryColor: lightPrimary,
      accentColor: lightBG,
      primaryIconTheme: IconThemeData(color: lightBG, size: 10),
      backgroundColor: lightBG,
      buttonColor: lightPrimary,
      cursorColor: lightCursor,
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade300,
        indent: DividerIndent,
        endIndent: DividerIndent,
        thickness: 1,
      ),
      splashColor: lightCursor,
      textSelectionColor: lightTextSelection,
      textSelectionHandleColor: lightPrimary,
      fontFamily: 'El Messiri',
      appBarTheme: AppBarTheme(
        color: lightPrimary,
      ),
      scaffoldBackgroundColor: lightBG,
      iconTheme: IconThemeData(color: lightPrimary),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: lightBG));

  static ThemeData darkTheme = ThemeData(
      primaryColor: darkPrimary,
      accentColor: darkBG,
      primaryIconTheme: IconThemeData(color: darkText, size: 10),
      backgroundColor: darkBG,
      buttonColor: darkPrimary,
      cursorColor: darkCursor,
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade300,
        indent: DividerIndent,
        endIndent: DividerIndent,
        thickness: 1,
      ),
      splashColor: darkCursor,
      textSelectionColor: darkTextSelection,
      textSelectionHandleColor: lightPrimary,
      fontFamily: 'El Messiri',
      appBarTheme: AppBarTheme(color: lighterBlack),
      scaffoldBackgroundColor: darkBG,
      textTheme: TextTheme(
          body1: TextStyle(color: darkText), button: TextStyle(color: lightBG)),
      iconTheme: IconThemeData(color: darkText),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: darkBG));
}
