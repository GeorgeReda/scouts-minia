import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scouts_minia/components/posts.dart';
import 'package:scouts_minia/routes/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      status = response.body.contains('error');
      var data = jsonDecode(response.body.trim());
      if (status) {
        print('data : ${data["error"]}');
      } else {
        print('data : ${data["api token"]}');
        save(data["api token"]);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ));
      }
    } catch (e) {
      print(e);
    }
  }

  registerData(
      String name, String email, String password, String phone, context) async {
    try {
      String myUrl = '$serverUrl/user/register';
      final response = await http.post(myUrl,
          headers: {'Accept': 'application/json'},
          body: {"name": "$name", "email": "$email", "password": "$password"});
      status = response.body.contains('error');
      var data = jsonDecode(response.body.trim());
      if (status) {
        print('data : ${data["error"]}');
      } else {
        print('data : ${data["api token"]}');
        save(data["api token"]);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    } catch (e) {
      print(e);
    }
  }

  logOut() {
    save('0');
  }

  save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('api token') ?? 0;
    return value;
  }

  Future getPosts() async {
    try {
      var tokenVal = read();
      http.Response response = await http.get(
        'http://www.json-generator.com/api/json/get/cjRAjawitK?indent=2',
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
    }
  }
}
