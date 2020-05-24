import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scouts_minia/UI/components/form.dart';
import 'package:scouts_minia/tools/network_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final _key = GlobalKey<FormBuilderState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  File _image;
  String base64Image;
  SharedPreferences prefs;

  Future getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    base64Image = base64Encode(_image.readAsBytesSync());
  }

  @override
  void initState() {
    super.initState();
    getPrefs().then((val) {
      _usernameController.text = prefs.getString('name');
      _emailController.text = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit account'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: FormBuilder(
          key: _key,
          child: Column(
            children: <Widget>[
              Center(
                child: FormBuilderCustomField(
                  attribute: 'image',
                  formField: FormField(
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: getImage,
                          child: _image == null
                              ? Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white.withOpacity(0),
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0),
                                          style: BorderStyle.solid,
                                          width: 1)),
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://via.placeholder.com/350x150",
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(),
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(_image),
                                  )),
                        ),
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
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                      labelText: 'name',
                      labelStyle: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyText1.color),
                      hintText: 'ScoutBoy',
                      hintStyle: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyText1.color),
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
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                      labelText: 'email',
                      labelStyle: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyText1.color),
                      hintText: 'i_love@scout.com',
                      hintStyle: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyText1.color),
                      alignLabelWithHint: true),
                  controller: _emailController,
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email()
                  ],
                ),
              ),
              FormButton(onPressed: () {
                if (_key.currentState.validate()) {
                  NetworkManager().editData(_usernameController.text.trim(),
                      _emailController.text.trim(), base64Image);
                }
              })
            ],
          ),
        ),
      )),
    );
  }
}
