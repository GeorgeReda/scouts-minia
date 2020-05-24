import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModDialog {
    showModDialog(
  String title,
) {
  Get.dialog(AlertDialog(
    backgroundColor: Get.theme.backgroundColor,
    titleTextStyle: Get.theme.textTheme.bodyText1.copyWith(fontSize: 18),
    title: Text(title),
    actions: <Widget>[
      RaisedButton(
          onPressed: () {
            Get.close(1);
          },
          child: Text('Ok')),
    ],
  ));
}

}