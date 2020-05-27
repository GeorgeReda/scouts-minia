import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FilesRepo {
  final String section;
  String url;
  var message;
  FilesRepo({@required this.section});
  getUrl() {
    // Todo : modify urls
    section == 'library'
        ? url = 'http://www.json-generator.com/api/json/get/cfYmFEaPyq?indent=2'
        : url = 'http://www.json-generator.com/api/json/get/cfYmFEaPyq?indent=2';
  }

  Future getFiles() async {
    try {
      await getUrl();
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('api_token');
      await http.get(
        '$url',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer Token $token'
        },
      ).then((response) {
        if (response.statusCode != 200 ||
            response.body.toLowerCase().contains('error'))
          message = 'error';
        else
          message = json.decode(response.body.trim());
        return;
      }).catchError((e) {
        message = 'error';
        return;
      });
    } catch (e) {
      message = 'error';
      return;
    }
  }
}
