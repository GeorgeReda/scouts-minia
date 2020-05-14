import 'package:flutter/material.dart';
import 'package:scouts_minia/components/archiveTile.dart';
import 'package:scouts_minia/tools/network_manager.dart';

import '../constants.dart';

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: NetworkManager().getArchive(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () {
                  return NetworkManager().getArchive(context);
                },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ArchiveTile(
                      title: snapshot.data[index]['title'],
                      pic: snapshot.data[index]['pic'],
                      index: snapshot.data[index]['index'],
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
      ),
    );
  }
}
