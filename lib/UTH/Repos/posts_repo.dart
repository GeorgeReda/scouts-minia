import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostsRepo {
  var message;
  Future get() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('api_token');
      await http.get(
        'http://www.json-generator.com/api/json/get/bTVHlfWTLS?indent=2',
        // '${Repo.baseUrl}/showpost',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).then((response) {
        if (response.statusCode != 200 ||
            response.body.toLowerCase().contains('error')) {
          message = 'error';
        } else {
          message = jsonDecode(response.body.trim());
        }
        return ;
      });
    } catch (e) {
      message = 'error';
      return ;
    }
  }
}
