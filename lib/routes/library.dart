import 'package:flutter/material.dart';
import 'package:scouts_minia/components/book.dart';
import 'package:scouts_minia/tools/network_manager.dart';

import '../constants.dart';

class Library extends StatefulWidget {
  final url = 'http://www.json-generator.com/api/json/get/cfYmFEaPyq?indent=2';

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: NetworkManager().getFiles(widget.url),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return RefreshIndicator(
              color: Theme.of(context).primaryColor,
              onRefresh: () {
                return NetworkManager().getFiles(widget.url);
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  endIndent: 50,
                  indent: 50,
                  thickness: 2,
                ),
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Book(
                    title: snapshot.data[index]['title'],
                    pic: snapshot.data[index]['pic'],
                    index: snapshot.data[index]['index'],
                    about: snapshot.data[index]['about'],
                    date: snapshot.data[index]['date'],
                    url: snapshot.data[index]['url'],
                  );
                },
              ),
            );
          } else {
            return Container(
              color: Theme.of(context).backgroundColor,
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
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
