import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ArchiveRepo {
  final String url =
      'http://www.json-generator.com/api/json/get/bVdHHNnsmW?indent=2';
  var message;
  Future getArchive() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('api_token');
      await http.get(
        'http://www.json-generator.com/api/json/get/bVdHHNnsmW?indent=2',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer  $token'
        },
      ).then((response) {
        if (response.statusCode != 200 ||
            response.body.toLowerCase().contains('error')) {
          message = 'error';
          return;
        } else {
          message = jsonDecode(response.body.trim());
          return;
        }
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
