part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsDone extends PostsState {
  final List posts;

  PostsDone({@required this.posts});
  @override
  List<Object> get props => [posts];
}

class PostsFailure extends PostsState {
  final String error;

  PostsFailure({@required this.error});
  @override
  List<Object> get props => [error];
}
