import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaz_latin/feature/auth/bloc/bloc.dart';
import 'package:qaz_latin/feature/game_feed/ui/game_feed.dart';
import 'package:qaz_latin/feature/news_feed/ui/news_feed.dart';
import 'package:qaz_latin/feature/profile/ui/profile_page.dart';
import 'package:qaz_latin/static/colors.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int currentIndex = 0;

  final List<dynamic> tabs = [
    NewsFeed(),
    GameFeed(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    if (BlocProvider.of<AuthBloc>(context).state is! AuthenticatedState) {
      BlocProvider.of<AuthBloc>(context).add(LoggedInEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
        iconSize: 40.0,
        selectedFontSize: 16.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chrome_reader_mode,
              color: currentIndex == 0 ? scheme_white : Colors.grey[400],
            ),
            backgroundColor: scheme_green,
            title: Text(
              'Оқы',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.play_arrow,
              color: currentIndex == 1 ? scheme_white : Colors.grey[400],
            ),
            backgroundColor: scheme_yellow,
            title: Text(
              'Ойна',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: currentIndex == 2 ? scheme_white : Colors.grey[400],
            ),
            backgroundColor: scheme_orange,
            title: Text(
              'Профиль',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
