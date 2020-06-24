import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

import '../providers/secureStoreMixin_provider.dart';

class TowType {
  bool errorStatus;
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
      errorStatus: _convertTobool(parsedJson['errorStatus']),
      errorMessage: parsedJson['errorMessage'] != null ?  parsedJson['errorMessage']: '',
      id: (parsedJson['id'] != "0" ? int.parse(parsedJson['id']): 0),
      pinNumber: parsedJson['pinNumber']  != null ?  parsedJson['pinNumber']: '',
      towType: (parsedJson['towType'] != null ? int.parse(parsedJson['towType']): 0),
      towTypeName: parsedJson['towTypeName']  != null ?  parsedJson['towTypeName']: '',
      towAuthorization: (parsedJson['towAuthorization'] != "0" ? int.parse(parsedJson['towAuthorization']): 0),
      towAuthorizationName: parsedJson['towAuthorizationName']  != null ?  parsedJson['towAuthorizationName']: '',
      towReason: (parsedJson['towReason'] != "0" ? int.parse(parsedJson['towReason']): 0),
      towReasonName: parsedJson['towReasonName']  != null ?  parsedJson['towReasonName']: '',
      towJurisdiction: (parsedJson['towJurisdiction'] != "0" ? int.parse(parsedJson['towJurisdiction']): 0),
      towJurisdictionName: parsedJson['towJurisdictionName']  != null ?  parsedJson['towJurisdictionName']: '',
      storageMunicipal: (parsedJson['storageMunicipal'] != "0" ? int.parse(parsedJson['storageMunicipal']): 0),
      storageMunicipalName: parsedJson['storageMunicipalName'] != null ?  parsedJson['storageMunicipalName']: '',

    );
  }
}
bool _convertTobool(value) {
  if (value is String) {
    if (value.toLowerCase() == "true")
      return true;
    else
      return false;
  } else
    return value;
}

class TowTypesVM with ChangeNotifier, SecureStoreMixin {

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
        'https://cktsystems.com/vtscloud/WebServices/relationTowTypeTable.asmx',
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
    //notifyListeners();
  }
}


