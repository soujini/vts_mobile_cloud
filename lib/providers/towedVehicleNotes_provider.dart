import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'calls_provider.dart';

class TowedVehicleNote {
  bool errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  int vehicleCreatedByUserId;
  String vehicleCreatedByUserName;
  String vehicleCreatedDate;
  String vehicleCreatedTime;
  int vehicleModifiedByUserId;
  String vehicleModifiedByUserName;
  String vehicleModifiedDate;
  String vehicleModifiedTime;
  int towedVehicle;
  bool ownerNotes;
  bool paymentNotes;
//  String vehicleNotes; //base64Binary
  String vehicleNotes_string;
  int importID;

  TowedVehicleNote({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.pinNumber,
    this.vehicleCreatedByUserId,
    this.vehicleCreatedByUserName,
    this.vehicleCreatedDate,
    this.vehicleCreatedTime,
    this.vehicleModifiedByUserId,
    this.vehicleModifiedByUserName,
    this.vehicleModifiedDate,
    this.vehicleModifiedTime,
    this.towedVehicle,
    this.ownerNotes,
    this.paymentNotes,
//    this.vehicleNotes, //base64Binary
    this.vehicleNotes_string,
    this.importID,
  });

  factory TowedVehicleNote.fromJson(Map<String, dynamic> json) =>
      _towedVehicleNoteFromJson(json);
}

TowedVehicleNote _towedVehicleNoteFromJson(Map<String, dynamic> parsedJson) {
  return TowedVehicleNote(
      errorStatus: _convertTobool(parsedJson["errorStatus"]),
      errorMessage: parsedJson["errorMessage"],
      id: int.parse(parsedJson["id"]),
      pinNumber: parsedJson["pinNumber"],
      vehicleCreatedByUserId: int.parse(parsedJson["vehicleCreatedByUserId"]),
      vehicleCreatedByUserName: parsedJson["vehicleCreatedByUserName"],
      vehicleCreatedDate: parsedJson["vehicleCreatedDate"],
      vehicleCreatedTime: parsedJson["vehicleCreatedTime"],
      vehicleModifiedByUserId: int.parse(parsedJson["vehicleModifiedByUserId"]),
      vehicleModifiedByUserName: parsedJson["vehicleModifiedByUserName"],
      vehicleModifiedDate: parsedJson["vehicleModifiedDate"],
      vehicleModifiedTime:  parsedJson["vehicleModifiedTime"],
      towedVehicle: int.parse(parsedJson["towedVehicle"]),
      ownerNotes: _convertTobool(parsedJson["ownerNotes"]),
      paymentNotes: _convertTobool(parsedJson["paymentNotes"]),
//      vehicleNotes: parsedJson['vehicleNotes'],
      //base64Binary
      vehicleNotes_string: parsedJson["vehicleNotes_string"],
      importID: int.parse(parsedJson["importID"]));
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

class TowedVehicleNotesVM with ChangeNotifier {
  List<TowedVehicleNote> _towedVehicleNotes = [];
  List<TowedVehicleNote> notes;

  List<TowedVehicleNote> get towedVehicleNotes {
    return [..._towedVehicleNotes]; //gets a copy of the items
  }

  Future<List> listMini(int pageIndex, int pageSize, String _towedVehicle) async {
    Xml2Json xml2json = new Xml2Json();

    //  notes = new List<TowedVehicleNote>();


    int iStart = 0;
    int iEnd = 0;
    if (pageIndex == 0) {
      iStart = 1;
      iEnd = pageSize;
    } else {
      iStart = (pageIndex * pageSize) + 1;
      iEnd = (iStart + pageSize) - 1;
    }

    final String appName = "towing";
    final int userId = 1;
    String filterFields = "";
    filterFields = "pinNumber:PIN0000074|towedVehicle:"+_towedVehicle;

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
        "</listMini >"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://cktsystems.com/vtscloud/WebServices/towedVehicleNotesTable.asmx',
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
    ["listMiniResponse"]["listMiniResult"]["items"]
    ["towedVehicleNotesSummarys"];


    int count = (int.parse(data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"]));

    getTowedVehicleNotes(extractedData, count);
    return towedVehicleNotes;
  }
  getTowedVehicleNotes(extractedData, count) {
    final List<TowedVehicleNote> towedVehicleNotes = [];

    for (var i = 0; i < extractedData.length; i++) {
      //towedVehicleNotes.add(new TowedVehicleNote.fromJson(extractedData[i]));
      towedVehicleNotes.add(new TowedVehicleNote(
        vehicleCreatedByUserName: extractedData[i]["vehicleCreatedByUserName"] != null ? extractedData[i]["vehicleCreatedByUserName"] : '',
        vehicleCreatedDate: extractedData[i]["vehicleCreatedDate"] != null ? extractedData[i]["vehicleCreatedDate"] : '',
        vehicleCreatedTime: extractedData[i]["vehicleCreatedTime"] != null ? extractedData[i]["vehicleCreatedTime"] : '',
        vehicleModifiedByUserName: extractedData[i]["vehicleModifiedByUserName"] != null ? extractedData[i]["vehicleModifiedByUserName"] : '',
        vehicleModifiedDate: extractedData[i]["vehicleModifiedDate"] != null ? extractedData[i]["vehicleModifiedDate"] : '',
        vehicleModifiedTime:  extractedData[i]["vehicleModifiedTime"] != null ? extractedData[i]["vehicleModifiedTime"] : '--',
        vehicleNotes_string: extractedData[i]["vehicleNotes_string"] != null ? extractedData[i]["vehicleNotes_string"] : '--'
      ));

    }
    _towedVehicleNotes = towedVehicleNotes;
    notifyListeners();
  }
}
