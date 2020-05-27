part of 'competitions_bloc.dart';

abstract class CompetitionsState extends Equatable {
  const CompetitionsState();
  List<Object> get props => [];
}

class CompetitionsInitial extends CompetitionsState {}

class CompetitionsLoading extends CompetitionsState {}

class CompetitionsFailure extends CompetitionsState {
  final String error;

  CompetitionsFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class CompetitionsDone extends CompetitionsState {
  final List competitions;

  CompetitionsDone({@required this.competitions});

  @override
  List<Object> get props => [competitions];
}
