import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scouts_minia/UTH/Repos/register_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepo _repo = RegisterRepo();
  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();
      try {
        _repo.register(
            name: event.name,
            email: event.email,
            password: event.password,
            mobile: event.phone,
            image: event.image);
        var response = await _repo.message;
        if (response == 'error') {
          yield RegisterFailure(error: 'error');
        } else if (response == 'alreadyUser') {
          print(response);
          yield RegisterFailure(error: 'alreadyUser');
        } else {
          print(response);
          final prefs = await SharedPreferences.getInstance();
          prefs
            ..setBool('state', true)
            ..setString('name', event.name)
            ..setString('email', event.email)
            ..setString('phone', event.phone);
          yield ReigisterDone();
        }
      } catch (e) {
        yield RegisterFailure(error: 'error');
      }
    }
  }
}
