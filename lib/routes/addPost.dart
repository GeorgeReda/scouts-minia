import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scouts_minia/components/form.dart';
import 'package:scouts_minia/tools/network_manager.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _key = GlobalKey<FormBuilderState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File _image;
  String base64Image;

  getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    base64Image = base64Encode(_image.readAsBytesSync());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: FormBuilder(
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
                                      borderRadius: BorderRadius.circular(100),
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
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.fill)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    maxLength: 150,
                    attribute: 'name',
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                        focusColor: Colors.red,
                        labelText: 'title',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyText1.color),
                        hintText: 'title',
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyText1.color),
                        alignLabelWithHint: true),
                    controller: _titleController,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    attribute: 'description',
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                        labelText: 'description',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyText1.color),
                        hintText: 'title',
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyText1.color),
                        alignLabelWithHint: true),
                    controller: _descriptionController,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
                FormButton(onPressed: () {
                  if (_key.currentState.validate()) {
                    NetworkManager().addPost(
                        _titleController.text.trim(),
                        _descriptionController.text.trim(),
                        base64Image,
                        context);
                  }
                })
              ],
            )),
      )),
    );
  }
}
