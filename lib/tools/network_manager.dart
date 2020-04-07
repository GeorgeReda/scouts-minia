import 'package:scouts_minia/components/posts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkManager {
  final String url;

  NetworkManager(this.url);

  Future getPosts() async {
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
        date: i['date'],
        details: i['details'],
      );
      posts.add(post);
    }
    return posts;
  }
}
