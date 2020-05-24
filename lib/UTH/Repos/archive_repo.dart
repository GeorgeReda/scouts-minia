import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class ArchiveRepo {
  final String url =
      'http://www.json-generator.com/api/json/get/bVdHHNnsmW?indent=2';
  final String token;

  ArchiveRepo({@required this.token});
  getArchive() {
    try {
      http.get(
        'http://www.json-generator.com/api/json/get/bVdHHNnsmW?indent=2',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer  $token'
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
