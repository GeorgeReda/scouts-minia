import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final int index;
  final String name;
  final String about;
  final String email;
  final String dp;
  final String pic;

  const PostItem(
      {Key key,
      this.index,
      this.name,
      this.about,
      this.email,
      this.pic,
      this.dp})
      : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('${widget.dp}'),
                  ),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    widget.name,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
