import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

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

class API{
  String _baseURL;
  String _host;

  API(){
    getBaseURL();
  }

  get baseURL {
    return _baseURL; //gets a copy of the items
  }
  get host {
    return _host; //gets a copy of the items
  }

  getBaseURL() async{
    if (kReleaseMode) {
      _baseURL = "https://myvtscloud.net/WebServices/";
      _host = "myvtscloud.net";
        print(_baseURL);
    } else {
      _baseURL = "https://cktsystems.com/vtscloud/WebServices/";
      _host = "cktsystems.com";
        print(_baseURL);
    }
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