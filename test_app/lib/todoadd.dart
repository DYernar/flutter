import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_app/bloc/todo_bloc.dart';
import 'package:test_app/bloc/todo_event.dart';

class TodoAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoAdd();
  }
}

class _TodoAdd extends State<TodoAdd> {
  @override
  Widget build(BuildContext context) {
    String _text;
    int _priority;

    return FloatingActionButton(
      child: Icon(FontAwesomeIcons.plus),
      onPressed: () {
        return showBottomSheet(
            context: context,
            builder: (BuildContext contextt) {
              return Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.teal[100],
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: TextField(
                            onChanged: (String data) {
                              setState(() {
                                _text = data;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: TextField(
                            onChanged: (String data) {
                              setState(() {
                                _priority = int.parse(data);
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                              color: Colors.amber[300],
                              child: Text("add"),
                              onPressed: () {
                                if (_text.length > 3) {
                                  BlocProvider.of<TodoBloc>(context)
                                      .add(AddTodoEvent(_text, _priority));
                                  _text = '';
                                  _priority = 0;
                                  Navigator.pop(context);
                                }
                              })),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        RaisedButton(
                          onPressed: () {
                            BlocProvider.of<TodoBloc>(context)
                                .add(IncreasingPriority());
                          },
                          child: Text("increasing priority"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            BlocProvider.of<TodoBloc>(context).add(DecreasingPriority());
                          },
                          child: Text("decreasing priority"),
                        ),
                      ])
                    ]),
                  ));
            });
      },
    );
  }
}
