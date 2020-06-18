import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int todoId;
  final String todoText;
  final int priority;
  final bool done;

  static int _idCounter = 0;

  factory Todo.idGenerator(String todoText, int priority) {
    _idCounter++;
    return Todo(_idCounter, todoText, priority, false);
  }
  Todo(this.todoId, this.todoText, this.priority, this.done);

  String get shortText {
    if (todoText.length < 40) return todoText;
    return todoText.substring(0, 40);
  }

  factory Todo.makeDone(Todo todo) {
    return Todo(todo.todoId, todo.todoText, todo.priority, !todo.done);
  }

  @override
  List<Object> get props => [todoText, done, priority];
}
