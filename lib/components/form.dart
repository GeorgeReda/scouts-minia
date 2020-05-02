import 'package:flutter/material.dart';

import '../constants.dart';

class FormButton extends StatelessWidget {
  final onPressed;

  const FormButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: 40, horizontal: MediaQuery.of(context).size.width / 6),
        child: RaisedButton(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          textColor: Colors.white,
          color: Constants.lightPrimary,
          child: Text('Submit'),
          onPressed: onPressed,
        ));
  }
}
