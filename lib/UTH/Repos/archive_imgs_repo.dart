import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ArchiveImgsRepo {
  final String url =
      'http://www.json-generator.com/api/json/get/ceapRxXwqG?indent=2';
  var message;

  Future getArchive() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('api_token');
      await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer  $token'
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
