import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

class WreckerDriver {
  String errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  int wreckerDriver;
  String wreckerDriverName;
  String QBReference;
  String stateLicense;
  String cityLicense;
  int towTruck;
  String towTruckName;


  WreckerDriver({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.pinNumber,
    this.wreckerDriver,
    this.wreckerDriverName,
    this.QBReference,
    this.stateLicense,
    this.cityLicense,
    this.towTruck,
    this.towTruckName,

  });

  factory WreckerDriver.fromJson(Map<String, dynamic> parsedJson) {
    return WreckerDriver(
      errorStatus: parsedJson['errorStatus'] != null ? parsedJson['errorStatus']: '',
      errorMessage:parsedJson['errorMessage'] != null ? parsedJson['errorMessage']: '',
      id:(parsedJson['id'] != "0" ? int.parse(parsedJson['id']): 0),
      pinNumber:parsedJson['pinNumber'] != null ? parsedJson['pinNumber']: '',
      wreckerDriver: (parsedJson['wreckerDriver'] != null ? int.parse(parsedJson['wreckerDriver']): 0),
      wreckerDriverName: parsedJson['wreckerDriverName'] != null ? parsedJson['wreckerDriverName']: '',
      QBReference: parsedJson['QBReference'] != null ? parsedJson['QBReference']: '',
      stateLicense: parsedJson['stateLicense'] != null ? parsedJson['stateLicense']: '',
      cityLicense: parsedJson['cityLicense'] != null ? parsedJson['cityLicense']: '',
      towTruck: (parsedJson['towTruck'] != "0" ? int.parse(parsedJson['towTruck']): 0),
      towTruckName: parsedJson['towTruckName'] != null ? parsedJson['towTruckName']: '',
    );
  }
}

class WreckerDriversVM with ChangeNotifier {

  List<WreckerDriver> _wreckerDrivers = [];

  List<WreckerDriver> get wreckerDrivers {
    return [..._wreckerDrivers]; //gets a copy of the items
  }

  Future list() async {
    Xml2Json xml2json = new Xml2Json();
    List<WreckerDriver> tc;
    tc =  List<WreckerDriver>();

    final String appName = "towing";
    final int userId = 3556;
    String filterFields = "";

    filterFields = "pinNumber:PIN0000074";

    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<list xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<filterFields>${filterFields}</filterFields>"
        "</list>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://cktsystems.com/vtscloud/WebServices/relationWreckerDriverTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/list",
          "Host": "cktsystems.com"
          //"Accept": "text/xml"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);



    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["listResponse"]["listResult"]["relationWreckerDriverSummarys"];
    //as Map<String,dynamic>;rint

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new WreckerDriver.fromJson(extractedData[i]));
    }
    _wreckerDrivers = tc;
    print(response.body);
    print(_wreckerDrivers.length);
    //notifyListeners();
  }
}


