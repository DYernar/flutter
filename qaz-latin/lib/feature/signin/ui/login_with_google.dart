import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:qaz_latin/feature/auth/bloc/bloc.dart';
import 'package:qaz_latin/feature/signin/bloc/signin_bloc.dart';
import 'package:qaz_latin/feature/signin/bloc/signin_event.dart';
import 'package:qaz_latin/feature/signin/bloc/signin_state.dart';
import 'package:qaz_latin/model/user_repository.dart';
import 'package:qaz_latin/static/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWithGooglePage extends StatefulWidget {
  final AuthBloc authBloc;
  final UserRepository userRepository;

  const LoginWithGooglePage(this.authBloc, this.userRepository, {Key key})
      : super(key: key);

  @override
  _LoginWithGooglePageState createState() => _LoginWithGooglePageState();
}

class _LoginWithGooglePageState extends State<LoginWithGooglePage> {
  SigninBloc _signinBloc;

  @override
  void initState() {
    super.initState();
    _signinBloc = SigninBloc(widget.authBloc, widget.userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _signinBloc,
      child: Scaffold(
        backgroundColor: scheme_green,
        body: Center(
          child: BlocBuilder<SigninBloc, SigninState>(
            builder: (BuildContext context, SigninState state) {
              if (state is SignInLoading) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _signinBloc.add(SigninWithGoogleButtonPressed());
                    },
                    child: Container(
                      margin: EdgeInsets.all(0),
                      width: ScreenUtil().setWidth(300.0),
                      height: ScreenUtil().setHeight(50.0),
                      decoration: BoxDecoration(
                        color: scheme_blue,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/google.png",
                              width: ScreenUtil().setWidth(50.0),
                              height: ScreenUtil().setHeight(50.0),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5.0)),
                            Text(
                              'Google арқылы жүйеге кіру',
                              style: TextStyle(
                                color: scheme_white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<SigninBloc, SigninState>(
                      builder: (BuildContext context, SigninState state) {
                    if (state is SigninError) {
                      return Text(
                        'Дұрыс google аккаунтты таңдаңыз!',
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return Container();
                  })
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
