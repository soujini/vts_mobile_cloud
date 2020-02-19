import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/secureStoreMixin_provider.dart';

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

  List<SystemCity> _systemCities = [];

  List<SystemCity> get systemCities {
    return [..._systemCities]; //gets a copy of the items
  }

  Future list() async {
    Xml2Json xml2json = new Xml2Json();
    List<SystemCity> tc;
    tc =  List<SystemCity>();

    final String appName = "towing";
    final int userId = 3556;
    String filterFields = "";
    bool exact=true;
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
        "<exact>${exact}</exact>"
        "</list>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://cktsystems.com/vtscloud/WebServices/SystemCityTable.asmx',
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
    ["listResponse"]["listResult"]["systemCitySummarys"];
    //as Map<String,dynamic>;rint

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new SystemCity.fromJson(extractedData[i]));
    }
    _systemCities = tc;
    print(response.body);
    print(_systemCities.length);
    //notifyListeners();
  }
}


