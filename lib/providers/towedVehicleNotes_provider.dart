import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'calls_provider.dart';
import '../providers/secureStoreMixin_provider.dart';

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
      pinNumber: parsedJson["pinNumber"] != null ? parsedJson["pinNumber"] : '',
      vehicleCreatedByUserId: int.parse(parsedJson["vehicleCreatedByUserId"]),
      vehicleCreatedByUserName: parsedJson["vehicleCreatedByUserName"] != null ? parsedJson["vehicleCreatedByUserName"] :'',
      vehicleCreatedDate: parsedJson["vehicleCreatedDate"] != null ? parsedJson["vehicleCreatedDate"] :'',
      vehicleCreatedTime: parsedJson["vehicleCreatedTime"] != null ? parsedJson["vehicleCreatedTime"] : '',
      vehicleModifiedByUserId: int.parse(parsedJson["vehicleModifiedByUserId"]),
      vehicleModifiedByUserName: parsedJson["vehicleModifiedByUserName"] != null ? parsedJson["vehicleModifiedByUserName"] : '',
      vehicleModifiedDate: parsedJson["vehicleModifiedDate"] != null ? parsedJson["vehicleModifiedDate"] : '',
      vehicleModifiedTime:  parsedJson["vehicleModifiedTime"] != null ? parsedJson["vehicleModifiedTime"] : '',
      towedVehicle: int.parse(parsedJson["towedVehicle"]),
      ownerNotes: _convertTobool(parsedJson["ownerNotes"]),
      paymentNotes: _convertTobool(parsedJson["paymentNotes"]),
//      vehicleNotes: parsedJson['vehicleNotes'],
      //base64Binary
      vehicleNotes_string: parsedJson["vehicleNotes_string"] != null ? parsedJson["vehicleNotes_string"] : '',
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

class TowedVehicleNotesVM with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";

  List<TowedVehicleNote> _towedVehicleNotes = [];
  List<TowedVehicleNote> notes;

  List<TowedVehicleNote> get towedVehicleNotes {
    return [..._towedVehicleNotes]; //gets a copy of the items
  }

  Future<List> listMini(int pageIndex, int pageSize, String _towedVehicle) async {
    int iStart = 0;
    int iEnd = 0;
    if (pageIndex == 0) {
      iStart = 1;
      iEnd = pageSize;
    } else {
      iStart = (pageIndex * pageSize) + 1;
      iEnd = (iStart + pageSize) - 1;
    }

    String filterFields = "";

   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    filterFields = "pinNumber:"+pinNumber+"|towedVehicle:"+_towedVehicle;

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
        'https://cktsystems.com/vtscloud/WebServices/towedVehicleNotesTable.asmx',
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
    ["listMiniResponse"]["listMiniResult"]["items"]
    ["towedVehicleNotesSummarys"];

    int count = (int.parse(data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"]));

    getTowedVehicleNotes(extractedData, count);
    return towedVehicleNotes;
  }
  getTowedVehicleNotes(extractedData, count) {
    final List<TowedVehicleNote> towedVehicleNotes = [];

    if(count == 1){
      towedVehicleNotes.add(new TowedVehicleNote.fromJson(extractedData));
    }
    else if(count > 1) {
      for (var i = 0; i < extractedData.length; i++) {
        towedVehicleNotes.add(new TowedVehicleNote.fromJson(extractedData[i]));
      }
    }
      _towedVehicleNotes = towedVehicleNotes;
      notifyListeners();
  }
}
