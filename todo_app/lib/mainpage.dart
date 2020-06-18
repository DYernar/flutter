import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/todoadd.dart';
import 'package:todo_app/todoapp.dart';

import 'bloc/todo_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  TodoBloc _todoBloc;

  @override
  void initState() {
    _todoBloc = TodoBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _todoBloc,
      child: Scaffold(
        floatingActionButton: TodoAdd(),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 60, 30, 30),
          ),
          TodoApp()
        ]),
      ),
    );
  }
}
