import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scouts_minia/components/archive_image_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkManager {
  final String serverUrl = 'http://scoutsapp1.000webhostapp.com/public/api';
  var status;

  // Logging in and saving the info of the user
  loginData(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String myUrl = '$serverUrl/user/login';
      http.post(myUrl,
          headers: {'Accept': 'application/json'},
          body: {"email": "$email", "password": "$password"}).then((response) {
        var data = jsonDecode(response.body.trim());
        if (response.body.contains('unauthenticated')) {
          showModDialog(
              'There is no user with this account . Please register !');
        }
        if (response.body.contains('error')) {
        } else {
          prefs
            ..setBool('state', true)
            ..setString('api_token', data["api_token"])
            ..setString('name', data["name"])
            ..setString('email', data["email"])
            ..setInt('mobile', data["mobile"])
            ..setString('image', data["image"]);
          Get.offAllNamed('mainScreen');
        }
      });
    } catch (e) {
      showModDialog('An error has occurred . Please try again !');
    }
  }

  // Registering and saving the info of the user

  registerData(
    String name,
    String email,
    String password,
    String mobile,
    String image,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String myUrl = '$serverUrl/user/register';
      http.post(myUrl, headers: {
        'Accept': 'application/json'
      }, body: {
        "name": "$name",
        "email": "$email",
        "password": "$password",
        "mobile": "${int.parse(mobile)}",
        "image": "$image"
      }).then((response) {
        status = response.body.contains('error');
        var data = jsonDecode(response.body.toString().trim());
        if (status) {
          showModDialog('An error has occurred . Please try again !');
        } else {
          prefs
            ..setBool('state', true)
            ..setString('api_token', data["api_token"])
            ..setString('name', name)
            ..setString('email', email)
            ..setInt('mobile', int.parse(mobile))
            ..setString('image', image);
          Get.offAllNamed('mainScreen');
        }
      });
    } catch (e) {
      showModDialog('An error has occurred . Please try again !');
    }
  }

  // Logging out and removing all user's data from the device
  logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  // Editing user's data in the device and globally
  editData(
    String name,
    String email,
    image,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String myUrl = '$serverUrl/'; //Todo: Change Url
      http.post(myUrl, headers: {
        'Accept': 'application/json'
      }, body: {
        "name": "$name",
        "email": "$email",
        "image": image
      }).then((response) {
        status = response.body.contains('error');
        var data = jsonDecode(response.body.trim());
        if (status) {
          showModDialog(data);
        } else {
          prefs
            ..setString('name', name)
            ..setString('email', email)
            ..setString('image', image);
          Get.close(1);
        }
      });
    } catch (e) {
      showModDialog('An error has occurred . Please try again !');
    }
  }

  // getting posts
  getPosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var tokenVal = prefs.getString('api token');
      http.Response response = await http.get(
        'http://www.json-generator.com/api/json/get/bTVHlfWTLS?indent=2',
//        '$serverUrl/showpost',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenVal'
        },
      );
      var jsonData = json.decode(response.body);
      List posts = [];
      for (var i in jsonData) {
        Map<String, dynamic> post = {
          'name': i['name'],
          'about': i['about'],
          'dp': i['dp'],
          'email': i['email'],
          'index': i['index'],
          'pic': i['picture'],
          'date': i['date'],
          'details': i['details'],
        };
        posts.add(post);
      }
      return posts;
    } catch (e) {
      showModDialog('Couldn\' get posts . Please check your connection !');
    }
  }

  // It's just self explained
  addPost(
    String title,
    String content,
    image,
  ) async {
    try {
      String myUrl = '$serverUrl/addposts';
      http.post(myUrl, headers: {
        'Accept': 'application/json'
      }, body: {
        "title": "$title",
        "content": "$content",
        "image": image
      }).then((response) {
        status = response.body.contains('error');
        var data = jsonDecode(response.body.trim());
        if (status) {
          showModDialog(data);
        } else {
          Get.close(1);
        }
      });
    } catch (e) {
      showModDialog('An error has occurred . Please try again !');
    }
  }

  // files means books for library and docs for competitions
  getFiles(
    url,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var tokenVal = prefs.getString('api_token');
      http.Response response = await http.get(
        '$url',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer Token $tokenVal'
        },
      );
      var jsonData = json.decode(response.body);
      List books = [];
      for (var i in jsonData) {
        Map<String, dynamic> book = {
          'title': i['title'],
          'about': i['about'],
          'index': i['index'],
          'pic': i['picture'],
          'date': i['date'],
          'url': i['url'],
        };
        books.add(book);
      }
      return books;
    } catch (e) {
      showModDialog('Couldn\' get books . Please check your connection !');
    }
  }

  launchURL(
    url,
  ) async {
    if (await canLaunch(url.trim())) {
      await launch(url.trim(), forceWebView: true);
    } else {
      showModDialog('Couldn\'t launch url . Please try again !');
    }
  }

  getArchive() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var tokenVal = prefs.getString('api_token');
      http.Response response = await http.get(
        'http://www.json-generator.com/api/json/get/bVdHHNnsmW?indent=2',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer Token $tokenVal'
        },
      );
      var jsonData = json.decode(response.body);
      List archive = [];
      for (var i in jsonData) {
        Map<String, dynamic> post = {
          'title': i['title'],
          'index': i['index'],
          'pic': i['picture'],
          'date': i['date'],
          'url': i['url'],
        };
        archive.add(post);
      }
      return archive;
    } catch (e) {
      showModDialog('Couldn\' get Archive . Please check your connection !');
    }
  }

  getArchiveImgs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var tokenVal = prefs.getString('api_token');
      http.Response response = await http.get(
        'http://www.json-generator.com/api/json/get/ceapRxXwqG?indent=2',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer Token $tokenVal'
        },
      );
      var jsonData = json.decode(response.body);
      List tiles = [];
      for (var i in jsonData) {
        ArchiveImgTile tile = ArchiveImgTile(url: i["url"], img: i["picture"]);
        tiles.add(tile);
      }
      return tiles;
    } catch (e) {
      showModDialog('Couldn\' get images . Please check your connection !');
    }
  }
}

// ShowModified Dialog
showModDialog(
  String title,
) {
  return AlertDialog(
    backgroundColor: Get.theme.backgroundColor,
    titleTextStyle: Get.theme.textTheme.bodyText1.copyWith(fontSize: 18),
    title: Text(title),
    actions: <Widget>[
      RaisedButton(
          onPressed: () {
            Get.close(1);
          },
          child: Text('Ok')),
    ],
  );
}
