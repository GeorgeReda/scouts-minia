import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scouts_minia/UTH/Repos/archive_repo.dart';

part 'archive_event.dart';
part 'archive_state.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {
  final ArchiveRepo _repo = ArchiveRepo();
  @override
  ArchiveState get initialState => ArchiveInitial();

  @override
  Stream<ArchiveState> mapEventToState(
    ArchiveEvent event,
  ) async* {
    if (event is OnPageOpen) {
      try {
        yield ArchiveLoading();
        await _repo.getArchive();
        var response = await _repo.message;
        if (response == 'error')
          yield ArchiveFailure(error: 'error');
        else {
          List archive = [];
          for (var i in response) {
            Map<String, dynamic> post = {
              'title': i['title'],
              'index': i['index'],
              'pic': i['picture'],
              'date': i['date'],
              'url': i['url'],
            };
            archive.add(post);
          }
          yield ArchiveDone(archive: archive);
        }
      } catch (e) {
        yield ArchiveFailure(error: 'error');
      }
    }
  }
}
