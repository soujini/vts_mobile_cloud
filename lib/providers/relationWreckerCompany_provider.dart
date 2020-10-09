import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/secureStoreMixin_provider.dart';

class WreckerCompany {
  String errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  int wreckerCompany;
  String wreckerCompanyName;
  String QBReference;
  String documentHeader;
  String stateLicense;
  String cityLicense;


  WreckerCompany({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.pinNumber,
    this.wreckerCompany,
    this.wreckerCompanyName,
    this.QBReference,
    this.documentHeader,
    this.stateLicense,
    this.cityLicense,
  });

  factory WreckerCompany.fromJson(Map<String, dynamic> parsedJson) {
    return WreckerCompany(
      errorStatus: parsedJson['errorStatus'] as String,
      errorMessage:parsedJson['errorMessage']  as String,
      id:(parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
      pinNumber:parsedJson['pinNumber'] as String,
      wreckerCompany: (parsedJson['wreckerCompany'] != null ? int.parse(parsedJson['wreckerCompany']): 0),
      wreckerCompanyName: parsedJson['wreckerCompanyName'] as String,
      QBReference: parsedJson['QBReference'] as String,
      documentHeader: parsedJson['documentHeader'] as String,
      stateLicense: parsedJson['stateLicense'] != null ? parsedJson['stateLicense'] :'',
      cityLicense: parsedJson['cityLicense'] != null ? parsedJson['cityLicense'] :'',
    );
  }
}

class WreckerCompaniesVM with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";

  List<WreckerCompany> _wreckerCompanies = [];

  List<WreckerCompany> get wreckerCompanies {
    return [..._wreckerCompanies]; //gets a copy of the items
  }

  Future list() async {
    Xml2Json xml2json = new Xml2Json();
    List<WreckerCompany> tc;
    tc =  List<WreckerCompany>();

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
        'https://cktsystems.com/vtscloud/WebServices/relationWreckerCompanyTable.asmx',
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
    ["listResponse"]["listResult"]["relationWreckerCompanySummarys"];

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new WreckerCompany.fromJson(extractedData[i]));
    }
    _wreckerCompanies = tc;
  }
  Future listMini(name) async {
    _wreckerCompanies = [];
    List<WreckerCompany> tc;
    tc =  List<WreckerCompany>();

    final int iStart=1;
    final int iEnd=200;
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
        "<listMini xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<filterFields>${filterFields}</filterFields>"
        "<name>${name}</name>"
        "<iStart>${iStart}</iStart>"
        "<iEnd>${iEnd}</iEnd>"
        "</listMini>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'https://cktsystems.com/vtscloud/WebServices/relationWreckerCompanyTable.asmx',
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
    ["listMiniResponse"]["listMiniResult"]["items"]["relationWreckerCompanySummarys"];

    int count = (int.parse(data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"]));

    if(count == 1 || iStart == count){
      tc.add(new WreckerCompany.fromJson(extractedData));
    }
    else if (count > 1){
      for (int i = 0; i < extractedData.length; i++) {
        tc.add(new WreckerCompany.fromJson(extractedData[i]));
      }
    }
    _wreckerCompanies = tc;
    _wreckerCompanies = tc;
  }
}


