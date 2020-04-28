import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scouts_minia/routes/accountDetails.dart';
import 'package:scouts_minia/tools/themeChanger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'login.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('data'),
            accountEmail: Text('data'),
            currentAccountPicture: Image.asset('images/logo.png'),
            arrowColor: Constants.darkText,
          ),
          ReusableListTile(
            title: 'Edit account',
            icon: FontAwesomeIcons.exchangeAlt,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountDetails()));
            },
          ),
          Card(
            color: Theme.of(context).backgroundColor,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.all(8),
            child: SwitchListTile(
                title: Text(
                  'Change Theme',
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
                            //Todo: Remove Shared Prefs
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
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
          RaisedButton(onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            print(prefs.getString('api token'));
            print(prefs.getString('name'));
            print(prefs.getString('email'));
            print(prefs.getString('image'));
          })
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
          color:Constants.darkPrimary,
        ),
        onTap: onTap,
      ),
    );
  }
}
