import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaz_latin/feature/profile/bloc/profile_bloc.dart';
import 'package:qaz_latin/feature/profile/bloc/profile_state.dart';
import 'package:qaz_latin/static/colors.dart';

class TrueFalseRank extends StatelessWidget {
  final List<double> progress;
  final List<Map> ranks;
  final String gameName;
  const TrueFalseRank(this.gameName, this.progress, this.ranks, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is LoadingProfileState) {
        return Container();
      }

      if (state is ShowDataState) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: ScreenUtil().setHeight(250.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: scheme_white,
                    boxShadow: [
                      BoxShadow(
                        color: scheme_shadow,
                        blurRadius: 3.0,
                      )
                    ]),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.0,
                            color: scheme_shadow,
                          ),
                        ],
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: scheme_shadow,
                          ),
                        ),
                        color: scheme_blue,
                      ),
                      child: Center(
                        child: Text(
                          '$gameName',
                          style: scoreStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(200.0),
                      width: ScreenUtil().setWidth(400.0),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 5.0),
                        itemCount: ranks.length,
                        itemBuilder: (context, int index) {
                          if (index <= 2 ||
                              ranks[index]['username'] ==
                                  state.currentUser.username) {
                            return _usersRank(ranks, index);
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Container(
                  height: ScreenUtil().setHeight(250.0),
                  decoration: BoxDecoration(
                    color: scheme_white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: scheme_shadow,
                      )
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: scheme_blue,
                          ),
                          child: Text(
                            'прогресс',
                            style: scoreStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          child: new Sparkline(
                            data: progress,
                            lineColor: scheme_yellow,
                            lineWidth: 2.0,
                            pointsMode: PointsMode.all,
                            pointColor: scheme_blue,
                            pointSize: 8.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
      return Container();
    });
  }

  Widget _usersRank(userRanks, index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 15.0,
      ),
      child: Container(
        width: ScreenUtil().setWidth(350.0),
        height: ScreenUtil().setHeight(50.0),
        decoration: BoxDecoration(
          color: scheme_white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 1.0,
              spreadRadius: 1.0,
              color: scheme_shadow,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(40.0),
              child: Row(
                children: <Widget>[
                  Text('${index + 1}'),
                  index < 3
                      ? Container(
                          width: 30.0,
                          child: Icon(
                            FontAwesomeIcons.medal,
                            color: index == 0
                                ? Colors.yellow[500]
                                : index == 1
                                    ? Colors.grey[500]
                                    : Colors.orange[800],
                          ),
                        )
                      : Container(
                          width: 30.0,
                        ),
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: scheme_green,
              backgroundImage: NetworkImage(userRanks[index]['img']),
              radius: 20.0,
            ),
            Container(
              width: 180.0,
              child: Text(
                '${userRanks[index]['username']}'.length < 20
                    ? '${userRanks[index]['username']}'
                    : '${userRanks[index]['username']}'.substring(0, 20),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(40.0),
              child: Text('${userRanks[index]['score']}'),
            ),
          ],
        ),
      ),
    );
  }
}
