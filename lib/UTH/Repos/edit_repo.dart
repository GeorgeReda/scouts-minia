import 'dart:convert';

import 'package:scouts_minia/UTH/Repos/repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class EditRepo {
  final String url = '${Repo.baseUrl}'; // Todo: modify the URL
  final String name, email;
  final image;

  EditRepo({@required this.name, @required this.email, @required this.image});
  edit() {
    try {
      http.post(url, headers: {
        'Accept': 'application/json'
      }, body: {
        "name": "$name",
        "email": "$email",
        "image": image
      }).then((response) {
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
