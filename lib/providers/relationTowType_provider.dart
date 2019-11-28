import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

class TowType {
  String errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  int towType;
  String towTypeName;
  int towAuthorization;
  String towAuthorizationName;
  int towReason;
  String towReasonName;
  int towJurisdiction;
  String towJurisdictionName;
  int storageMunicipal;
  String storageMunicipalName;


  TowType({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.pinNumber,
    this.towType,
    this.towTypeName,
    this.towAuthorization,
    this.towAuthorizationName,
    this.towReason,
    this.towReasonName,
    this.towJurisdiction,
    this.towJurisdictionName,
    this.storageMunicipal,
    this.storageMunicipalName,
  });

  factory TowType.fromJson(Map<String, dynamic> parsedJson) {
    return TowType(
      errorStatus: parsedJson['errorStatus'] as String,
      errorMessage:parsedJson['errorMessage']  as String,
      id:(parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
      pinNumber:parsedJson['pinNumber'] as String,
      towType: (parsedJson['towType'] != null ? int.parse(parsedJson['towType']): 0),
      towTypeName: parsedJson['towTypeName'] as String,
      towAuthorization: (parsedJson['towAuthorization'] != null ? int.parse(parsedJson['towAuthorization']): 0),
      towAuthorizationName: parsedJson['towAuthorizationName'] as String,
      towReason: (parsedJson['towReason'] != null ? int.parse(parsedJson['towReason']): 0),
      towReasonName: parsedJson['towAuthorizationName'] as String,
      towJurisdiction: (parsedJson['towJurisdiction'] != null ? int.parse(parsedJson['towJurisdiction']): 0),
      towJurisdictionName: parsedJson['towAuthorizationName'] as String,
      storageMunicipal: (parsedJson['storageMunicipal'] != null ? int.parse(parsedJson['storageMunicipal']): 0),
      storageMunicipalName: parsedJson['towAuthorizationName'] as String,

    );
  }
}

class TowTypesVM with ChangeNotifier {

  List<TowType> _towTypes = [];

  List<TowType> get towTypes {
    return [..._towTypes]; //gets a copy of the items
  }

  Future list() async {
    Xml2Json xml2json = new Xml2Json();
    List<TowType> tc;
    tc =  List<TowType>();

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
        'http://cktsystems.com/vtscloud/WebServices/relationTowTypeTable.asmx',
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
    ["listResponse"]["listResult"]["relationTowTypeSummarys"];
    //as Map<String,dynamic>;rint

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new TowType.fromJson(extractedData[i]));
    }
    _towTypes = tc;
    print(response.body);
    print(_towTypes.length);
    //notifyListeners();
  }
}


