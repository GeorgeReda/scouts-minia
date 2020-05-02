import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scouts_minia/tools/network_manager.dart';
import 'package:scouts_minia/tools/themeChanger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String name;
  String email;
  String image;

  Future<Null> getSharedPrefs() async {
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
              style: TextStyle(color: Constants.darkText, fontSize: 22),
            ),
            accountEmail: Text(
              '$email',
              style: TextStyle(color: Constants.darkText, fontSize: 18),
            ),
            currentAccountPicture: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage('http://placehold.it/300x300'),
              ),
            ),
            arrowColor: Constants.darkText,
          ),
          ReusableListTile(
            title: 'Edit account',
            icon: FontAwesomeIcons.exchangeAlt,
            onTap: () {
              Navigator.pushNamed(context, 'accountDetails');
            },
          ),
          Card(
            color: Theme.of(context).backgroundColor,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.all(8),
            child: SwitchListTile(
                title: Text(
                  'Dark Mode',
                  style:
                      Theme.of(context).textTheme.body1.copyWith(fontSize: 18),
                ),
                activeColor: Constants.lightPrimary,
                value: Provider.of<ThemeChanger>(context).isDarkMode,
                onChanged: (val) {
                  Provider.of<ThemeChanger>(context, listen: false)
                      .updateTheme(val);
                }),
          ),
          ReusableListTile(
            title: 'Logout',
            icon: FontAwesomeIcons.signOutAlt,
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).backgroundColor,
                    titleTextStyle: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 18),
                    title: Text('Are you sure you want to logout?'),
                    actions: <Widget>[
                      RaisedButton(
                          onPressed: () {
                            NetworkManager().logOut();
                            Navigator.pushReplacementNamed(context, 'login');
                          },
                          child: Text('yes')),
                      RaisedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: Text('no')),
                    ],
                  );
                },
              );
            },
          ),
        ],
      )),
    );
  }
}

class ReusableListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const ReusableListTile({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).backgroundColor,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 18),
        ),
        trailing: FaIcon(
          icon,
          color: Constants.darkPrimary,
        ),
        onTap: onTap,
      ),
    );
  }
}
