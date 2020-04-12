import 'package:flutter/material.dart';
import 'package:scouts_minia/tools/network_manager.dart';

import '../components/posts.dart';
import '../constants.dart';

class NewsPage extends StatefulWidget {
  final pageName;
  final pageIcon;

  const NewsPage(
      {Key key,
      @required this.pageName,
      @required this.pageIcon,
      })
      : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<PostItem> posts = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: NetworkManager().getPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: Theme.of(context).primaryIconTheme,
                title: Text(widget.pageName),
                centerTitle: true,
              ),
              body: RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh:(){
                  return NetworkManager().getPosts();
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    endIndent: 50,
                    indent:  50,
                    thickness: 2,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostItem(
                      name: snapshot.data[index].name,
                      pic: snapshot.data[index].pic,
                      index: snapshot.data[index].index,
                      dp: snapshot.data[index].dp,
                      about: snapshot.data[index].about,
                      email: snapshot.data[index].email,
                      date: snapshot.data[index].date,
                      details: snapshot.data[index].details,
                    );
                  },
                ),
              ),
            );
          } else {
            return Container(
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
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              ),
            );
          }
        });
  }
}
