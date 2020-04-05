import 'package:flutter/material.dart';
import 'constants.dart';
import 'routes/mainScreen.dart';

main() async {
  runApp(MaterialApp(
    title: 'Scouty',
    home: MainScreen(),
    theme: Constants.lightTheme,
    darkTheme: Constants.darkTheme,
  ));
}
