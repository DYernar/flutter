import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaz_latin/feature/profile/bloc/profile_event.dart';
import 'package:qaz_latin/feature/profile/bloc/profile_state.dart';
import 'package:qaz_latin/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  User currentUser;
  List<List<Map>> ranks = [];
  List<List<double>> progress = [];

  ProfileBloc() : super(null);

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetListEvent) {
      yield LoadingProfileState();
      await _getTrueFalseStates();

      yield ShowDataState(currentUser, ranks, progress);
    }
  }

  Future<void> _getTrueFalseStates() async {
    var token = await getTokenPref();
    for (int i = 1; i <= 2; i++) {
      List<Map> trueFalseRank = [];
      List<double> trueFalseProgress = [];
      try {
        final response = await http.get(
          'https://evening-oasis-57787.herokuapp.com/getRankById?gameid=$i',
          headers: {'appToken': 'Qazaq latin app', 'token': token},
        );

        final v = jsonDecode(response.body);
        if (v != null) {
          v.forEach(
            (k) {
              trueFalseRank.add(
                {
                  'username': k['username'],
                  'img': k['name'],
                  'score': k['score'],
                },
              );
            },
          );

          trueFalseRank.sort((a, b) => b['score'].compareTo(a['score']));
        }

        final progressResponse = await http.get(
          'https://evening-oasis-57787.herokuapp.com/getGameScore?gameid=$i',
          headers: {'appToken': 'Qazaq latin app', 'token': token},
        );

        final p = jsonDecode(progressResponse.body);

        if (p == null || p.length == 0) {
          trueFalseProgress.add(3.0);
          trueFalseProgress.add(3.0);
        } else if (p.length == 1) {
          trueFalseProgress.add(0.0);
        }

        if (p != null) {
          p.forEach(
            (element) {
              trueFalseProgress.add(double.parse(element.toString()));
            },
          );
        }
        ranks.add(trueFalseRank);
        progress.add(trueFalseProgress);
      } catch (e) {
        print(e);
      }
    }
    currentUser = await getUserPrefs();
  }

  Future<User> getUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString("displayname");
    final email = prefs.getString("email");
    final img = prefs.getString("img");

    return User(username, email, img, 0);
  }

  Future<String> getTokenPref() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");
    return token;
  }
}
