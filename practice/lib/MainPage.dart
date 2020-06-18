import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafe',
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Icon(Icons.menu),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 90,
                    top: 10,
                  ),
                  child: Text(
                    "Drink Menu",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: 70,
                      top: 10,
                    ),
                    child: Icon(
                      Icons.cloud,
                      color: Colors.yellow,
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 30,
                    ),
                    child: SizedBox(
                      width: 100,
                      height: 20,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Coffee",
                          style: TextStyle(
                            fontSize: 12
                          ),  
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20)),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 30,
                    ),
                    child: SizedBox(
                      width: 100,
                      height: 20,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Cocktails",
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20)),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 30,
                    ),
                    child: SizedBox(
                      width: 100,
                      height: 20,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Featured",
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20)),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
