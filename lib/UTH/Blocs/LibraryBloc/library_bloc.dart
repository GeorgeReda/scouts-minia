import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scouts_minia/UTH/Repos/files_repo.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final FilesRepo _repo = FilesRepo(section: 'library');
  @override
  LibraryState get initialState => LibraryInitial();

  @override
  Stream<LibraryState> mapEventToState(
    LibraryEvent event,
  ) async* {
    if (event is OnPageOpen) {
      yield LibraryLoading();
      await _repo.getFiles();
      var response = await _repo.message;
      if (response == 'error')
        yield LibraryFailure(error: 'error');
      else {
        List librarys = [];
        for (var i in response) {
          Map<String, dynamic> file = {
            'title': i['title'],
            'about': i['about'],
            'index': i['index'],
            'pic': i['picture'],
            'date': i['date'],
            'url': i['url'],
          };
          librarys.add(file);
          yield LibraryDone(library: librarys);
        }
      }
    }
  }
}
