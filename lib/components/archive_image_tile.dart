import 'package:flutter/material.dart';
import 'package:scouts_minia/tools/network_manager.dart';

class ArchiveImgTile extends StatelessWidget {
  final url;
  final img;

  const ArchiveImgTile({Key key, @required this.url, @required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NetworkManager().launchURL(url, context);
      },
      child: GridTile(child: Image.network(img)),
    );
  }
}
