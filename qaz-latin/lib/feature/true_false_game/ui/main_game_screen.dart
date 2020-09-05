import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaz_latin/feature/true_false_game/model/select_question_model.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_bloc.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_event.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_state.dart';
import 'package:qaz_latin/static/colors.dart';

class TrueFalseGameScreen extends StatefulWidget {
  final Question question;
  const TrueFalseGameScreen(this.question, {Key key}) : super(key: key);

  @override
  _TrueFalseGameScreenState createState() => _TrueFalseGameScreenState();
}

class _TrueFalseGameScreenState extends State<TrueFalseGameScreen> {
  int _count = 1500;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _count = 1500;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = new Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        if (_count > 0) {
          _count--;
        } else {
          _timer.cancel();
          BlocProvider.of<TrueFalseBloc>(context).add(
            ChoiceMadeEvent(widget.question.answers.length, widget.question),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrueFalseBloc, TrueFalseState>(
      builder: (context, state) {
        if (state is ShowQuestionState) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: scheme_blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(330),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90.0),
                      bottomRight: Radius.circular(90.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        color: scheme_dark,
                      )
                    ],
                    color: scheme_white,
                  ),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50.0),
                        Container(
                          width: ScreenUtil().setWidth(110.0),
                          height: ScreenUtil().setHeight(50.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return Icon(
                                FontAwesomeIcons.solidHeart,
                                color: index < state.lives
                                    ? Colors.red
                                    : Colors.black,
                                size: 30.0,
                              );
                            },
                          ),
                        ),
                        Text(
                          '${state.score}',
                          style: scoreStyle.apply(
                            color: scheme_dark,
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(100.0),
                          child: Center(
                            child: Text(
                              state.question.question,
                              style: scoreStyle.apply(
                                color: scheme_dark,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(40.0),
                        ),
                        Container(
                          height: 10.0,
                          width: ScreenUtil().setWidth((_count / 2000) * 200),
                          color: Color.fromRGBO(
                              _count != 1000
                                  ? int.parse(
                                      (((1000 / (1000 - _count)) * 255).floor())
                                          .toString())
                                  : 0,
                              int.parse(
                                  ((255 * (_count / 1000)).floor()).toString()),
                              130,
                              1),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(480),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scheme_white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(130.0),
                      topRight: Radius.circular(130.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(0.0),
                        itemCount: state.question.answers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              if (_timer != null) {
                                _timer.cancel();
                              }
                              BlocProvider.of<TrueFalseBloc>(context)
                                  .add(ChoiceMadeEvent(index, widget.question));
                            },
                            child: _answer(state.question.answers[index]),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _answer(String answer) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: ScreenUtil().setHeight(70.0),
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 0),
                blurRadius: 4.0,
                color: Colors.grey[900],
              ),
            ],
            color: scheme_white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black26,
              width: 1,
              style: BorderStyle.solid,
            )),
        child: Center(
          child: Text(
            '$answer',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
