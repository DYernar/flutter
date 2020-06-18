import 'package:flutter/material.dart';
import 'package:todo_app/todolist.dart';
import 'package:todo_app/todostats.dart';


class TodoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoApp();
  }
}

class _TodoApp extends State<TodoApp> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Column(
            children: <Widget>[
              TodoStats(),
              TodoList(),
            ],
          ),
        );
  }
}
