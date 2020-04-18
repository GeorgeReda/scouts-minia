import 'package:flutter/material.dart';
import 'package:scouts_minia/routes/login.dart';
import 'package:scouts_minia/routes/mainScreen.dart';
import 'package:scouts_minia/tools/network_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Scouty',
    home: SplashScreen(),
    theme: Constants.lightTheme,
    darkTheme: Constants.darkTheme,
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('api token') ?? 0;
    if (value != '0') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
