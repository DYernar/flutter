import 'package:equatable/equatable.dart';

import '../todo.dart';

abstract class TodoState extends Equatable {}

class RunningState extends TodoState {
  final List<Todo> todos;

  RunningState(this.todos);

  @override
  List<Object> get props => [todos];
  
}