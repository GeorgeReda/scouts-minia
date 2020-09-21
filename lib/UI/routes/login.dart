import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scouts_minia/UI/components/form.dart';
import 'package:scouts_minia/UI/components/login_logo.dart';
import 'package:scouts_minia/UI/components/mod_dialog.dart';
import 'package:scouts_minia/UTH/Blocs/LoginBloc/login_bloc.dart';
import 'package:scouts_minia/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginBloc _bloc = LoginBloc();
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
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading)
            Get.dialog(Constants.circularProgressIndicator);
          else if (state is LoginFailure) {
            Get.close(1);
            if (state.error == 'noUser') {
              ModDialog().showModDialog(
                  'There is no user with this account . Please register !');
            } else if (state.error == 'error') {
              ModDialog()
                  .showModDialog('An error has occurred . Please try again !');
            }
          } else if (state is LoginDone) Get.offAllNamed('mainScreen');
        },
        child: Scaffold(
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
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            labelText: 'email',
                            labelStyle: TextStyle(fontSize: 18),
                          ),
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            labelText: 'password',
                            labelStyle: TextStyle(fontSize: 18),
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
                    _bloc.add(LoginButtonPressed(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim()));
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
                      Get.toNamed('register');
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
