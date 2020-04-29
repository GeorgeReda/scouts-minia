import 'package:flutter/material.dart';
import 'package:scouts_minia/tools/network_manager.dart';

class Book extends StatelessWidget {
  final int index;
  final String title;
  final String about;
  final String pic;
  final String date;
  final String url;

  const Book(
      {Key key,
      @required this.index,
      @required this.title,
      @required this.about,
      @required this.pic,
      @required this.date,
      @required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            ListTile(
              trailing: Text('$date'),
              contentPadding: EdgeInsets.zero,
              title: Text(
                "$title",
                style: Theme.of(context).textTheme.body1.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Text(
              "$about",
              style: Theme.of(context).textTheme.body1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Image.network(
              "$pic",
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ],
        ),
        onTap: (){NetworkManager().launchURL(url, context);},
      ),
    );
  }
}
