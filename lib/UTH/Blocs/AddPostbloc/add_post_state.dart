part of 'add_post_bloc.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();
  List<Object> get props => [];
}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddpostFailure extends AddPostState {
  final String error;

  AddpostFailure({@required this.error});
  @override
  List<Object> get props => [error];
}

class AddPostDone extends AddPostState {}
