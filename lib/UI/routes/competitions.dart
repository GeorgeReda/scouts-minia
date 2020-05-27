import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouts_minia/UI/components/book.dart';
import 'package:scouts_minia/UI/components/error_page.dart';
import 'package:scouts_minia/UTH/Blocs/CompetitionsBloc/competitions_bloc.dart';

import '../../constants.dart';

class Competitions extends StatefulWidget {
  @override
  _CompetitionsState createState() => _CompetitionsState();
}

class _CompetitionsState extends State<Competitions> {
  final CompetitionsBloc _bloc = CompetitionsBloc();
  @override
  void initState() {
    _bloc.add(OnPageOpen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<CompetitionsBloc, CompetitionsState>(
        builder: (context, state) {
          if (state is CompetitionsInitial || state is CompetitionsLoading)
            return Constants.circularProgressIndicator;
          else if (state is CompetitionsFailure)
            return ErrorPage(text: state.error);
          else if (state is CompetitionsDone)
            return Scaffold(
              body: Center(
                child: Scaffold(
                    body: RefreshIndicator(
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
                    itemCount: state.competitions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Book(
                        title: state.competitions[index]['title'],
                        pic: state.competitions[index]['pic'],
                        index: state.competitions[index]['index'],
                        about: state.competitions[index]['about'],
                        date: state.competitions[index]['date'],
                        url: state.competitions[index]['url'],
                      );
                    },
                  ),
                )),
              ),
            );
          return Container();
        },
      ),
    );
  }
}
