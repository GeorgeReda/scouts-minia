import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  @override
  LogoutState get initialState => LogoutInitial();

  @override
  Stream<LogoutState> mapEventToState(
    LogoutEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
