import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scouts_minia/UTH/Repos/edit_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final EditRepo _repo = EditRepo();

  @override
  EditState get initialState => EditInitial();

  @override
  Stream<EditState> mapEventToState(
    EditEvent event,
  ) async* {
    if (event is OnButtonPressed) {
      try {
        yield EditLoading();
        await _repo.edit(
            name: event.name, email: event.email, image: event.image);
        var response = await _repo.message;
        if (response == 'error')
          yield EditFailure(error: 'error');
        else {
          final prefs = await SharedPreferences.getInstance();
          prefs..setString('name', event.name)..setString('email', event.email);
          yield EditDone();
        }
      } catch (e) {
        yield EditFailure(error: 'error');
      }
    }
  }
}
