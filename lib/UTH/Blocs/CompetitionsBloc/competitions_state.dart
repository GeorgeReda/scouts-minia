part of 'competitions_bloc.dart';

abstract class CompetitionsState extends Equatable {
  const CompetitionsState();
}

class CompetitionsInitial extends CompetitionsState {
  @override
  List<Object> get props => [];
}
