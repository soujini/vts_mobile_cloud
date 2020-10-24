import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/secureStoreMixin_provider.dart';

class TowedVehiclePicture {
  bool errorStatus;
  String errorMessage;
  int id;
  String base64Photo;
  int vehiclePictureType;
  String vehiclePictureTypeName;
  String vehicleNotes;
  int towedVehicle;
  String vehicleCreatedDate;
  String vehicleCreatedTime;
  String vehicleCreatedByUserName;
  int vehicleCreatedByUserId;

  TowedVehiclePicture({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.base64Photo,
    this.vehiclePictureType,
    this.vehiclePictureTypeName,
    this.vehicleNotes,
    this.towedVehicle,
    this.vehicleCreatedDate,
    this.vehicleCreatedTime,
    this.vehicleCreatedByUserName,
    this.vehicleCreatedByUserId
  });

  factory TowedVehiclePicture.fromJson(Map<String, dynamic> json) =>
      _towedVehiclePictureFromJson(json);
}

TowedVehiclePicture _towedVehiclePictureFromJson(
    Map<String, dynamic> parsedJson) {
  return TowedVehiclePicture(
      errorStatus: _convertTobool(parsedJson["errorStatus"]),
      errorMessage: parsedJson["errorMessage"],
      id: int.parse(parsedJson["id"]),
      base64Photo: parsedJson["base64Photo"] != null ? parsedJson["base64Photo"] :'',
      vehiclePictureType: int.parse(parsedJson["vehiclePictureType"]),
      vehiclePictureTypeName: parsedJson["vehiclePictureTypeName"] != null ? parsedJson["vehiclePictureTypeName"] : '',
      vehicleNotes: parsedJson["vehicleNotes"] != null ? parsedJson["vehicleNotes"] : '',
      towedVehicle: int.parse(parsedJson["towedVehicle"]),
      vehicleCreatedByUserId: int.parse(parsedJson["vehicleCreatedByUserId"]),
      vehicleCreatedDate: parsedJson["vehicleCreatedDate"] != null ? parsedJson["vehicleCreatedDate"] : '',
      vehicleCreatedTime: parsedJson["vehicleCreatedTime"] != null ? parsedJson["vehicleCreatedTime"] : '',
      vehicleCreatedByUserName: parsedJson["vehicleCreatedByUserName"] != null ? parsedJson["vehicleCreatedByUserName"] : '',
      );

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

class TowedVehiclePicturesVM with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";

  var picturesDeleteResponse;
  var picturesCreateResponse;

  var selectedPicture = new TowedVehiclePicture();
  List<TowedVehiclePicture> _towedVehiclePictures = [];
  List<TowedVehiclePicture> notes;

  List<TowedVehiclePicture> get towedVehiclePictures {
    return [..._towedVehiclePictures]; //gets a copy of the items
  }
  Future<void> delete(id,towedVehicle) async {

    await  getSecureStore('userId', (token) {
      userId=token;
    });
    await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });
    await  getSecureStore('timeZoneName', (token) {
      timeZoneName=token;
    });

    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<delete xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<id>${id}</id>"
        "<pinNumber>${pinNumber}</pinNumber>"
        "<towedVehicle>${towedVehicle}</towedVehicle>"
        "<timeZoneName>${timeZoneName}</timeZoneName>"
        "</delete>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'https://cktsystems.com/vtscloud/WebServices/towedvehiclePicturesTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/delete",
          "Host": "cktsystems.com"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["deleteResponse"]["deleteResult"];
    picturesDeleteResponse = Map.from(extractedData);
  }

  Future<List> create(chargesObj) async {
    Xml2Json xml2json = new Xml2Json();

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

    fieldList = [
      "pinNumber:"+pinNumber,
      "vehicleCreatedByUserId:"+userId,
      "vehiclePictureType:"+chargesObj.vehiclePictureType.toString(),
      "vehicleNotes: ",
      'towedVehicle:'+chargesObj.towedVehicle.toString(),
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
        "<base64Photo>${chargesObj.base64Photo}</base64Photo>"
        "<userId>${userId}</userId>"
        "<fieldList>${xmlValues}</fieldList>"
        "<timeZoneName>${timeZoneName}</timeZoneName>"
        "</create>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'https://cktsystems.com/vtscloud/WebServices/towedVehiclePicturesTable.asmx',
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

    picturesCreateResponse = Map.from(extractedData);
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

    filterFields = "pinNumber:"+pinNumber+"|towedVehicle:" + _towedVehicle;

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
        'https://cktsystems.com/vtscloud/WebServices/towedVehiclePicturesTable.asmx',
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
    ["towedVehiclePicturesSummarys"];

    int count = (int.parse(data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"]));

    getTowedVehiclePictures(extractedData, count, iStart);
    return towedVehiclePictures;
  }

  getTowedVehiclePictures(extractedData, count, iStart) {
    final List<TowedVehiclePicture> towedVehiclePictures = [];

    if (count == 1 || iStart == count) {
      towedVehiclePictures.add(new TowedVehiclePicture.fromJson(extractedData));
    }

    else if(count > 1){
      for (var i = 0; i < extractedData.length; i++) {
        towedVehiclePictures.add(new TowedVehiclePicture.fromJson(extractedData[i]));
      }
    }
    _towedVehiclePictures = towedVehiclePictures;
    notifyListeners();
  }
}
