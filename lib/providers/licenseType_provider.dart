import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

class LicenseType {
  String errorStatus;
  String errorMessage;
  int id;
  String shortName;
  String name;


  LicenseType({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.shortName,
    this.name,

  });

  factory LicenseType.fromJson(Map<String, dynamic> parsedJson) {
    return LicenseType(
        errorStatus: parsedJson['errorStatus'] as String,
        errorMessage:parsedJson['errorMessage']  as String,
        id:(parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
        shortName:parsedJson['shortName'] as String,
        name: parsedJson['name'],
    );
  }
}

class LicenseTypesVM with ChangeNotifier {

  List<LicenseType> _licenseTypes = [];

  List<LicenseType> get licenseTypes {
    return [..._licenseTypes]; //gets a copy of the items
  }

  Future list() async {
    Xml2Json xml2json = new Xml2Json();
    List<LicenseType> licenseTypes;
    licenseTypes =  List<LicenseType>();

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
        'http://cktsystems.com/vtscloud/WebServices/vehicleLicenseTypeTable.asmx',
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
    ["listResponse"]["listResult"]["vehicleLicenseTypeSummarys"];
    //as Map<String,dynamic>;rint

    for (int i = 0; i < extractedData.length; i++) {
      licenseTypes.add(new LicenseType.fromJson(extractedData[i]));
    }
    _licenseTypes = licenseTypes;
    //notifyListeners();
  }
}


