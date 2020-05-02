import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scouts_minia/routes/accountDetails.dart';
import 'package:scouts_minia/routes/addPost.dart';
import 'package:scouts_minia/routes/login.dart';
import 'package:scouts_minia/routes/register.dart';
import 'package:scouts_minia/tools/themeChanger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'routes/mainScreen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider for changing from light mode to dark mode and vice versa
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(),
      child: Consumer<ThemeChanger>(
        builder: (context, appState, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Nor El Alam Scouts',
            home: SplashScreen(),
            theme: Constants.lightTheme,
            darkTheme: Constants.darkTheme,
            themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routes: {
              'mainScreen': (ctx) => MainScreen(),
              'login': (ctx) => Login(),
              'register': (ctx) => Register(),
              'addPost': (ctx) => AddPost(),
              'accountDetails': (ctx) => AccountDetails()
            },
          );
        },
      ),
    );
  }
}

// Splash Screen added to check the login state and auto-login
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  read() {
    Timer(Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getBool('state') ?? false;
      if (value != true) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Navigator.pushReplacementNamed(context, 'mainScreen');
      }
    });
  }

  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset('images/logo1.png'),
      ),
    );
  }
}
