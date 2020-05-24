import 'dart:convert';

import 'package:scouts_minia/UTH/Repos/repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class RegisterRepo {
  final String url = '${Repo.baseUrl}/user/register';
  var message;
  Future register(
      {@required name,
      @required email,
      @required password,
      @required mobile,
      @required image}) async {
    try {
      await http.post(url, headers: {
        'Accept': 'application/json'
      }, body: {
        "name": "$name",
        "email": "$email",
        "password": "$password",
        "mobile": "${int.parse(mobile)}",
        "image": "$image"
      }).then((response) {
        if (response.statusCode == 500 ||
            response.body.contains('users_email_unique')) {
          message = 'alreadyUser';
        } else if (response.statusCode != 200 ||
            response.body.toLowerCase().contains('error')) {
          message = 'error';
        } else {
          message = jsonDecode(response.body.trim());
        }
        return message;
      }).catchError((e) {
        message = 'alreadyUser';
        return message;
      });
    } catch (e) {
      message = 'error';
      return message;
    }
  }
}
