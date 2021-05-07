import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:wsu_go/screens/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:core';


class WeatherData {
  final DateTime date;
  final String name;
  final  temp;
  final String main;
  final String icon;
  final  high;
  final  low;
  final humidity;
  final windspeed;
  final visibilty;
  final feelslike;
  var sunRise;
  var format_sunRise;
  var sunSet;
  var format_sunSet;
  var format_sunRiseEnd;
  var format_sunSetEnd;
  //DateTime sunrise;
  //DateTime sunset;

  WeatherData({this.date, this.name, this.temp, this.main, this.icon, this.high, this.low,
  this.humidity, this.visibilty, this.windspeed, this.feelslike, this.sunRise, this.sunSet, this.format_sunRise});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return  WeatherData(
      name: json['name'],
      temp: json['main']['temp'].round(),
      main: json['weather'][0]['main'],
      high: json['main']['temp_max'].round(),
      low: json['main']['temp_min'].round(),
      humidity: json['main']['humidity'],
      windspeed: json['wind']['speed'],
      visibilty: json['visibility'],
      feelslike: json['main']['feels_like'].round(),
      sunRise: json['sys']['sunrise'],
      sunSet: json['sys']['sunset'],

    );

  }

}

