part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String email, password;

  const LoginButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
