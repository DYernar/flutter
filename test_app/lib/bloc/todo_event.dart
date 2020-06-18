import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {}

class AddTodoEvent extends TodoEvent {
  final String todoText;
  final int priority;

  AddTodoEvent(this.todoText, this.priority);

 

  @override
  List<Object> get props => [todoText, priority];
  
}

class MakeDoneEvent extends TodoEvent {
  final int todoId;

  MakeDoneEvent(this.todoId);

  @override
  List<Object> get props => [todoId];
}

class IncreasingPriority extends TodoEvent {
  @override
  List<Object> get props => null;
}

class DecreasingPriority extends TodoEvent {
  @override
  List<Object> get props => null;
}