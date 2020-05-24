import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class FilesRepo {
  final String section, token;
  String url;
  FilesRepo({@required this.token, @required this.section});
  void getUrl() {
    // Todo : modify urls
    section == 'library'
        ? url = 'http://www.json-generator.com/api/json/get/cfYmFEaPyq?indent=2'
        : 'http://www.json-generator.com/api/json/get/cfYmFEaPyq?indent=2';
  }

  getFiles() {
    try {
      getUrl();
      http.get(
        '$url',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer Token $token'
        },
      ).then((response) {
        if (response.statusCode != 200 ||
            response.body.toLowerCase().contains('error'))
          return 'error';
        else
          return json.decode(response.body.trim());
      }).catchError((e) => 'error');
    } catch (e) {
      return 'error';
    }
  }
}
