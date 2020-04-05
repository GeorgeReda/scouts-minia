import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'posts.dart';

class NewsPage extends StatefulWidget {
  final pageName;
  final pageIcon;

  const NewsPage({Key key, this.pageName, this.pageIcon}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future getPosts() async {
    String url =
        'http://www.json-generator.com/api/json/get/cjvUhiIDJu?indent=2';
    http.Response response = await http.get(url);
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
      );
      posts.add(post);
    }
    print(posts.length);
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.pageName),
                centerTitle: true,
              ),
              body: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return PostItem(
                    name: snapshot.data[index].name,
                    pic: snapshot.data[index].pic,
                    index: snapshot.data[index].index,
                    dp: snapshot.data[index].dp,
                    about: snapshot.data[index].about,
                    email: snapshot.data[index].email,
                  );
                },
              ),
            );
          } else {
            return Container(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Constants.darkPrimary),
                    backgroundColor: Constants.lightPrimary,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Loading',
                    style: Theme.of(context).textTheme.body1,
                  )
                ],
              ),
            );
          }
        });
  }
}
