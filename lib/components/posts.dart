import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final int index;
  final String name;
  final String about;
  final String email;
  final String dp;
  final String pic;
  final String date;

  const PostItem(
      {Key key,
      this.index,
      this.about,
      this.email,
      this.pic,
      this.dp,
      this.name,
      this.date})
      : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        child: Column(
          children: <Widget>[
            ListTile(
              trailing: Text('${widget.date}'),
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: NetworkImage('${widget.dp}'),
              ),
              title: Text(
                "${widget.name}",
                style: Theme
                    .of(context)
                    .textTheme
                    .body1
                    .copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "${widget.about}",
              style: Theme
                  .of(context)
                  .textTheme
                  .body1
                  .copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.network(
              "${widget.pic}",
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              fit: BoxFit.cover,
            ),
          ],
        ),
        onTap: () {}, //Todo: Add Navigation to Details Page
      ),
    );
  }
}
