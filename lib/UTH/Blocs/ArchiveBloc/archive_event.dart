part of 'archive_bloc.dart';

abstract class ArchiveEvent extends Equatable {
  const ArchiveEvent();
}

class OnPageOpen extends ArchiveEvent {
  @override
  List<Object> get props => [];
}
