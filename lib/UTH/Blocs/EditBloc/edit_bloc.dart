import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  @override
  EditState get initialState => EditInitial();

  @override
  Stream<EditState> mapEventToState(
    EditEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
