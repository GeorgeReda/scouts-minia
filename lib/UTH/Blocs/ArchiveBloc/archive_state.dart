part of 'archive_bloc.dart';

abstract class ArchiveState extends Equatable {
  const ArchiveState();
}

class ArchiveInitial extends ArchiveState {
  @override
  List<Object> get props => [];
}
