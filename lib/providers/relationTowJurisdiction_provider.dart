import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

import '../providers/secureStoreMixin_provider.dart';

class TowJurisdiction {
  String errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  int towJurisdiction;
  String towJurisdictionName;

  TowJurisdiction({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.pinNumber,
    this.towJurisdiction,
    this.towJurisdictionName,
  });

  factory TowJurisdiction.fromJson(Map<String, dynamic> parsedJson) {
    return TowJurisdiction(
      errorStatus: parsedJson['errorStatus'] as String,
      errorMessage:parsedJson['errorMessage']  as String,
      id:(parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
      pinNumber:parsedJson['pinNumber'] as String,
      towJurisdiction: (parsedJson['towJurisdiction'] != null ? int.parse(parsedJson['towJurisdiction']): 0),
      towJurisdictionName: parsedJson['towJurisdictionName'] as String,
    );
  }
}

class TowJurisdictionsVM with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";

  List<TowJurisdiction> _towJurisdictions = [];

  List<TowJurisdiction> get towJurisdictions {
    return [..._towJurisdictions]; //gets a copy of the items
  }

  Future list() async {
    List<TowJurisdiction> tc;
    tc =  List<TowJurisdiction>();

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
        'https://cktsystems.com/vtscloud/WebServices/relationTowJurisdictionTable.asmx',
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
    ["listResponse"]["listResult"]["relationTowJurisdictionSummarys"];

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new TowJurisdiction.fromJson(extractedData[i]));
    }
    _towJurisdictions = tc;
  }
  Future listMini(name) async {
    _towJurisdictions = [];
    List<TowJurisdiction> tc;
    tc =  List<TowJurisdiction>();

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
        'https://cktsystems.com/vtscloud/WebServices/relationTowJurisdictionTable.asmx',
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
    ["listMiniResponse"]["listMiniResult"]["items"]["relationTowJurisdictionSummarys"];

    final count = await data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"];

    if(count == "1"){
      tc.add(new TowJurisdiction.fromJson(extractedData));
    }
    else if (count != "1" && count != "0"){
      for (int i = 0; i < extractedData.length; i++) {
        tc.add(new TowJurisdiction.fromJson(extractedData[i]));
      }
    }
    _towJurisdictions = tc;
  }
}


