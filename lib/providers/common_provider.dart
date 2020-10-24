import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../providers/secureStoreMixin_provider.dart';
import 'package:geolocator/geolocator.dart';

class DateAndTime{
  String date;
  String time;

  getCurrentDateAndTime(){
    DateTime now = DateTime.now();
    date = DateFormat('MM-dd-yyyy').format(now);
    time = DateFormat('kk.mm').format(now);

  }
}

class GeoLocator{
  String latitude;
  String longitude;

  getCurrentPosition() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
  }
}

//class Common with ChangeNotifier, SecureStoreMixin {
//  Xml2Json xml2json = new Xml2Json();
//  final String appName = "towing";
//  String userId = "";
//  String pinNumber = "";
//  String timeZoneName = "";
//
//  getCurrentDateAndTime(){
//    DateTime now = DateTime.now();
//    String date = DateFormat('MM-dd-yyyy').format(now);
//    String time = DateFormat('kk.mm').format(now);
//  }
//
//}