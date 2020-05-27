import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scouts_minia/UI/components/form.dart';
import 'package:scouts_minia/UI/components/mod_dialog.dart';
import 'package:scouts_minia/UTH/Blocs/EditBloc/edit_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final _key = GlobalKey<FormBuilderState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final EditBloc _bloc = EditBloc();
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
      body: BlocListener<EditBloc, EditState>(
        bloc: _bloc,
        listener: (BuildContext context, EditState state) {
          if (state is EditLoading)
            Get.dialog(Constants.circularProgressIndicator);
          else if (state is EditFailure) {
            Get.close(1);
            ModDialog()
                .showModDialog('An error has occurred . Please try again !');
          } else if (state is EditDone) {
            Get.close(1);
            ModDialog().showModDialog('Editing done successfully .');
          }
        },
        child: SafeArea(
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
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black12,
                                      child: Icon(
                                        Icons.image,
                                        size: 50,
                                        color:
                                            Theme.of(Get.context).primaryColor,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 150,
                                    height: 150,
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
                    _bloc.add(OnButtonPressed(
                        name: _usernameController.text.trim(),
                        email: _emailController.text.trim(),
                        image: base64Image));
                  }
                })
              ],
            ),
          ),
        )),
      ),
    );
  }
}
