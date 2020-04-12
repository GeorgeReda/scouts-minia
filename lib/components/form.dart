import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scouts_minia/tools/network_manager.dart';

import '../constants.dart';

class FormButton extends StatelessWidget {

  final String email;
  final String password;

  const FormButton({
    Key key,
    @required GlobalKey<
        FormState> form, @required this.email, @required this.password
  })
      : _form = form,
        super(key: key);

  final GlobalKey<FormState> _form;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 40, horizontal: MediaQuery
          .of(context)
          .size
          .width / 6),
      child: RaisedButton(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery
                .of(context)
                .size
                .height / 50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          textColor: Colors.white,
          color: Constants.lightPrimary,
          child: Text('Submit'),
          onPressed: () {
            if (_form.currentState.validate()) {
              NetworkManager().loginData(email, password,context);
            }
          }),
    );
  }
}

class ReusableFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool secure;
  final TextEditingController controller;

  const ReusableFormField({
    Key key,
    this.keyboardType,
    @required this.labelText,
    @required this.hintText,
    @required this.icon,
    @required this.controller,
    this.secure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        obscureText: secure,
        keyboardType: keyboardType,
        toolbarOptions: ToolbarOptions(
            selectAll: false, copy: false, cut: false, paste: false),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          hintText: hintText,
          icon: FaIcon(icon),
        ),
        textDirection: TextDirection.ltr,
        validator: (val) {
          if (val.isEmpty) {
            return 'Please enter valid $labelText';
          }
          return null;
        },
      ),
    );
  }
}
