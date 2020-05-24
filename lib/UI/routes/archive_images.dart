import 'package:flutter/material.dart';
import 'package:scouts_minia/UI/components/archive_image_tile.dart';
import 'package:scouts_minia/tools/network_manager.dart';

import '../../constants.dart';

class ArchiveImgs extends StatefulWidget {
  final url;

  const ArchiveImgs({Key key, @required this.url}) : super(key: key);

  @override
  _ArchiveImgsState createState() => _ArchiveImgsState();
}

class _ArchiveImgsState extends State<ArchiveImgs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: NetworkManager().getArchiveImgs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () {
                  return NetworkManager().getArchiveImgs();
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
                    return ArchiveImgTile(
                        url: snapshot.data[index].url,
                        img: snapshot.data[index].img);
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
