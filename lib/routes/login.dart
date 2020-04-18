import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scouts_minia/components/form.dart';
import 'package:scouts_minia/components/login_logo.dart';
import 'package:scouts_minia/constants.dart';
import 'package:scouts_minia/routes/register.dart';
import 'package:scouts_minia/tools/network_manager.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool secureText = true;
  IconData icon = FontAwesomeIcons.eyeSlash;
  togglePassword(){
    setState(() {
      secureText = !secureText;
      if(icon ==FontAwesomeIcons.eyeSlash){
        icon = FontAwesomeIcons.eye;
      } else{
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
          child: Stack(children: <Widget>[
            ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Logo(),
                ReusableFormField(
                  id: 'email',
                  controller: _emailController,
                  secure: false,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'EMAIL',
                  hintText: 'i_love@scout.com',
                  icon: FontAwesomeIcons.solidEnvelope,
                ),
                ReusableFormField(
                  id: 'password',
                  controller: _passwordController,
                  secure: true,
                  labelText: 'PASSWORD',
                  hintText: 'Something your friends doesn\'t know',
                  icon: FontAwesomeIcons.lock,
                  suffix: IconButton(icon: FaIcon(icon,color: Constants.lightPrimary), onPressed: togglePassword),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5),
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
                    onPressed: () {
                      _key.currentState.validate();
                      if (_key.currentState.validate()) {
                        NetworkManager().loginData(_emailController.text.trim(),
                            _passwordController.text.trim(), context);
                      }
                    }),
                Center(child: Text('Dont have an account ?')),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Center(
                    child: GestureDetector(
                      child: Text('Register Now'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
