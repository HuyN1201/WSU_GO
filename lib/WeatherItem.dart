import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';

import 'package:wsu_go/WeatherData.dart';

class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weather.name != null ? weather.name.toUpperCase() + "" : "Loading", style: new TextStyle(color: Colors.black54, fontWeight: FontWeight.w900, letterSpacing: 5, fontSize: 30)),
        Text(weather.main != null ? weather.main.toUpperCase() + "" : "Loading", style: new TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 5)),
        Text('${weather.temp.toString()}°F',  style: new TextStyle(color: Colors.black, fontSize: 100, fontWeight: FontWeight.w100)),
        Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.white,
              child: Text (
                'H: ${weather.high.toString()}°F', style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.w300
              ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Text('L: ${weather.low.toString()}°F', style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.w300
              ),
              ),
            )
          ],
        ),
      ],
    );

  }
}