import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorPage extends StatelessWidget {
  final String text;
  const ErrorPage({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 22),
          ),
          Icon(
            Icons.error_outline,
            size: 22,
            color: Theme.of(context).textTheme.bodyText1.color,
          )
        ],
      )),
    );
  }
}
