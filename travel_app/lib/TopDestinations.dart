import 'package:flutter/material.dart';
import 'package:travel_app/Destination.dart';

class TopDestinations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 450,
        width: 400,
        child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Top Destinations",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                          fontFamily: 'Cambay-Regular',
                          wordSpacing: 3,
                        ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 90),
                    child: InkWell(
                      child: Text(
                        "See All",
                        style: TextStyle(
                          color: Colors.blue[200],
                          fontSize: 22,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: <Widget>[
                    Destination(
                      cityName: "Venice",
                      countryName: "Italy",
                      activityAmount: 125,
                      description:
                          "Enjoy best trips from top travel agencies at best prices",
                      imgUrl:
                          'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=630&q=80',
                    ),
                    Destination(
                      cityName: "Paris",
                      countryName: "France",
                      activityAmount: 98,
                      description:
                          "Enjoy best trips from top travel agencies at best prices",
                      imgUrl:
                          'https://images.unsplash.com/photo-1549144511-f099e773c147?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                    ),
                    Destination(
                      cityName: "London",
                      countryName: "England",
                      activityAmount: 112,
                      description:
                          "Enjoy best trips from top travel agencies at best prices",
                      imgUrl:
                          'https://images.unsplash.com/photo-1505761671935-60b3a7427bad?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
                    ),
                    Destination(
                      cityName: "Hungary",
                      countryName: "Budapest",
                      activityAmount: 50,
                      description:
                          "Enjoy best trips from top travel agencies at best prices",
                      imgUrl:
                          'https://images.unsplash.com/photo-1541343672885-9be56236302a?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
                    ),
                  ]))
            ],
          ),
        ));
  }
}
