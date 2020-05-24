import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scouts_minia/UI/routes/detailsPage.dart';


class PostItem extends StatelessWidget {
  final int index;
  final String name;
  final String about;
  final String email;
  final String dp;
  final String pic;
  final String date;
  final String details;

  const PostItem(
      {Key key,
      @required this.index,
      @required this.about,
      @required this.email,
      @required this.pic,
      @required this.dp,
      @required this.name,
      @required this.date,
      @required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        child: Column(
          children: <Widget>[
            ListTile(
              trailing: Text('$date'),
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: NetworkImage('$dp'),
              ),
              title: Text(
                "$name",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Text(
              "$about",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Hero(
              tag: 'mainImage$index',
              child: Image.network(
                "$pic",
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        onTap: () {
          Get.to(Details(
            pic: pic,
            name: name,
            index: index,
            details: details,
          ));
        },
      ),
    );
  }
}
