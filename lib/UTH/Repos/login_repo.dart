import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:scouts_minia/UTH/Repos/repo.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  final url = '${Repo.baseUrl}/user/login';
  var message;

  Future login({@required email, @required password}) async {
    try {
      await http.post(url,
          headers: {'Accept': 'application/json'},
          body: {"email": "$email", "password": "$password"}).then((response) {
        if (response.statusCode != 200 ||
            response.body.toLowerCase().contains('error'))
          message = 'error';
        else if (response.body.contains('unauthenticated')) {
          message = 'noUser';
        } else {
          message = jsonDecode(response.body.trim());
        }
        return message;
      }).catchError((e) {
        message = 'noUser';
        return message;
      });
    } catch (e) {
      message = 'noUser';
      return message;
    }
  }
}
