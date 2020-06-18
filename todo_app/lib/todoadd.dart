import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/todo_bloc.dart';
import 'bloc/todo_event.dart';

class TodoAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoAdd();
  }
}

class _TodoAdd extends State<TodoAdd> {
  String _todoText = "";
  int _priority = 0;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        return showBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                color: Colors.blueGrey,
                height: 300,
                width: double.infinity,
                child: Column(children: [
                  Padding(padding: EdgeInsets.only(top: 50.0)),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                          color: Colors.white,
                          child: TextField(
                            onChanged: (data) {
                              _todoText = data;
                            },
                            decoration: InputDecoration(hintText: "todo text", contentPadding: EdgeInsets.symmetric(horizontal: 5)),
                          ))),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                        color: Colors.white,
                        child: TextField(
                          decoration: InputDecoration(hintText: "todo priority", contentPadding: EdgeInsets.symmetric(horizontal: 5)),
                          onChanged: (data) {
                            _priority = int.parse(data);
                          },
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () {
                        BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(_todoText, _priority));
                        _todoText = "";
                        _priority = 0;
                        Navigator.pop(context);
                      },
                      child: Text("add"),
                      color: Colors.indigoAccent,
                    ),
                  )
                ]),
              );
            });
      },
      child: Icon(Icons.add),
    );
  }
}
