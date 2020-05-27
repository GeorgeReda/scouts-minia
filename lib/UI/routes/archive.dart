import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouts_minia/UI/components/archiveTile.dart';
import 'package:scouts_minia/UI/components/error_page.dart';
import 'package:scouts_minia/UTH/Blocs/ArchiveBloc/archive_bloc.dart';

import '../../constants.dart';

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  final ArchiveBloc _bloc = ArchiveBloc();
  @override
  void initState() {
    _bloc.add(OnPageOpen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<ArchiveBloc, ArchiveState>(
        builder: (BuildContext context, ArchiveState state) {
          if (state is ArchiveLoading)
            return Constants.circularProgressIndicator;
          else if (state is ArchiveFailure)
            return ErrorPage(text: state.error);
          else if (state is ArchiveDone)
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.all(8),
                child: RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () {
                    _bloc.add(OnPageOpen());
                    return;
                  },
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount: state.archive.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ArchiveTile(
                        title: state.archive[index]['title'],
                        pic: state.archive[index]['pic'],
                        index: state.archive[index]['index'],
                        date: state.archive[index]['date'],
                        url: state.archive[index]['url'],
                      );
                    },
                  ),
                ),
              ),
            );
          return Container();
        },
      ),
    );
  }
}
