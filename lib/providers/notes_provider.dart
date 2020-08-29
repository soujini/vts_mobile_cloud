import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

import '../providers/secureStoreMixin_provider.dart';

class Note {
  int vehicleCreatedByUserId;
  int towedVehicle;
  String vehicleNotes_string;
  bool ownerNotes;
  bool paymentNotes;

  Map<String, dynamic> toJson() => <String, dynamic>{
    "vehicleCreatedByUserId":vehicleCreatedByUserId,
    "towedVehicle":towedVehicle,
    "vehicleNotes_string":vehicleNotes_string,
    "ownerNotes":ownerNotes,
    "paymentNotes":paymentNotes,
  };

  Note({
    @required this.vehicleCreatedByUserId,
    @required this.towedVehicle,
    @required this.vehicleNotes_string,
    this.ownerNotes,
    this.paymentNotes
  });

  factory Note.fromJson(Map<String, dynamic> json) =>
      _towedVehicleNotesFromJson(json);
}

Note _towedVehicleNotesFromJson(Map<String, dynamic> parsedJson) {
  return Note(
      vehicleCreatedByUserId: parsedJson["vehicleCreatedByUserId"],
      towedVehicle: parsedJson["towedVehicle"],
      vehicleNotes_string: parsedJson["vehicleNotes_string"],
      ownerNotes: _convertTobool(parsedJson["ownerNotes"]),
      paymentNotes: _convertTobool(parsedJson["paymentNotes"]));
}

class NotesVM with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";
  List<Note> _notes = [];

  List<Note> get notes {
    return [..._notes]; //gets a copy of the items
  }

  Future<List> create(noteObj) async {
    List<String> fieldList;
    String xmlValues="";

   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });
   await  getSecureStore('timeZoneName', (token) {
      timeZoneName=token;
    });
    var objText = jsonEncode(noteObj);
    Note note = Note.fromJson(jsonDecode(objText));

    fieldList = [
      "pinNumber:"+pinNumber,
      "vehicleCreatedByUserId:"+userId,
      "towedVehicle:"+note.towedVehicle.toString(),
      'ownerNotes:'+note.ownerNotes.toString(),
      'paymentNotes:'+note.paymentNotes.toString(),
    ];
    xmlValues = fieldList.map((v) => '<string>$v</string>').join();
    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<create xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<fieldList>${xmlValues}</fieldList>"
        "<vehicleNotes_string>${noteObj.vehicleNotes_string}</vehicleNotes_string>"
        "<timeZoneName>${timeZoneName}</timeZoneName>"
        "</create>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'https://cktsystems.com/vtscloud/WebServices/towedvehicleNotesTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/create",
          "Host": "cktsystems.com"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["createResponse"]["createResult"];
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

