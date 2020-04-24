import 'package:flutter/material.dart';
import 'package:scouts_minia/tools/network_manager.dart';

import '../constants.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: NetworkManager().getBooks(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return Scaffold(
                body: RefreshIndicator(
              color: Theme.of(context).primaryColor,
              onRefresh: () {
                return NetworkManager().getBooks();
              },
              child: Container(),
            ));
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
