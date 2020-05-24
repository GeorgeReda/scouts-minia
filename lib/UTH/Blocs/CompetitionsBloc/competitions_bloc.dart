import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'competitions_event.dart';
part 'competitions_state.dart';

class CompetitionsBloc extends Bloc<CompetitionsEvent, CompetitionsState> {
  @override
  CompetitionsState get initialState => CompetitionsInitial();

  @override
  Stream<CompetitionsState> mapEventToState(
    CompetitionsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
