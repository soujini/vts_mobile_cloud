import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/secureStoreMixin_provider.dart';


class VehicleMake {
  String errorStatus;
  String errorMessage;
  int id;
  String shortName;
  String name;
  String vehicleMakeGroup;
  String vehicleMakeGroupName;

  VehicleMake(
      {this.errorStatus,
      this.errorMessage,
      this.id,
      this.shortName,
      this.name,
      this.vehicleMakeGroup,
      this.vehicleMakeGroupName});

  factory VehicleMake.fromJson(Map<String, dynamic> parsedJson) {
    return VehicleMake(
        errorStatus: parsedJson['errorStatus'] as String,
        errorMessage: parsedJson['errorMessage'] as String,
        id: (parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
        shortName: parsedJson['shortName'] as String,
        name: parsedJson['name'],
        vehicleMakeGroup: parsedJson['vehicleMakeGroup'],
        vehicleMakeGroupName: parsedJson['vehicleMakeGroupName']);
  }
}

class VehicleMakesVM with ChangeNotifier, SecureStoreMixin {
  List<VehicleMake> _vehicleMakes = [];

  List<VehicleMake> get vehicleMakes {
    return [..._vehicleMakes]; //gets a copy of the items
  }

  Future list() async {
    Xml2Json xml2json = new Xml2Json();
    List<VehicleMake> tc;
    tc = List<VehicleMake>();

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
        'http://cktsystems.com/vtscloud/WebServices/vehicleMakeTable.asmx',
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
        ["listResponse"]["listResult"]["vehicleMakeSummarys"];
//as Map<String,dynamic>;rint

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new VehicleMake.fromJson(extractedData[i]));
    }
    _vehicleMakes = tc;
    print(response.body);
    print(_vehicleMakes.length);
//notifyListeners();
  }
}
