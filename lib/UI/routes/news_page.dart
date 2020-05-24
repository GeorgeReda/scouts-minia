import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scouts_minia/UI/components/error_page.dart';
import 'package:scouts_minia/UTH/Blocs/PostsBloc/posts_bloc.dart';

import '../../constants.dart';
import '../components/posts.dart';

// The page where the posts are displayed
class NewsPage extends StatefulWidget {
  final String pageName;
  final IconData pageIcon;
  NewsPage({
    Key key,
    @required this.pageName,
    @required this.pageIcon,
  }) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final PostsBloc _bloc = PostsBloc();
  @override
  void initState() {
    _bloc.add(OnSectionPressed(section: widget.pageName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).primaryIconTheme,
        title: Text(widget.pageName),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: _bloc,
        child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
          if (state is PostsLoading)
            return Center(child: Constants.circularProgressIndicator);
          else if (state is PostsFailure)
            return ErrorPage(text: state.error);
          else if (state is PostsDone)
            return RefreshIndicator(
              color: Theme.of(context).primaryColor,
              onRefresh: () {
                _bloc.add(OnSectionPressed(section: widget.pageName));
                return;
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  endIndent: 50,
                  indent: 50,
                  thickness: 2,
                ),
                physics: BouncingScrollPhysics(),
                itemCount: state.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return PostItem(
                    name: state.posts[index]['name'],
                    pic: state.posts[index]['pic'],
                    index: state.posts[index]['index'],
                    dp: state.posts[index]['dp'],
                    about: state.posts[index]['about'],
                    email: state.posts[index]['email'],
                    date: state.posts[index]['date'],
                    details: state.posts[index]['details'],
                  );
                },
              ),
            );
          return Container();
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('addPost');
        },
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.plus,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
