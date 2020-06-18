import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Destination extends StatelessWidget {
  String cityName;
  String countryName;
  int activityAmount;
  String description;
  String imgUrl;

  Destination(
      {this.cityName,
      this.countryName,
      this.activityAmount,
      this.description,
      this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: SizedBox(
        width: 240,
        height: 305,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
            elevation: 3.0,
            color: Colors.white,
            child: Container(
                child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: Image(
                          image: NetworkImage(this.imgUrl),
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 150, left: 30),
                          child: Text(
                            this.cityName,
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 22,
                              letterSpacing: 1.5,  
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 175, left: 15),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 2),
                            child: Icon(
                              FontAwesomeIcons.telegramPlane,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          Text(
                            this.countryName,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 45, top: 20),
                  child: Text(
                    this.activityAmount.toString() + " activities",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5, left: 15, right: 2),
                    child: Text(this.description,
                      style: TextStyle(
                        color: Colors.grey[400]
                      ),
                    ))
              ],
            ))),
      ),
    );
  }
}
