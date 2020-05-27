import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouts_minia/UI/components/book.dart';
import 'package:scouts_minia/UI/components/error_page.dart';
import 'package:scouts_minia/UTH/Blocs/LibraryBloc/library_bloc.dart';

import '../../constants.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final LibraryBloc _bloc = LibraryBloc();
  @override
  void initState() {
    _bloc.add(OnPageOpen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          if (state is LibraryInitial || state is LibraryLoading)
            return Constants.circularProgressIndicator;
          else if (state is LibraryFailure)
            return ErrorPage(text: state.error);
          else if (state is LibraryDone)
            return RefreshIndicator(
              color: Theme.of(context).primaryColor,
              onRefresh: () {
                _bloc.add(OnPageOpen());
                return;
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  endIndent: 50,
                  indent: 50,
                  thickness: 2,
                ),
                physics: BouncingScrollPhysics(),
                itemCount: state.library.length,
                itemBuilder: (BuildContext context, int index) {
                  return Book(
                    title: state.library[index]['title'],
                    pic: state.library[index]['pic'],
                    index: state.library[index]['index'],
                    about: state.library[index]['about'],
                    date: state.library[index]['date'],
                    url: state.library[index]['url'],
                  );
                },
              ),
            );
          return Container();
        },
      ),
    ));
  }
}
