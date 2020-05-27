part of 'archive_imgs_bloc.dart';

abstract class ArchiveImgsEvent extends Equatable {
  const ArchiveImgsEvent();
}

class OnPageOpen extends ArchiveImgsEvent {
  @override
  List<Object> get props => [];
}
