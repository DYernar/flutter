import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable{}

class AddTodoEvent extends TodoEvent {
  final String todoText;
  final int priority;

  AddTodoEvent(this.todoText, this.priority);
  @override
  List<Object> get props => [todoText, priority];
}

class MakeDoneEvent extends TodoEvent {
  final int id;

  MakeDoneEvent(this.id);
  
  @override
  List<Object> get props => [id];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;

  DeleteTodoEvent(this.id);

  @override
  List<Object> get props => [id];

}