import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scouts_minia/UI/components/mod_dialog.dart';
import 'package:scouts_minia/UTH/Blocs/RegisterBloc/register_bloc.dart';

import '../../constants.dart';
import '../components/form.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormBuilderState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final RegisterBloc _bloc = RegisterBloc();

  File _image;
  String base64Image;
  bool secureText = true;
  IconData icon = FontAwesomeIcons.eyeSlash;

  getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    if (image != null) {
      base64Image = base64Encode(_image.readAsBytesSync());
    }
  }

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
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading)
            Get.dialog(Constants.circularProgressIndicator);
          else if (state is RegisterFailure) {
            Get.close(1);
            if (state.error == 'error')
              ModDialog()
                  .showModDialog('An error has occurred . Please try again !');
            else if (state.error == 'alreadyUser')
              ModDialog().showModDialog('Already a user . Please Login !');
          } else if (state is ReigisterDone) {
            Get.close(2);
            ModDialog().showModDialog(
                'Account registred successfully . Please login !');
          }
        },
        child: Scaffold(
          backgroundColor: Constants.lightBG,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'images/logo.png',
                      width: MediaQuery.of(context).size.width / 1,
                      color: Constants.lightPrimary,
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Constants.lightPrimary, fontSize: 32),
                    ),
                  ),
                  FormBuilder(
                    key: _key,
                    child: Column(
                      children: <Widget>[
                        FormBuilderCustomField(
                          attribute: 'image',
                          formField: FormField(
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: GestureDetector(
                                  onTap: getImage,
                                  child: _image == null
                                      ? Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color:
                                                  Colors.white.withOpacity(0),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  style: BorderStyle.solid,
                                                  width: 1)),
                                          child: Center(
                                              child: FaIcon(
                                                  FontAwesomeIcons.plus)),
                                        )
                                      : Container(
                                          height: 150,
                                          width: 150,
                                          child: Image.file(
                                            _image,
                                            fit: BoxFit.fill,
                                          )),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FormBuilderTextField(
                            attribute: 'name',
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelText: 'name',
                              labelStyle: TextStyle(fontSize: 18),
                            ),
                            controller: _usernameController,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                          ),
                        ),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FormBuilderTextField(
                            attribute: 'phone',
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelText: 'Phone',
                              labelStyle: TextStyle(fontSize: 18),
                            ),
                            controller: _phoneController,
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.minLength(11,
                                  errorText: 'Phone number length must be 11'),
                              FormBuilderValidators.maxLength(11,
                                  errorText: 'Phone number length must be 11'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  FormButton(onPressed: () {
                    if (_key.currentState.validate()) {
                      _bloc.add(RegisterButtonPressed(
                          name: _usernameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          phone: _phoneController.text.trim(),
                          image: base64Image));
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
