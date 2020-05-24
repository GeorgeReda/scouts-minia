import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'archive_event.dart';
part 'archive_state.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {
  @override
  ArchiveState get initialState => ArchiveInitial();

  @override
  Stream<ArchiveState> mapEventToState(
    ArchiveEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
