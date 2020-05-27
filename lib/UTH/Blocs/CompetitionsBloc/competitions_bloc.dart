import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scouts_minia/UTH/Repos/files_repo.dart';

part 'competitions_event.dart';
part 'competitions_state.dart';

class CompetitionsBloc extends Bloc<CompetitionsEvent, CompetitionsState> {
  final FilesRepo _repo = FilesRepo(section: 'competitions');
  @override
  CompetitionsState get initialState => CompetitionsInitial();

  @override
  Stream<CompetitionsState> mapEventToState(
    CompetitionsEvent event,
  ) async* {
    if (event is OnPageOpen) {
      yield CompetitionsLoading();
      await _repo.getFiles();
      var response = await _repo.message;
      if (response == 'error')
        yield CompetitionsFailure(error: 'error');
      else {
        List competitions = [];
        for (var i in response) {
          Map<String, dynamic> competition = {
            'title': i['title'],
            'about': i['about'],
            'index': i['index'],
            'pic': i['picture'],
            'date': i['date'],
            'url': i['url'],
          };
          competitions.add(competition);
          yield CompetitionsDone(competitions: competitions);
        }
      }
    }
  }
}
