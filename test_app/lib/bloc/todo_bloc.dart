import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/todo_event.dart';
import 'package:test_app/bloc/todo_state.dart';

import '../todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> _todos = [];
  @override
  TodoState get initialState => RunningState([]);

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is AddTodoEvent) {
      var newtodo = Todo.idGenerator(event.todoText, event.priority);
      _todos.insert(0, newtodo);
      yield RunningState(_updatedList());
    }

    if (event is MakeDoneEvent) {
      Todo temp = _todos.firstWhere((Todo todo) => todo.todoId == event.todoId);
      _todos.remove(temp);
      temp = Todo.makeDone(temp);
      if (temp.done) {
        _todos.add(temp);
      } else {
        _todos.insert(0, temp);
      }
      yield RunningState(_updatedList());
    }

    if (event is IncreasingPriority) {
      for (int i = 0; i < _todos.length - 1; i++) {
        for (int j = i + 1; j < _todos.length; j++) {
          if (_todos[i].priority > _todos[j].priority) {
            var temp = _todos[i];
            _todos[i] = _todos[j];
            _todos[j] = temp;
          }
        }
      }
      yield RunningState(_updatedList());
    }

    if (event is DecreasingPriority) {
      for (int i = 0; i < _todos.length - 1; i++) {
        for (int j = i + 1; j < _todos.length; j++) {
          if (_todos[i].priority < _todos[j].priority) {
            var temp = _todos[i];
            _todos[i] = _todos[j];
            _todos[j] = temp;
          }
        }
      }
      yield RunningState(_updatedList());
    }
  }

  List<Todo> _updatedList() {
    List<Todo> newList = [];

    for (Todo item in _todos) {
      newList.add(item);
    }
    return newList;
  }
}
