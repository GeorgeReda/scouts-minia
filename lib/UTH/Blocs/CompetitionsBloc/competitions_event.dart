part of 'competitions_bloc.dart';

abstract class CompetitionsEvent extends Equatable {
  const CompetitionsEvent();
}
class OnPageOpen extends CompetitionsEvent {
  @override
  List<Object> get props => [];
}