import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

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
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
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
