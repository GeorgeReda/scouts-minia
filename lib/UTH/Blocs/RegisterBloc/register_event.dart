part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterButtonPressed extends RegisterEvent {
  final String name, email, password, phone, image;

  RegisterButtonPressed(
      {@required this.name,
      @required this.email,
      @required this.password,
      @required this.phone,
      @required this.image});

  @override
  List<Object> get props => [name, email, password, phone, image];
}
