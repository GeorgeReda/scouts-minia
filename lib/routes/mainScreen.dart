import 'package:flutter/material.dart';
import 'package:scouts_minia/components/bottomNavBar.dart';
import 'package:scouts_minia/components/news.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List pages = [
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NewsSections(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
