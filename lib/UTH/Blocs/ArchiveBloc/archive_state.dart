part of 'archive_bloc.dart';

abstract class ArchiveState extends Equatable {
  const ArchiveState();
  List<Object> get props => [];
}

class ArchiveInitial extends ArchiveState {}

class ArchiveLoading extends ArchiveState {}

class ArchiveFailure extends ArchiveState {
  final String error;

  ArchiveFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class ArchiveDone extends ArchiveState {
  final List archive;

  ArchiveDone({@required this.archive});

  @override
  List<Object> get props => [archive];
}
