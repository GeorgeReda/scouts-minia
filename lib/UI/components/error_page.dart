import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String text;
  const ErrorPage({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            size: 42,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 22),
          )
        ],
      )),
    );
  }
}
