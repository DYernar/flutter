import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qaz_latin/feature/true_false_game/model/game.dart';
import 'package:qaz_latin/feature/true_false_game/ui/true_false_screen.dart';
import 'package:qaz_latin/static/colors.dart';

class GameFeed extends StatefulWidget {
  const GameFeed({Key key}) : super(key: key);

  @override
  _GameFeedState createState() => _GameFeedState();
}

class _GameFeedState extends State<GameFeed> {
  List<Game> games = [
    TrueFalseGame(),
    SelectCorrectWordGame(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Container(
            height: ScreenUtil().setHeight(750.0),
            child: ListView.builder(
              itemCount: games.length,
              itemBuilder: (BuildContext context, int index) {
                return _game(index, context);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _game(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 15.0,
            color: scheme_shadow,
          )
        ]),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      TrueFalseGameMainScreen(games[index])),
            );
          },
          child: Stack(
            children: <Widget>[
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  height: ScreenUtil().setHeight(220.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: scheme_green.withOpacity(1),
                  ),
                ),
              ),
              Positioned(
                left: ScreenUtil().setWidth(-30.0),
                top: ScreenUtil().setHeight(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/play_btn.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  height: ScreenUtil().setHeight(150),
                  width: ScreenUtil().setWidth(180.0),
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(220.0),
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 170.0,
                ),
                child: Container(
                  height: ScreenUtil().setHeight(100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        games[index].title,
                        style: TextStyle(
                          color: scheme_white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
