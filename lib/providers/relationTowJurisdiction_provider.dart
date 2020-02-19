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

  List<TowJurisdiction> _towJurisdictions = [];

  List<TowJurisdiction> get towJurisdictions {
    return [..._towJurisdictions]; //gets a copy of the items
  }

  Future list() async {
    Xml2Json xml2json = new Xml2Json();
    List<TowJurisdiction> tc;
    tc =  List<TowJurisdiction>();

    final String appName = "towing";
    final int userId = 3556;
    String filterFields = "";
    String pinNumber="";
    await getSecureStore('pinNumber', (token) {
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
        'http://cktsystems.com/vtscloud/WebServices/relationTowJurisdictionTable.asmx',
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
    ["listResponse"]["listResult"]["relationTowJurisdictionSummarys"];
    //as Map<String,dynamic>;rint

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new TowJurisdiction.fromJson(extractedData[i]));
    }
    _towJurisdictions = tc;
    print(response.body);
    print(_towJurisdictions.length);
    //notifyListeners();
  }
}


