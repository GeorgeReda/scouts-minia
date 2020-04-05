import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;

  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.newspaper),
        title: Center(child: Text('الأخبار'))),
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.book),
        title: Center(child: Text('المكتبة'))),
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.archive),
        title: Center(
          child: Text('الأرشيف'),
        )),
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.gamepad),
        title: Center(child: Text('المسابقات'))),
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.cog),
        title: Center(child: Text('الإعدادات'))),
  ];

  changeTab(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Theme.of(context).accentColor,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.grey[500]),
              ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _page,
          onTap: changeTab,
          items: _items,
        ));
  }
}
