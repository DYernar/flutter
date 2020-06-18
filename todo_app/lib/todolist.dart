import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/bloc/todo_state.dart';
import 'bloc/todo_event.dart';
import 'todo.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoList();
  }
}

class _TodoList extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
        builder: (BuildContext context, TodoState state) {
      if (state is RunningState) {
        if (state.todos.length != 0) {
        return Expanded(
          child: ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (BuildContext context, int index) {
                return _todoItem(state.todos[index]);
              }),
        );
        } else {
          return Expanded(child: ListView(children: [Center(child: Text("no todo", style: TextStyle(fontSize: 35, color: Colors.grey)))]));
        }

      } else {
        return Container(color: Colors.yellow);
      }
    });
  }

  Widget _todoItem(Todo todo) {
    return SizedBox(
        height: 100,
        width: 300,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            elevation: 2.0,
            color: todo.priority > 6
                ? Colors.red
                : todo.priority > 3 ? Colors.yellow : Colors.green,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          width: 30,
                          child: Checkbox(
                              value: todo.done,
                              onChanged: (bool val) {
                                BlocProvider.of<TodoBloc>(context)
                                    .add(MakeDoneEvent(todo.id));
                              })),
                      SizedBox(width: 200, child: Text(todo.shortText())),
                      SizedBox(
                          child: Row(children: [
                        SizedBox(
                          width: 30,
                          child: InkWell(
                            child: Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            onTap: () {
                              BlocProvider.of<TodoBloc>(context)
                                  .add(DeleteTodoEvent(todo.id));
                            },
                          ),
                        ),
                      ]))
                    ],
                  ),
                ]),
          ),
        ));
  }
}
