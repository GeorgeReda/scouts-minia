import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scouts_minia/routes/mainScreen.dart';

import '../components/form.dart';
import '../constants.dart';
import '../tools/network_manager.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool secureText = true;
  IconData icon = FontAwesomeIcons.eyeSlash;

  togglePassword() {
    setState(() {
      secureText = !secureText;
      if (icon == FontAwesomeIcons.eyeSlash) {
        icon = FontAwesomeIcons.eye;
      } else {
        icon = FontAwesomeIcons.eyeSlash;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.lightBG,
      body: SafeArea(
        child: Form(
            key: _key,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  width: MediaQuery.of(context).size.width / 3,
                  color: Constants.lightPrimary,
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Center(
                  child: Text(
                    'Register',
                    style:
                        TextStyle(color: Constants.lightPrimary, fontSize: 32),
                  ),
                ),
                ReusableFormField(
                  id: 'name',
                  secure: false,
                  labelText: 'Username',
                  hintText: 'ScoutBoy',
                  icon: FontAwesomeIcons.userCircle,
                  controller: _usernameController,
                ),
                ReusableFormField(
                  id: 'email',
                  secure: false,
                  labelText: 'email',
                  hintText: 'life_is@scout.com',
                  icon: Icons.alternate_email,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                ReusableFormField(
                  id: 'password',
                  secure: secureText,
                  labelText: 'Password',
                  hintText: 'S*12K3#kbda',
                  icon: FontAwesomeIcons.lock,
                  controller: _passwordController,
                  suffix: IconButton(
                      icon: FaIcon(icon, color: Constants.lightPrimary),
                      onPressed: togglePassword),
                ),
                ReusableFormField(
                  labelText: 'Phone',
                  hintText: '0123456789',
                  icon: FontAwesomeIcons.phone,
                  controller: _phoneController,
                  secure: false,
                  id: 'phone',
                  keyboardType: TextInputType.phone,
                ),
                FormButton(onPressed: () {
                  if (_key.currentState.validate()) {
                    NetworkManager().registerData(
                        _usernameController.text.trim(),
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        _phoneController.text.trim(),
                        context);
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                })
              ],
            )),
      ),
    );
  }
}
