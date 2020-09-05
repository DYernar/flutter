import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:qaz_latin/feature/auth/bloc/auth_bloc.dart';
import 'package:qaz_latin/feature/auth/bloc/auth_event.dart';
import 'package:qaz_latin/feature/auth/bloc/auth_state.dart';
import 'package:qaz_latin/static/colors.dart';

class UserData extends StatelessWidget {
  const UserData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state is AuthenticatedState) {
          if (state.user == null) {
            BlocProvider.of<AuthBloc>(context).add(LoggedOutEvent());
          }
          return Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              right: 40.0,
            ),
            child: Container(
              width: ScreenUtil().setWidth(300.0),
              height: ScreenUtil().setHeight(350.0),
              decoration: BoxDecoration(
                color: scheme_white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 1),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    color: scheme_shadow,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: scheme_blue,
                    backgroundImage: state.user.img != null
                        ? NetworkImage(state.user.img)
                        : AssetImage('assets/images/google.png'),
                  ),
                  Text(
                    '${state.user.username}',
                    style: scoreStyle.apply(color: scheme_dark),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey[300],
                    width: ScreenUtil().setWidth(250.0),
                  ),
                  Container(
                    width: 250.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: scheme_green,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                          color: scheme_shadow,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${state.user.email}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(LoggedOutEvent());
                    },
                    child: Container(
                      height: ScreenUtil().setHeight(30.0),
                      width: ScreenUtil().setWidth(60.0),
                      decoration: BoxDecoration(
                        color: scheme_blue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Шығу',
                          style: TextStyle(
                            color: scheme_white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Container(
          child: Text(''),
        );
      },
    );
  }
}
