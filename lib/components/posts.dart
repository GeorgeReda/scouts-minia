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
      this.about,
      this.email,
      this.pic,
      this.dp,
      this.name})
      : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        child: Column(
          children: <Widget>[
            ListTile(
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.network(
              "${widget.pic}",
              height: 170,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              fit: BoxFit.cover,
            ),
          ],
        ),
        onTap: () {},
      ),
    );
    ;
  }
}
