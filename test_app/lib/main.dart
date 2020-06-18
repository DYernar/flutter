import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_app/bloc/todo_event.dart';
import 'package:test_app/todo.dart';
import 'package:test_app/todoadd.dart';

import 'bloc/todo_bloc.dart';
import 'bloc/todo_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  TodoBloc _todoBloc;

  void initState() {
    super.initState();
    _todoBloc = TodoBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (BuildContext context) => _todoBloc,
      child: Scaffold(
          floatingActionButton: TodoAdd(),
          appBar: AppBar(title: Text("todo app")),
          body: BlocBuilder<TodoBloc, TodoState>(
              bloc: _todoBloc,
              builder: (BuildContext context, TodoState state) {
                if (state is RunningState) {
                  return Container(
                      child: ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _todoItem(state.todos[index]);
                          }));
                }
                return Container();
              })),
    ));
  }

  Widget _todoItem(Todo todo) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 3.0,
      child: SizedBox(
        height: 100,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.angry,
                  color: todo.priority > 7
                      ? Colors.red
                      : todo.priority > 4 ? Colors.yellow : Colors.green),
              Text(todo.shortText),
              Checkbox(value: todo.done, onChanged: (bool val) {
                _todoBloc.add(MakeDoneEvent(todo.todoId));
              })
            ]),
      ),
    );
  }
}
