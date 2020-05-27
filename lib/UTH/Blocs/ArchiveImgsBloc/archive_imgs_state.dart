part of 'archive_imgs_bloc.dart';

abstract class ArchiveImgsState extends Equatable {
  const ArchiveImgsState();
  @override
  List<Object> get props => [];
}

class ArchiveImgsInitial extends ArchiveImgsState {}

class ArchiveImgsLoading extends ArchiveImgsState {}

class ArchiveImgsFailure extends ArchiveImgsState {
  final String error;

  ArchiveImgsFailure({@required this.error});
  @override
  List<Object> get props => [error];
}

class ArchiveImgsDone extends ArchiveImgsState {
  final List archiveImgs;

  ArchiveImgsDone({@required this.archiveImgs});
}
