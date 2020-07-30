import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/secureStoreMixin_provider.dart';


class TowCharge {
  bool errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  int towCharges;
  String towChargesName;
  bool chargesCommission;
  String chargesRate;

  TowCharge({
    this.errorStatus,
      this.errorMessage,
      this.id,
      this.pinNumber,
      this.towCharges,
      this.towChargesName,
      this.chargesCommission,
    this.chargesRate,
  });

  factory TowCharge.fromJson(Map<String, dynamic> parsedJson) {
    return TowCharge(
        errorStatus: _convertTobool(parsedJson["errorStatus"]),
        errorMessage: parsedJson['errorMessage'] as String,
        id: int.parse(parsedJson['id']),
        pinNumber: parsedJson['pinNumber'] as String,
        towCharges: int.parse(parsedJson['towCharges']),
        towChargesName: parsedJson['towChargesName'],
        chargesCommission: _convertTobool(parsedJson['chargesCommission']),
        chargesRate: parsedJson['chargesRate']);
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

class TowChargesVM with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";

  List<TowCharge> _towCharges = [];

  List<TowCharge> get towCharges {
    return [..._towCharges]; //gets a copy of the items
  }

  Future list() async {
    List<TowCharge> tc;
    tc = List<TowCharge>();

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
        'http://74.95.253.45/vtscloud/WebServices/relationTowChargesTable.asmx',
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
        ["listResponse"]["listResult"]["relationTowChargesSummarys"];

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new TowCharge.fromJson(extractedData[i]));
    }
    _towCharges = tc;
  }
  Future listMini(name) async {
    _towCharges = [];
    List<TowCharge> tc;
    tc =  List<TowCharge>();

    final int iStart=1;
    final int iEnd=200;
    String filterFields = "";

   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    filterFields = "name:"+name;

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
        "<iStart>${iStart}</iStart>"
        "<iEnd>${iEnd}</iEnd>"
        "</listMini>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://74.95.253.45/vtscloud/WebServices/relationTowChargesTable.asmx',
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
    ["listMiniResponse"]["listMiniResult"]["items"]["relationTowChargesSummarys"];

    final count = await data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"];

    if(count == "1"){
      tc.add(new TowCharge.fromJson(extractedData));
    }
    else if (count != "1" && count != "0"){
      for (int i = 0; i < extractedData.length; i++) {
        tc.add(new TowCharge.fromJson(extractedData[i]));
      }
    }
    _towCharges = tc;
  }
}
