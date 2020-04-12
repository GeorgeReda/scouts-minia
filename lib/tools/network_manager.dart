import 'package:flutter/material.dart';
import 'package:scouts_minia/components/posts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:scouts_minia/routes/mainScreen.dart';

class NetworkManager {
  String serverUrl = 'https://scoutsapp1.000webhostapp.com/public/api';
  var status;
  var token;

  loginData(String email, String password, context)async{
    String myUrl = '$serverUrl/user/login';
    final response = await http.post(myUrl,headers: {
      'Accept': 'application/json'
    },
    body: {
      "email": "$email",
      "password": "$password"
    });
    status =response.body.contains('error');
    var data = json.decode(response.body);
    if(status){
      print('data : ${data["error"]}');
    }else{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MainScreen()));
      print('data: ${data["token"]}');
    }
    
  }

  Future getPostsPage(url){
    //Todo: add posts urls .
  }
  Future getPosts() async {
    http.Response response = await http.get('$serverUrl/posts/url');
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
  }
}
