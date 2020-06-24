import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/secureStoreMixin_provider.dart';

class SystemPriority {
  String errorStatus;
  String errorMessage;
  int id;
  String name;


  SystemPriority({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.name,

  });

  factory SystemPriority.fromJson(Map<String, dynamic> parsedJson) {
    return SystemPriority(
      errorStatus: parsedJson['errorStatus'] as String,
      errorMessage:parsedJson['errorMessage']  as String,
      id:(parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
      name: parsedJson['name'],

    );
  }
}

class SystemPrioritiesVM with ChangeNotifier, SecureStoreMixin {

  List<SystemPriority> _systemPriorities = [];

  List<SystemPriority> get systemPriorities{
    return [..._systemPriorities]; //gets a copy of the items
  }

  Future list() async {
    Xml2Json xml2json = new Xml2Json();
    List<SystemPriority> systemPriorities;
    systemPriorities =  List<SystemPriority>();

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
        'https://cktsystems.com/vtscloud/WebServices/systemPriorityLevelTable.asmx',
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
    ["listResponse"]["listResult"]["systemPriorityLevelSummarys"];
    //as Map<String,dynamic>;rint

    for (int i = 0; i < extractedData.length; i++) {
      systemPriorities.add(new SystemPriority.fromJson(extractedData[i]));
    }
    _systemPriorities = systemPriorities;
    print(response.body);
    print(_systemPriorities.length);
    //notifyListeners();
  }
}


