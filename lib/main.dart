import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scouts_minia/routes/login.dart';
import 'package:scouts_minia/tools/themeChanger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'routes/mainScreen.dart';

main() async {
  runApp(ChangeNotifierProvider<ThemeChanger>(
    create: (_) => ThemeChanger(),
    child: Consumer<ThemeChanger>(
      builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Scouty',
          home: SplashScreen(),
          theme: Constants.lightTheme,
          darkTheme: Constants.darkTheme,
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    ),
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
    if (value != 'out' || value == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
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
