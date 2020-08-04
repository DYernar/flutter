import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qaz_latin/feature/profile/bloc/profile_bloc.dart';
import 'package:qaz_latin/feature/profile/bloc/profile_event.dart';
import 'package:qaz_latin/feature/profile/bloc/profile_state.dart';
import 'package:qaz_latin/feature/profile/ui/true_false_rank.dart';
import 'package:qaz_latin/feature/profile/ui/user_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc _profileBloc;

  List<String> gameNames = ['Шын-Жалған', 'Дұрыс сөзді тап'];
  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc();
    _profileBloc.add(GetListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _profileBloc,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              UserData(),
              SizedBox(
                height: ScreenUtil().setHeight(20.0),
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is LoadingProfileState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ShowDataState) {
                    return Column(
                      children: <Widget>[
                        TrueFalseRank(
                            gameNames[0], state.progress[0], state.ranks[0]),
                        SizedBox(
                          height: 20.0,
                        ),
                        TrueFalseRank(
                            gameNames[1], state.progress[1], state.ranks[1]),
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
