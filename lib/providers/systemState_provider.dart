import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/common_provider.dart';
import '../providers/secureStoreMixin_provider.dart';

class SystemState {
  String errorStatus;
  String errorMessage;
  int id;
  String shortName;
  String name;

  SystemState({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.shortName,
    this.name,
  });

  factory SystemState.fromJson(Map<String, dynamic> parsedJson) {
    return SystemState(
      errorStatus: parsedJson['errorStatus'] as String,
      errorMessage:parsedJson['errorMessage']  as String,
      id:(parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
      shortName:parsedJson['shortName'] as String,
      name: parsedJson['name'],
    );
  }
}

class SystemStatesVM with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  API api = API();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";

  List<SystemState> _systemStates = [];

  List<SystemState> get systemStates {
    return [..._systemStates]; //gets a copy of the items
  }

  Future list() async {
    List<SystemState> tc;
    tc =  List<SystemState>();

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
        api.baseURL+'SystemStateTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/list",
          "Host": api.host
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);
    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["listResponse"]["listResult"]["systemStateSummarys"];

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new SystemState.fromJson(extractedData[i]));
    }
    _systemStates = tc;
  }

  Future listMini(name) async {
    _systemStates = [];
    List<SystemState> tc;
    tc =  List<SystemState>();

    final int iStart=1;
    final int iEnd=200;
    String filterFields = "";

   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    filterFields = "shortName:"+name;

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
        api.baseURL+'SystemStateTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/listMini",
          "Host": api.host
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["items"]["systemStateSummarys"];

    int count = (int.parse(data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"]));

    if(count == 1 || iStart == count){
      tc.add(new SystemState.fromJson(extractedData));
    }
    else if (count > 1){
      for (int i = 0; i < extractedData.length; i++) {
        tc.add(new SystemState.fromJson(extractedData[i]));
      }
    }
    _systemStates = tc;
  }
}


