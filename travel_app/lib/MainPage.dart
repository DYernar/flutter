import 'package:flutter/material.dart';
import 'Categories.dart';
import 'TopDestinations.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MainPage',
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Card(
                child: Center(
                    child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 70, bottom: 30),
                  child: Text(
                    "What would you like to find?",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -2,
                      fontFamily: 'Cambay-Regular',
                    ),
                  ),
                ),
                Categories(),
                TopDestinations()
              ],
            )))));
  }
}
