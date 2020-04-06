import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scouts_minia/components/news.dart';
import 'package:scouts_minia/routes/archive.dart';
import 'package:scouts_minia/routes/competitions.dart';
import 'package:scouts_minia/routes/library.dart';
import 'package:scouts_minia/routes/settings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();
  int _pageIndex = 0;
  final List<Widget> _pages = [
    NewsSections(),
    Library(),
    Archive(),
    Competitions(),
    Settings()
  ];

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

  onChangedPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  onTapChangePage(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
    _pageController.animateToPage(_pageIndex,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        body: PageView(
//          controller: _pageController,
//          physics: NeverScrollableScrollPhysics(),
//          children: _pages),
      body: PageView.builder(
        onPageChanged: onChangedPage,
        itemCount: _pages.length,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) => _pages[index],
      ),
      bottomNavigationBar: Theme(
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
            currentIndex: _pageIndex,
            onTap: onTapChangePage,
            items: _items,
          )),
    );
  }
}
