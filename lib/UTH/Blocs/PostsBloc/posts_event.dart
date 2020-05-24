part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class OnSectionPressed extends PostsEvent {
  final String section;

  OnSectionPressed({@required this.section});
  @override
  List<Object> get props => [section];
}
