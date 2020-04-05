import 'package:flutter/material.dart';
import 'posts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        'http://www.json-generator.com/api/json/get/csCMeDTSDC?indent=2';
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
                body:ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostItem(name: snapshot.data[index].name,);
                  },
                ) ,
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Loading')
                  ],
                ),
              );
            }

        });
  }
}
