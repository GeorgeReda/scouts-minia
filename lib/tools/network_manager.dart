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

  loginData(String email, String password, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String myUrl = '$serverUrl/user/login';
      http.post(myUrl,
          headers: {'Accept': 'application/json'},
          body: {"email": "$email", "password": "$password"}).then((response) {
        print(response.statusCode);
        print(response.request.toString());
        status = response.body.contains('error');
        var data = jsonDecode(response.body.trim());
        if (status) {
          print('data : ${data["error"]}');
        } else {
          print('data : ${data["api token"]}');
          prefs.setString('api token', data["api token"]);
          prefs.setString('name', data["name"]);
          prefs.setString('email', data["email"]);
          prefs.setString('image', data["image"]);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ));
        }
      });
    } catch (e) {
      print(e);
      showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            titleTextStyle:
                Theme.of(context).textTheme.body1.copyWith(fontSize: 18),
            title: Text('An error has occurred . Please try again !'),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text('Ok')),
            ],
          );
        },
      );
    }
  }

  registerData(String name, String email, String password, String phone, image,
      context) async {
    try {
      if (null == image) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'An error has occurred ! Please add a photo and try again .'),
          ),
          duration: Duration(seconds: 2),
        ));
      }
      final prefs = await SharedPreferences.getInstance();
      String myUrl = '$serverUrl/user/register';
      http.post(myUrl, headers: {
        'Accept': 'application/json'
      }, body: {
        "name": "$name",
        "email": "$email",
        "password": "$password",
        "image": image
      }).then((response) {
        status = response.body.contains('error');
        var data = jsonDecode(response.body.trim());
        if (status) {
          print('data : ${data["error"]}');
        } else {
          print('data : ${data["api token"]}');
          prefs.setString('api token', data["api token"]);
          prefs.setString('name', name);
          prefs.setString('email', email);
          prefs.setString('image', image);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        }
      });
    } catch (e) {
      print(e);
      showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            titleTextStyle:
                Theme.of(context).textTheme.body1.copyWith(fontSize: 18),
            title: Text('An error has occurred . Please try again !'),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text('Ok')),
            ],
          );
        },
      );
    }
  }

  editData(String name, String email, image, context) async {
    try {
      if (null == image) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'An error has occurred ! Please add a photo and try again .'),
          ),
          duration: Duration(seconds: 2),
        ));
      }
      final prefs = await SharedPreferences.getInstance();
      String myUrl = '$serverUrl';//Todo: Change Url
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
          print('data : ${data["error"]}');
        } else {
          prefs.setString('name', name);
          prefs.setString('email', email);
          prefs.setString('image', image);
          Navigator.of(context).pop();
        }
      });
    } catch (e) {
      print(e);
      showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            titleTextStyle:
                Theme.of(context).textTheme.body1.copyWith(fontSize: 18),
            title: Text('An error has occurred . Please try again !'),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text('Ok')),
            ],
          );
        },
      );
    }
  }

  logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('api token');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('image');
  }

  Future getPosts(context) async {
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
      showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            titleTextStyle:
                Theme.of(context).textTheme.body1.copyWith(fontSize: 18),
            title: Text('Couldn\' get posts . Please check your connection !'),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text('Ok')),
            ],
          );
        },
      );
    }
  }
  addPost(String title, String description, image, context) async {
    try {
      if (null == image) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'An error has occurred ! Please add a photo and try again .'),
          ),
          duration: Duration(seconds: 2),
        ));
      }
      String myUrl = '$serverUrl/addposts';
      http.post(myUrl, headers: {
        'Accept': 'application/json'
      }, body: {
        "title": "$title",
        "description": "$description",
        "image": image
      }).then((response) {
        status = response.body.contains('error');
        var data = jsonDecode(response.body.trim());
        if (status) {
          print('data : ${data["error"]}');
        } else {
          Navigator.of(context).pop();
        }
      });
    } catch (e) {
      print(e);
      showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            titleTextStyle:
            Theme.of(context).textTheme.body1.copyWith(fontSize: 18),
            title: Text('An error has occurred . Please try again !'),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text('Ok')),
            ],
          );
        },
      );
    }
  }

   getBooks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var tokenVal = prefs.getString('api token');
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
