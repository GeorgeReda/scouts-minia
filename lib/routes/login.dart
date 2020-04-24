import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  final _key = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Logo(),
            FormBuilder(
              key: _key,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderTextField(
                      attribute: 'email',
                      enableInteractiveSelection: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: 'email',
                          labelStyle: TextStyle(fontSize: 18),
                          hintText: 'i_love@scout.com',
                          hintStyle: TextStyle(fontSize: 18),
                          alignLabelWithHint: true),
                      controller: _emailController,
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderTextField(
                      attribute: 'password',
                      maxLines: 1,
                      obscureText: secureText,
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        labelText: 'password',
                        labelStyle: TextStyle(fontSize: 18),
                        hintText: 'Something your friends doesn\'t know',
                        hintStyle: TextStyle(fontSize: 18),
                        alignLabelWithHint: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              icon: FaIcon(
                                icon,
                                color: Constants.lightPrimary,
                              ),
                              onPressed: togglePassword),
                        ),
                      ),
                      controller: _passwordController,
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.min(8)
                      ],
                    ),
                  ),
                ],
              ),
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
            FormButton(onPressed: () {
              _key.currentState.validate();
              if (_key.currentState.validate()) {
                NetworkManager().loginData(_emailController.text.trim(),
                    _passwordController.text.trim(), context);
              }
            }),
            Center(
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Text('Don\'t have an account?'),
                    Text('Register Now')
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
