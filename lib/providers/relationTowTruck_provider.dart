import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/secureStoreMixin_provider.dart';

class TowTruck {
  String errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  int towTruck;
  String towTruckName;
  String licensePlate;
  String VIN;

  TowTruck({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.pinNumber,
    this.towTruck,
    this.towTruckName,
    this.licensePlate,
    this.VIN,
  });

  factory TowTruck.fromJson(Map<String, dynamic> parsedJson) {
    return TowTruck(
      errorStatus: parsedJson['errorStatus'] != null ? parsedJson['errorStatus'] : '',
      errorMessage:parsedJson['errorMessage'] != null ? parsedJson['errorMessage'] : '',
      id:(parsedJson['id'] != "0" ? int.parse(parsedJson['id']) : 0),
      pinNumber:parsedJson['pinNumber'] != null ? parsedJson['pinNumber'] : '',
      towTruck: (parsedJson['towTruck'] != "0" ? int.parse(parsedJson['towTruck']) : 0),
      towTruckName: parsedJson['towTruckName'] != null ? parsedJson['towTruckName'] : '',
      licensePlate: parsedJson['licensePlate'] != null ? parsedJson['licensePlate'] : '',
      VIN: parsedJson['VIN'] != null ? parsedJson['VIN'] : '',
    );
  }
}

class TowTrucksVM with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";

  List<TowTruck> _towTrucks = [];

  List<TowTruck> get towTrucks {
    return [..._towTrucks]; //gets a copy of the items
  }

  Future list() async {
    List<TowTruck> tc;
    tc =  List<TowTruck>();

    String filterFields = "";

   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    filterFields = "pinNumber:"+pinNumber;

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
        'https://cktsystems.com/vtscloud/WebServices/relationTowTruckTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/list",
          "Host": "cktsystems.com"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);
    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["listResponse"]["listResult"]["relationTowTruckSummarys"];

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new TowTruck.fromJson(extractedData[i]));
    }
    _towTrucks = tc;
  }

  Future listMini(name) async {
    _towTrucks = [];
    List<TowTruck> tc;
    tc =  List<TowTruck>();

    final int iStart=1;
    final int iEnd=200;
    String filterFields = "";

   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    filterFields = "pinNumber:"+pinNumber;

    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<listMini xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<filterFields>${filterFields}</filterFields>"
        "<name>${name}</name>"
        "<iStart>${iStart}</iStart>"
        "<iEnd>${iEnd}</iEnd>"
        "</listMini>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'https://cktsystems.com/vtscloud/WebServices/relationTowTruckTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/listMini",
          "Host": "cktsystems.com"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["items"]["relationTowTruckSummarys"];

    final count = await data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"];

    if(count == "1"){
      tc.add(new TowTruck.fromJson(extractedData));
    }
    else if (count != "1" && count != "0"){
      for (int i = 0; i < extractedData.length; i++) {
        tc.add(new TowTruck.fromJson(extractedData[i]));
      }
    }
    _towTrucks = tc;
  }
}


