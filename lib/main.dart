import 'package:flutter/material.dart';
import 'package:scouts_minia/routes/login.dart';

import 'constants.dart';
import 'routes/mainScreen.dart';

main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Scouty',
    home: Login(),
    theme: Constants.lightTheme,
    darkTheme: Constants.darkTheme,
  ));
}
