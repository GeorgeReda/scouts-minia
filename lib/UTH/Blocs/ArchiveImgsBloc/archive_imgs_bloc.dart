import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'archive_imgs_event.dart';
part 'archive_imgs_state.dart';

class ArchiveImgsBloc extends Bloc<ArchiveImgsEvent, ArchiveImgsState> {
  @override
  ArchiveImgsState get initialState => ArchiveImgsInitial();

  @override
  Stream<ArchiveImgsState> mapEventToState(
    ArchiveImgsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
