import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

class StorageCompany {
  String errorStatus;
  String errorMessage;
  int towedInvoice;

  StorageCompany({
    this.errorStatus,
    this.errorMessage,
    this.towedInvoice,
  });
  factory StorageCompany.fromJson(Map<String, dynamic> json) =>
      _towCustomerFromJson(json);
}

StorageCompany _towCustomerFromJson(Map<String, dynamic> parsedJson) {
  return StorageCompany(
      errorStatus: parsedJson['errorStatus'],
      errorMessage: parsedJson['errorMessage'],
      towedInvoice: int.parse(parsedJson['towedInvoice']));
}

class StorageCompaniesVM with ChangeNotifier {
  var _storageCompanyData;
  var sc;

   get storageCompanyData{
    return _storageCompanyData;
  }

  Future get(String sx) async {
    Xml2Json xml2json = new Xml2Json();

    final String appName = "towing";
    final int userId = 3556;
    int id = int.parse(sx);

    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<get xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<id>${id}</id>"
        "</get>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://cktsystems.com/vtscloud/WebServices/storageCompanyTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/get",
          "Host": "cktsystems.com"
          //"Accept": "text/xml"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["getResponse"]["getResult"];

    sc = Map.from(extractedData);

  }
}