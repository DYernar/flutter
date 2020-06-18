import 'package:bloc/bloc.dart';
import 'package:todo_app/bloc/todo_event.dart';
import 'package:todo_app/bloc/todo_state.dart';

import '../todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> _todos = [];

  @override
  TodoState get initialState => RunningState([]);

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is AddTodoEvent) {
      var newtodo = Todo.todoGenerator(event.todoText, event.priority);
      _todos.insert(0, newtodo);
      yield RunningState(_updatedList());
    }

    if (event is MakeDoneEvent) {
      Todo temp = _todos.firstWhere((Todo todo)=>todo.id == event.id);
      _todos.remove(temp);
      temp = Todo.makeDone(temp);
      if (temp.done) {
          _todos.add(temp);
      } else {
          _todos.insert(0, temp);
      }
      yield RunningState(_updatedList());
    }

    if (event is DeleteTodoEvent) {
      Todo todel = _todos.firstWhere((Todo todo) => todo.id == event.id);
      _todos.remove(todel);
      yield RunningState(_updatedList());
    }
  }

  List<Todo> _updatedList() {
    List<Todo> newlist = [];
    for (Todo todo in _todos) {
      newlist.add(todo);
    }
    return newlist;
  }
}
