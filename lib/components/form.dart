import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class ReusableFormField extends StatelessWidget {
  final String id;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool secure;
  final TextEditingController controller;

  final Widget suffix;

  const ReusableFormField({
    Key key,
    this.keyboardType,
    @required this.labelText,
    @required this.hintText,
    @required this.icon,
    @required this.controller,
    @required this.secure,
    @required this.id, this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        obscureText: secure,
        keyboardType: keyboardType,
        toolbarOptions: ToolbarOptions(
            selectAll: false, copy: false, cut: false, paste: false),
        decoration: InputDecoration(
          suffix: suffix,
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          hintText: hintText,
          icon: FaIcon(icon),
        ),
        textDirection: TextDirection.ltr,
        validator: (val) {
          if (val.isEmpty && id != 'phone') {
            return 'Please enter valid $id';
          } else if (id.toLowerCase().trim() == 'phone') {
            if(controller.text.length != 11){
              return 'Please enter a valid number!';
            }
          } else if (id.toLowerCase().trim() == 'password' && id.length != 8) {
            return 'Password must be more than 8 numbers';
          }
          return null;
        },
      ),
    );
  }
}
