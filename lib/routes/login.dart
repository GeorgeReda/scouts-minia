import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scouts_minia/components/form.dart';
import 'package:scouts_minia/components/login_logo.dart';
import 'package:scouts_minia/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _form = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.lightBG,
      body: SafeArea(
        child: Form(
          key: _form,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Logo(),
              ReusableFormField(
                controller: _emailController,
                secure: false,
                keyboardType: TextInputType.emailAddress,
                labelText: 'EMAIL',
                hintText: 'i_love@scout.com',
                icon: FontAwesomeIcons.solidEnvelope,
              ),
              ReusableFormField(
                controller: _passwordController,
                secure: true,
                labelText: 'PASSWORD',
                hintText: 'Something your friends doesn\'t know',
                icon: FontAwesomeIcons.lock,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 1.5),
                child: GestureDetector(
                  onTap: () {
                    // Todo: Add what must be done
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: Constants.lighterBlack,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              FormButton(
                form: _form,
                email: _emailController.text,
                password: _passwordController.text,
              )
            ],
          ),
        ),
      ),
    );
  }
}
