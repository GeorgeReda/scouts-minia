part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();
}

class LibraryInitial extends LibraryState {
  @override
  List<Object> get props => [];
}
