part of 'edit_bloc.dart';

abstract class EditEvent extends Equatable {
  const EditEvent();
}

class OnButtonPressed extends EditEvent {
  final String name, email, image;

  OnButtonPressed(
      {@required this.name, @required this.email, @required this.image});
  @override
  List<Object> get props => [name, email, image];
}
