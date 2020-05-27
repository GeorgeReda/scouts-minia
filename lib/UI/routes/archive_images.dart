import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouts_minia/UI/components/archive_image_tile.dart';
import 'package:scouts_minia/UI/components/error_page.dart';
import 'package:scouts_minia/UTH/Blocs/ArchiveImgsBloc/archive_imgs_bloc.dart';

import '../../constants.dart';

class ArchiveImgs extends StatefulWidget {
  final url;

  const ArchiveImgs({Key key, @required this.url}) : super(key: key);

  @override
  _ArchiveImgsState createState() => _ArchiveImgsState();
}

class _ArchiveImgsState extends State<ArchiveImgs> {
  final ArchiveImgsBloc _bloc = ArchiveImgsBloc();
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
        child: BlocBuilder<ArchiveImgsBloc, ArchiveImgsState>(
          builder: (context, state) {
            if (state is ArchiveImgsLoading || state is ArchiveImgsInitial)
              return Constants.circularProgressIndicator;
            else if (state is ArchiveImgsFailure)
              return ErrorPage(text: state.error);
            else if (state is ArchiveImgsDone)
              return Padding(
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
                    itemCount: state.archiveImgs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ArchiveImgTile(
                          url: state.archiveImgs[index]["url"],
                          img: state.archiveImgs[index]["img"]);
                    },
                  ),
                ),
              );
            return Container();
          },
        ),
      ),
    );
  }
}
