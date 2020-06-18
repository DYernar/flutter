import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Container(
          height: 70,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ClipOval(
                  child: Material(
                      color: Colors.grey[200], // button color
                      child: InkWell(
                        splashColor: Colors.blue[100], // inkwell color
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Icon(
                            FontAwesomeIcons.planeDeparture,
                            color: Colors.grey[400],
                          ),
                        ),
                        onTap: () {},
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ClipOval(
                  child: Material(
                      color: Colors.grey[200], // button color
                      child: InkWell(
                        splashColor: Colors.blue[100], // inkwell color
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Icon(
                            FontAwesomeIcons.car,
                            color: Colors.grey[400],
                          ),
                        ),
                        onTap: () {},
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ClipOval(
                  child: Material(
                      color: Colors.grey[200], // button color
                      child: InkWell(
                        splashColor: Colors.blue[100], // inkwell color
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Icon(
                            FontAwesomeIcons.parachuteBox,
                            color: Colors.grey[400],
                          ),
                        ),
                        onTap: () {},
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ClipOval(
                  child: Material(
                      color: Colors.grey[200], // button color
                      child: InkWell(
                        splashColor: Colors.blue[100], // inkwell color
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Icon(
                            FontAwesomeIcons.motorcycle,
                            color: Colors.grey[400],
                          ),
                        ),
                        onTap: () {},
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
