import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

import '../providers/secureStoreMixin_provider.dart';

class VehicleYearMakeModel {
  bool errorStatus;
  String errorMessage;
  int id;
  int vehicleYear;
  int vehicleMake;
  String vehicleMakeName;
  String vehicleModelName;
  String vehicleMakeTrim;
  String vehicleModelLookup;
  int vehicleModelStart;
  int vehicleModelLength;
  String vehicleYearMakeModelName;

  VehicleYearMakeModel(
      {
        this.errorStatus,
        this.errorMessage,
        this.id,
        this.vehicleYear,
        this.vehicleMake,
        this.vehicleMakeName,
        this.vehicleModelName,
        this.vehicleMakeTrim,
        this.vehicleModelLookup,
        this.vehicleModelStart,
        this.vehicleModelLength,
        this.vehicleYearMakeModelName

      });



  factory VehicleYearMakeModel.fromJson(Map<String, dynamic> parsedJson) {
    return VehicleYearMakeModel(
      errorStatus: _convertTobool(parsedJson['errorStatus']),
      errorMessage: parsedJson['errorMessage'] as String,
      id: (parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
      vehicleYear: (parsedJson['id'] != null ? int.parse(parsedJson['vehicleYear']): 0),
      vehicleMake: (parsedJson['id'] != null ? int.parse(parsedJson['vehicleMake']): 0),
      vehicleMakeName: parsedJson['vehicleMakeName'],

      vehicleModelName: parsedJson['vehicleModelName'],
      vehicleMakeTrim: parsedJson['vehicleMakeTrim'],
      vehicleModelLookup: parsedJson['vehicleModelLookup'],
      vehicleModelStart: (parsedJson['id'] != null ? int.parse(parsedJson['vehicleModelStart']): 0),
      vehicleModelLength: (parsedJson['id'] != null ? int.parse(parsedJson['vehicleModelLength']): 0),
      vehicleYearMakeModelName: parsedJson['vehicleYearMakeModelName'],
    );
  }
}

class VehicleYearMakeModelsVM with ChangeNotifier, SecureStoreMixin {
  List<VehicleYearMakeModel> _vehicleYearMakeModels = [];

  List<VehicleYearMakeModel> get vehicleYearMakeModels {
    return [..._vehicleYearMakeModels]; //gets a copy of the items
  }

  Future listMini() async {
    Xml2Json xml2json = new Xml2Json();
    List<VehicleYearMakeModel> tc;
    tc = List<VehicleYearMakeModel>();
    String pinNumber="";
    await getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    final String appName = "towing";
    final int userId = 3556;
    String filterFields = "pinNumber:"+pinNumber;
    final int iStart = 1;
    final int iEnd = 10;

    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<listMini  xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<filterFields>${filterFields}</filterFields>"
        "<iStart>${iStart}</iStart>"
        "<iEnd>${iEnd}</iEnd>"
        "</listMini>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'https://cktsystems.com/vtscloud/WebServices/vehicleYearMakeModelTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/listMini",
          "Host": "cktsystems.com"
//"Accept": "text/xml"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["items"]["vehicleYearMakeModelSummarys"];
//as Map<String,dynamic>;rint

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new VehicleYearMakeModel.fromJson(extractedData[i]));
    }
    _vehicleYearMakeModels = tc;
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