import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/secureStoreMixin_provider.dart';
import '../providers/common_provider.dart';

class SystemCity {
  String errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  String name;
  int systemState;
  String systemStateName;
  int systemRegion;
  String systemRegionName;


  SystemCity({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.pinNumber,
    this.name,
    this.systemState,
    this.systemStateName,
    this.systemRegion,
    this.systemRegionName,

  });

  factory SystemCity.fromJson(Map<String, dynamic> parsedJson) {
    return SystemCity(
      errorStatus: parsedJson['errorStatus'] as String,
      errorMessage:parsedJson['errorMessage']  as String,
      id:(parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
      pinNumber:parsedJson['pinNumber'] as String,
      name: parsedJson['name'],
      systemState: (parsedJson['systemState'] != null ? int.parse(parsedJson['systemState']): 0),
      systemStateName: parsedJson['systemStateName'] as String,
      systemRegion: (parsedJson['systemRegion'] != null ? int.parse(parsedJson['systemRegion']): 0),
      systemRegionName: parsedJson['systemRegionName'] as String,

    );
  }
}

class SystemCitiesVM with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  API api = API();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";

  List<SystemCity> _systemCities = [];

  List<SystemCity> get systemCities {
    return [..._systemCities]; //gets a copy of the items
  }

  Future list() async {
    List<SystemCity> tc;
    tc =  List<SystemCity>();

    String filterFields = "";
    bool exact=true;

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
        "<exact>${exact}</exact>"
        "</list>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        api.baseURL+'SystemCityTable.asmx',
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
    ["listResponse"]["listResult"]["systemCitySummarys"];

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new SystemCity.fromJson(extractedData[i]));
    }
    _systemCities = tc;
  }

  Future listMini(cityName,state) async {
    _systemCities = [];
    List<SystemCity> tc;
    tc =  List<SystemCity>();

    final int iStart=1;
    final int iEnd=200;
    String filterFields = "";

   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    filterFields = "name:"+cityName+"|systemState:"+state;

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
        api.baseURL+'SystemCityTable.asmx',
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
    ["listMiniResponse"]["listMiniResult"]["items"]["systemCitySummarys"];

    int count = (int.parse(data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"]));

    if(count == 1 || iStart == count){
      tc.add(new SystemCity.fromJson(extractedData));
    }
    else if (count > 1){
      for (int i = 0; i < extractedData.length; i++) {
        tc.add(new SystemCity.fromJson(extractedData[i]));
      }
    }
    _systemCities = tc;
  }
}


