import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:scouts_minia/UTH/Repos/repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPostRepo {
  final String url = '${Repo.baseUrl}/addposts';
  var message;
  AddPostRepo();
  Future addPost({@required title, @required content, @required image}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('api_token');
      print(token);
      await http.post(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        "title": "$title",
        "content": "$content",
        "image": "$image"
      }).then((response) {
        print(response.body);
        print(response.statusCode);
        if (response.statusCode != 200 ||
            response.body.toLowerCase().contains('error')) {
          message = 'error';
        } else {
          message = null;
        }
        return message;
      }).catchError((e) {
        message = 'error';
        return message;
      });
    } catch (e) {
      message = 'error';
      return message;
    }
  }
}
