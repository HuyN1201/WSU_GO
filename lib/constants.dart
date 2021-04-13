import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const Color shockerYellow = const Color(0xFFFFCD00);
const Color shockerYellowOpaque = const Color(0xFFFFCD23);
const Color shockerWhite = const Color(0xFFFFFFFF);
const Color shockerBlack = const Color(0xFF000000);

//CourseData Class
class CourseDataTest{

  //Properties of a course
  final String courseInitials;
  final String courseNums;
  final String building;
  final String roomNum;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<bool> weekDays;

  //Constructor of a course
  CourseDataTest({
    this.courseInitials,
    this.courseNums,
    this.building,
    this.roomNum,
    this.startTime,
    this.endTime,
    this.weekDays});

  //Factory to create CourseData objects
  factory CourseDataTest.fromFirestore(DocumentSnapshot doc){
    //Assigning the document's data to a Map variable "data"
    Map data = doc.data();

    //Using the Constructor to create an object, passing the Map "data" values
    return CourseDataTest(
      courseInitials: data["courseInitials"],
      courseNums: data["courseNums"],
      building: data["building"],
      roomNum: data["roomNum"],
      weekDays: data["weekdays"]);
  }

}