import 'dart:convert';

import 'package:scouts_minia/UTH/Repos/repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class EditRepo {
  final String url = '${Repo.baseUrl}'; // Todo: modify the URL
  var message;
  Future edit(
      {@required String name,
      @required String email,
      @required String image}) async {
    try {
      await http.post(url, headers: {
        'Accept': 'application/json'
      }, body: {
        "name": "$name",
        "email": "$email",
        "image": "$image"
      }).then((response) {
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
