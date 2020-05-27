part of 'edit_bloc.dart';

abstract class EditState extends Equatable {
  const EditState();
  List<Object> get props => [];
}

class EditInitial extends EditState {}

class EditLoading extends EditState {}

class EditFailure extends EditState {
  final String error;

  const EditFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class EditDone extends EditState {}
