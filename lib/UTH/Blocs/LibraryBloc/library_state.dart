part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();
  List<Object> get props => [];
}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibraryFailure extends LibraryState {
  final String error;

  LibraryFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class LibraryDone extends LibraryState {
  final List library;

  LibraryDone({@required this.library});

  @override
  List<Object> get props => [library];
}
