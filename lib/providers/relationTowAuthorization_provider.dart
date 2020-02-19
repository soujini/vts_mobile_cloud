import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

import '../providers/secureStoreMixin_provider.dart';

class TowAuthorization {
  String errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  int towAuthorization;
  String towAuthorizationName;

  TowAuthorization({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.pinNumber,
    this.towAuthorization,
    this.towAuthorizationName
  });

  factory TowAuthorization.fromJson(Map<String, dynamic> parsedJson) {
    return TowAuthorization(
      errorStatus: parsedJson['errorStatus'] as String,
      errorMessage:parsedJson['errorMessage']  as String,
      id: (parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
      pinNumber: parsedJson['pinNumber'] as String,
      towAuthorization:(parsedJson['towAuthorization'] != null ? int.parse(parsedJson['towAuthorization']): 0),
      towAuthorizationName: parsedJson['towAuthorizationName'] as String,
    );
  }
}

class TowAuthorizationsVM with ChangeNotifier, SecureStoreMixin {

  List<TowAuthorization> _towAuthorizations = [];

  List<TowAuthorization> get towAuthorizations {
    return [..._towAuthorizations]; //gets a copy of the items
  }

  Future list() async {
    Xml2Json xml2json = new Xml2Json();
    List<TowAuthorization> tc;
    tc =  List<TowAuthorization>();

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
        'http://cktsystems.com/vtscloud/WebServices/relationTowAuthorizationTable.asmx',
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
    ["listResponse"]["listResult"]["relationTowAuthorizationSummarys"];

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new TowAuthorization.fromJson(extractedData[i]));
    }
    _towAuthorizations = tc;
  }
}


