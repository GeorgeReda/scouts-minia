import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/reusable_list_tile.dart';
import '../../constants.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String name;
  String email;
  String image;

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');
      image = prefs.getString('image');
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          // shows the user's info
          UserAccountsDrawerHeader(
            accountName: Text(
              '$name',
              style: TextStyle(color: Constants.darkText, fontSize: 18),
            ),
            accountEmail: Text(
              '$email',
              style: TextStyle(color: Constants.darkText, fontSize: 16),
            ),
            currentAccountPicture: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  'http://via.placeholder.com/350x150',
                ),
              ),
            ),
            arrowColor: Constants.darkText,
          ),
          ReusableListTile(
            title: 'Edit account',
            icon: FontAwesomeIcons.exchangeAlt,
            onTap: () {
              Get.toNamed('accountDetails');
            },
          ),
          ReusableListTile(
              title: 'Change Theme',
              icon: FontAwesomeIcons.lightbulb,
              onTap: () {
                Get.dialog(AlertDialog(
                  backgroundColor: Theme.of(context).backgroundColor,
                  titleTextStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 18),
                  title: Text('Change Theme'),
                  actions: <Widget>[
                    RaisedButton(
                        onPressed: () {
                          Get.close(1);
                          Get.changeThemeMode(ThemeMode.light);
                        },
                        child: Text('light')),
                    RaisedButton(
                        onPressed: () {
                          Get.close(1);
                          Get.changeThemeMode(ThemeMode.dark);
                        },
                        child: Text('dark')),
                  ],
                ));
              }),
          ReusableListTile(
            title: 'Logout',
            icon: FontAwesomeIcons.signOutAlt,
            onTap: () {
              Get.dialog(AlertDialog(
                backgroundColor: Theme.of(context).backgroundColor,
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18),
                title: Text('Are you sure you want to logout?'),
                actions: <Widget>[
                  RaisedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        Get.offAndToNamed('login');
                      },
                      child: Text('yes')),
                  RaisedButton(
                      onPressed: () {
                        Get.close(1);
                      },
                      child: Text('no')),
                ],
              ));
            },
          ),
        ],
      )),
    );
  }
}
