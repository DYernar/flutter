import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_bloc.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_state.dart';
import 'package:qaz_latin/static/colors.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrueFalseBloc, TrueFalseState>(
      builder: (context, state) {
        if (state is ShowResultState) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: scheme_green,
            ),
            child: Center(
              child: Container(
                height: ScreenUtil().setHeight(200),
                width: ScreenUtil().setWidth(200.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15.0,
                      spreadRadius: 2.0,
                      color: scheme_shadow,
                    )
                  ],
                  color: scheme_blue,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Сіздің ұпайыңыз',
                        style: scoreStyle,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        '${state.score}',
                        style: TextStyle(
                          color: scheme_white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
