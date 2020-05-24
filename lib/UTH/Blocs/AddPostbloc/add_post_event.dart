part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();
}

class OnButtonPressed extends AddPostEvent {
  final String title, content, image;

  OnButtonPressed(
      {@required this.title, @required this.content, @required this.image});

  @override
  List<Object> get props => [title, content, image];
}
