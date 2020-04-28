import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scouts_minia/routes/mainScreen.dart';

import '../components/form.dart';
import '../constants.dart';
import '../tools/network_manager.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormBuilderState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  File _image;
  String base64Image;
  String errMessage = 'Error uploading image';
  bool secureText = true;
  IconData icon = FontAwesomeIcons.eyeSlash;

  getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    base64Image = base64Encode(_image.readAsBytesSync());
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
    return Scaffold(
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
                  style: TextStyle(color: Constants.lightPrimary, fontSize: 32),
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
                                          color: Colors.white.withOpacity(0),
                                          border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 1)),
                                      child: Center(
                                          child: FaIcon(FontAwesomeIcons.plus)),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(),
                                      child: Image.file(_image,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.fill)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        attribute: 'name',
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            labelText: 'name',
                            labelStyle: TextStyle(fontSize: 18),
                            hintText: 'ScoutBoy',
                            hintStyle: TextStyle(fontSize: 18),
                            alignLabelWithHint: true),
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
                          hintText: 'Adg34Swr2',
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        attribute: 'phone',
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            labelText: 'Phone',
                            labelStyle: TextStyle(fontSize: 18),
                            hintText: '01234567890',
                            hintStyle: TextStyle(fontSize: 18),
                            alignLabelWithHint: true),
                        controller: _phoneController,
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.minLength(11),
                          FormBuilderValidators.maxLength(11)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              FormButton(onPressed: () {
                if (_key.currentState.validate()) {
                  NetworkManager().registerData(
                      _usernameController.text.trim(),
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      _phoneController.text.trim(),
                      base64Image,
                      context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
