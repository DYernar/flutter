import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String todoText;
  final int priority;
  final bool done;

  static int idcounter = 0;

  factory Todo.todoGenerator(String todoText, int priority) {
    idcounter++;
    return Todo(idcounter, todoText, priority, false);
  }

  Todo(this.id, this.todoText, this.priority, this.done);
  
  String shortText() {
    if (this.todoText.length > 30) return this.todoText.substring(0, 30);
    return this.todoText;
  }

  factory Todo.makeDone(Todo todo) {
    return Todo(todo.id, todo.todoText, todo.priority, !todo.done);
  }
  @override
  List<Object> get props => [id, todoText, priority, done];
  
}