part of 'edit_bloc.dart';

abstract class EditState extends Equatable {
  const EditState();
}

class EditInitial extends EditState {
  @override
  List<Object> get props => [];
}
