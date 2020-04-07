import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String pic;
  final String name;
  final String details;
  final int index;

  const Details(
      {Key key,
      @required this.pic,
      @required this.name,
      @required this.details,
      @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  iconTheme: Theme.of(context).primaryIconTheme,
                  floating: true,
                  pinned: false,
                  snap: false,
                  centerTitle: true,
                  title: Text(name),
                )
              ];
            },
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              children: <Widget>[
                Hero(
                    tag: 'mainImage$index',
                    child: Image.network(pic,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover)),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    details,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 18),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
