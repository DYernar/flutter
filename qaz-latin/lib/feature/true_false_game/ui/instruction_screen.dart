import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_bloc.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_event.dart';
import 'package:qaz_latin/static/colors.dart';

class InstructionPage extends StatelessWidget {
  final String instrution;
  const InstructionPage(this.instrution, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<TrueFalseBloc>(context).add(ShowQuestionEvent());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: scheme_blue.withOpacity(0.6),
        ),
        child: Center(
          child: Container(
            height: ScreenUtil().setHeight(300),
            width: ScreenUtil().setWidth(300),
            decoration: BoxDecoration(
              color: scheme_green,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: scheme_shadow,
                  blurRadius: 25.0,
                  spreadRadius: 5.0,
                )
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(50.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      instrution,
                      style: TextStyle(
                        color: scheme_white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(50.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
