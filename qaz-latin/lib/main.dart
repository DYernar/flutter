import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qaz_latin/feature/auth/bloc/bloc.dart';
import 'package:qaz_latin/feature/true_false_game/model/game.dart';
import 'package:qaz_latin/model/user_repository.dart';

import 'feature/app/ui/app_page.dart';
import 'feature/signin/ui/login_with_google.dart';
import 'feature/signin/ui/splash_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(userRepository: _userRepository);
    _authBloc.add(AppStartedEvent());
    Game.generateWords();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _authBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
            builder: (BuildContext context, AuthState state) {
          ScreenUtil.init(context,
              width: 375, height: 812, allowFontScaling: false);

          if (state is LoadingState) {
            return SplashPage();
          }
          if (state is UninitializedState) {
            return SplashPage();
          }

          if (state is AuthenticatedState) {
            return AppPage();
          }

          if (state is UnauthenticatedState) {
            return LoginWithGooglePage(_authBloc, _userRepository);
          }
          return Container();
        }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
