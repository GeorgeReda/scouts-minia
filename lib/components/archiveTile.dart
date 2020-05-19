import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scouts_minia/routes/archive_images.dart';

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
        Get.to(ArchiveImgs(url: url));
      },
      child: Card(
        child: GridTile(
          child: Image.network('$pic'),
          footer: GridTileBar(
            title: Text(
              '$title',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            subtitle: Text('$date',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 12)),
          ),
        ),
      ),
    );
  }
}
