import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  @override
  LibraryState get initialState => LibraryInitial();

  @override
  Stream<LibraryState> mapEventToState(
    LibraryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
