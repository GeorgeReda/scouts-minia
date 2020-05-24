import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scouts_minia/UI/routes/addPost.dart';
import 'package:scouts_minia/UI/routes/login.dart';
import 'package:scouts_minia/UI/routes/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'UI/routes/accountDetails.dart';
import 'UI/routes/mainScreen.dart';
import 'constants.dart';

//Todo: implement [Get]
main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nor El Alam Scouts',
      home: SplashScreen(),
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      themeMode: ThemeMode.light,
      defaultTransition: Transition.fade,
      namedRoutes: {
        'mainScreen': GetRoute(page: MainScreen()),
        'login': GetRoute(page: Login()),
        'register': GetRoute(page: Register()),
        'addPost': GetRoute(page: AddPost()),
        'accountDetails': GetRoute(page: AccountDetails())
      },
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
        Get.toNamed('login');
      } else {
        Get.toNamed('mainScreen');
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
        child: Image.asset('images/logo1.jpg'),
      ),
    );
  }
}
