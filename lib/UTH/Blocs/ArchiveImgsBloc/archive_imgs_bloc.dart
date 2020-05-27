import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scouts_minia/UTH/Repos/archive_imgs_repo.dart';

part 'archive_imgs_event.dart';
part 'archive_imgs_state.dart';

class ArchiveImgsBloc extends Bloc<ArchiveImgsEvent, ArchiveImgsState> {
  final ArchiveImgsRepo _repo = ArchiveImgsRepo();
  @override
  ArchiveImgsState get initialState => ArchiveImgsInitial();

  @override
  Stream<ArchiveImgsState> mapEventToState(
    ArchiveImgsEvent event,
  ) async* {
    if (event is OnPageOpen) {
      try {
        yield ArchiveImgsLoading();
        await _repo.getArchive();
        var response = await _repo.message;
        if (response == 'error')
          yield ArchiveImgsFailure(error: 'error');
        else {
          List tiles = [];
          for (var i in response) {
            Map<String, dynamic> tile = {'url': i["url"], 'img': i["picture"]};
            tiles.add(tile);
          }
          yield ArchiveImgsDone(archiveImgs: tiles);
        }
      } catch (e) {
        yield ArchiveImgsFailure(error: 'error');
      }
    }
  }
}
