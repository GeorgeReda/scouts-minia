import 'package:flutter/material.dart';

class ArchiveTile extends StatelessWidget {
  final index;
  final pic;
  final title;
  final date;
  final url;

  const ArchiveTile(
      {Key key,
      @required this.pic,
      @required this.title,
      @required this.date,
      @required this.index,
      @required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//          return ArchiveImgs(url); Todo: Make the archive images .
          return Container();
        }));
      },
      child: GridTile(
        child: Image.network('$pic'),
        footer: GridTileBar(
          title: Text(
            '$title',
            style: Theme.of(context).textTheme.body1,
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          subtitle: Text('$date',
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 12)),
        ),
      ),
    );
  }
}
