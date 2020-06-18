import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/todo.dart';

import 'bloc/todo_state.dart';

class TodoStats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoStats();
  }
}

class _TodoStats extends State<TodoStats> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState> (
      builder: (BuildContext context, TodoState state) {
        if (state is RunningState) {
          int finished = 0;
          for (Todo todo in state.todos) {
            if (todo.done) {
              finished++;
            }
          }
          return SizedBox(
        height: 100,
        width: 370,
        child: Card(
          elevation: 3.0,
          color: Colors.black38,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(children: [
                  SizedBox(width: 50, child: Text("Done: ")),
                  _doneTodayRow(finished, state.todos.length),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: SizedBox(width: 50, child: Text("$finished/"+state.todos.length.toString()))),
                ]),
              ),
            ],
          ),
        ),
      ); 
        } else {
          return Container();
        }
      }
    );
  }

  Widget _doneTodayRow(
    int done,
    int total,
  ) {
    return SizedBox(
      height: 30,
      width: 200,
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: 200,
            height: 30,
            child: Card(
              margin: EdgeInsets.all(0),
              color: Colors.pink,
            ),
          ),
          SizedBox(
            width: total == 0 ? 0 : 200 * (done / total),
            height: 30,
            child: Card(
              margin: EdgeInsets.all(0),
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }

}

