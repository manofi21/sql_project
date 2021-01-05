import 'package:equatable/equatable.dart';
import '../commant.dart';

abstract class CommantStateDartState extends Equatable {
  const CommantStateDartState();
}

class CommantStateDartInitial extends CommantStateDartState {
  @override
  List<Object> get props => [];
}

class LoadCommants extends CommantStateDartState {
  final List<ForWidgetCommand> allCommants;
  LoadCommants(this.allCommants);
  @override
  List<Object> get props => [allCommants];
}