import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scouts_minia/UTH/Repos/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo _repo = LoginRepo();

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
     _repo.login(email: event.email, password: event.password);
        var response = await _repo.message;
        if (response == 'error') {
          yield LoginFailure(error: 'error');
        } else if (response == 'noUser') {
          yield LoginFailure(error: 'noUser');
        } else {
          final prefs = await SharedPreferences.getInstance();
          prefs
            ..setBool('state', true)
            ..setString('api_token', response["api_token"])
            ..setString('name', response["name"])
            ..setString('email', response["email"])
            ..setInt('mobile', response["mobile"]);
          yield LoginDone();
        }
      } catch (e) {
        yield LoginFailure(error: 'error');
      }
    }
  }
}
