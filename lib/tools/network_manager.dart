import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scouts_minia/components/posts.dart';
import 'package:scouts_minia/routes/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
 //Todo: Add Shared Prefs
class NetworkManager {
  String serverUrl = 'http://scoutsapp1.000webhostapp.com/public/api';
  var status;
  var token;

  loginData(String email, String password, BuildContext context) async {
    try {
      String myUrl = '$serverUrl/user/login';
      final response = await http.post(myUrl,
          headers: {'Accept': 'application/json'},
          body: {"email": "$email", "password": "$password"});
      print(response.statusCode);
      print(response.request.toString());
      status = response.body.contains('error');
      var data = jsonDecode(response.body.trim());
      if (status) {
        print('data : ${data["error"]}');
      } else {
        print('data : ${data["api token"]}');
        save('api token',data["api token"]);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ));
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  registerData(String name, String email, String password, String phone, image,
      context) async {
    try {
      if (null == image) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('An error has occurred ! Please try again .'),
          ),
          duration: Duration(seconds: 2),
        ));
      }
      String fileName = image.path.split('/').last;
      String myUrl = '$serverUrl/user/register';
      final response = await http.post(myUrl, headers: {
        'Accept': 'application/json'
      }, body: {
        "name": "$name",
        "email": "$email",
        "password": "$password",
        "image": image
      });
      status = response.body.contains('error');
      var data = jsonDecode(response.body.trim());
      if (status) {
        print('data : ${data["error"]}');
      } else {
        print('data : ${data["api token"]}');
        save('api token',data["api token"]);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    } catch (e) {
      print(e);
    }
  }

  logOut() {
    save('api token','out');
  }

  Future getPosts() async {
    try {
      var tokenVal = read('api token');
      http.Response response = await http.get(
        'http://www.json-generator.com/api/json/get/cjRAjawitK?indent=2',
//      '$serverUrl/showpost',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenVal'
        },
      );
      var jsonData = json.decode(response.body);
      List<PostItem> posts = [];
      for (var i in jsonData) {
        PostItem post = PostItem(
          name: i['name'],
          about: i['about'],
          dp: i['dp'],
          email: i['email'],
          index: i['index'],
          pic: i['picture'],
          date: i['date'],
          details: i['details'],
        );
        posts.add(post);
      }
      return posts;
    } catch (e) {
      print(e);
      throw AlertDialog(
        title: Text('Couldn\' get posts . Please Check your connetction '),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.error_outline),
          )
        ],
      );
    }
  }

  Future getBooks() async {
    try {
      var tokenVal = read('api token');
      http.Response response = await http.get(
        'http://www.json-generator.com/api/json/get/cjRAjawitK?indent=2',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenVal'
        },
      );
      var jsonData = json.decode(response.body);
      List<PostItem> books = [];
    } catch (e) {}
  }
}
