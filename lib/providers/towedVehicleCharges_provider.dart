import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/secureStoreMixin_provider.dart';
import '../providers/common_provider.dart';

class TowedVehicleCharge {
  bool errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  int towCharges;
  String towChargesName;
  String chargesRate;
  String chargesQuantity;
  String discountQuantity;
  String discountRate;
  bool discountApply;
  bool chargesTaxable;
  bool chargesCommission;
  bool storageCharge;
  bool lockedCharge;
  bool heavyDuty;
  bool accruedCharge;
  int towedVehicle;
  String totalCharges;

  TowedVehicleCharge({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.pinNumber,
    this.towCharges,
    this.towChargesName,
    this.chargesRate,
    this.chargesQuantity,
    this.discountQuantity,
    this.discountRate,
    this.discountApply,
    this.chargesTaxable,
    this.chargesCommission,
    this.storageCharge,
    this.lockedCharge,
    this.heavyDuty,
    this.accruedCharge,
    this.towedVehicle,
    this.totalCharges,
  });

  factory TowedVehicleCharge.fromJson(Map<String, dynamic> json) =>
      _towedVehicleChargeFromJson(json);
}

TowedVehicleCharge _towedVehicleChargeFromJson(
    Map<String, dynamic> parsedJson) {
  return TowedVehicleCharge(
      errorStatus: _convertTobool(parsedJson["errorStatus"]),
      errorMessage: parsedJson["errorMessage"],
      id: int.parse(parsedJson["id"]),
      pinNumber: parsedJson["pinNumber"] != null ? parsedJson["pinNumber"] :'',
      towCharges: int.parse(parsedJson["towCharges"]),
      towChargesName: parsedJson["towChargesName"] != null ? parsedJson["towChargesName"] : '',
      chargesRate: parsedJson["chargesRate"] != null ? parsedJson["chargesRate"] :'',
      chargesQuantity: parsedJson["chargesQuantity"] != null ? parsedJson["chargesQuantity"] : '',
      discountQuantity: parsedJson["discountQuantity"] != null ? parsedJson["discountQuantity"] : '',
      discountRate:parsedJson["discountRate"] != null ? parsedJson["discountRate"] :'',
      discountApply: _convertTobool(parsedJson["discountApply"]),
      chargesTaxable: _convertTobool(parsedJson["chargesTaxable"]),
      chargesCommission: _convertTobool(parsedJson["chargesCommission"]),
      storageCharge: _convertTobool(parsedJson["storageCharge"]),
      lockedCharge: _convertTobool(parsedJson["lockedCharge"]),
      heavyDuty: _convertTobool(parsedJson["heavyDuty"]),
      accruedCharge: _convertTobool(parsedJson["accruedCharge"]),
      towedVehicle: int.parse(parsedJson["towedVehicle"]),
      totalCharges: parsedJson["totalCharges"] != null ? parsedJson["totalCharges"] : '');
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

class TowedVehicleChargesVM with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  API api = API();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";

  var selectedCharge = new TowedVehicleCharge();
  List<TowedVehicleCharge> _towedVehicleCharges = [];
  List<TowedVehicleCharge> notes;

  var createResponse;
  var chargesUpdateResponse;
  var chargesDeleteResponse;

  List<TowedVehicleCharge> get towedVehicleCharges {
    return [..._towedVehicleCharges]; //gets a copy of the items
  }

  Future<List> create(chargesObj) async {
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
      "towCharges:"+chargesObj.towCharges.toString(),
      "chargesRate:"+ double.parse(chargesObj.chargesRate).toStringAsFixed(2),
      'chargesQuantity:'+double.parse(chargesObj.chargesQuantity).toStringAsFixed(2),
      'discountQuantity:'+double.parse(chargesObj.discountQuantity).toStringAsFixed(2),
      'discountRate:'+double.parse(chargesObj.discountRate).toStringAsFixed(2),
      'towedVehicle:'+chargesObj.towedVehicle.toString(),
      'discountApply:'+chargesObj.discountApply.toString(),
      'totalCharges:'+chargesObj.totalCharges.toString(),
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
        "<timeZoneName>${timeZoneName}</timeZoneName>"
        "</create>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        api.baseURL+'towedVehicleChargesTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/create",
          "Host": api.host
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["createResponse"]["createResult"];

    createResponse = Map.from(extractedData);
  }

  Future<void> update(chargesObj) async {
    List<String> fieldList;
    String xmlValues="";

   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('timeZoneName', (token) {
      timeZoneName=token;
    });
    await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    fieldList = [
      "pinNumber:"+pinNumber,
      "towCharges:"+chargesObj.towCharges.toString(),
      "chargesRate:"+ double.parse(chargesObj.chargesRate).toStringAsFixed(2),
      'chargesQuantity:'+double.parse(chargesObj.chargesQuantity).toStringAsFixed(2),
      'discountQuantity:'+ double.parse(chargesObj.discountQuantity).toStringAsFixed(2),
      'discountRate:'+double.parse(chargesObj.discountRate).toStringAsFixed(2),
      'towedVehicle:'+chargesObj.towedVehicle.toString(),
      'discountApply:'+chargesObj.discountApply.toString(),
      'totalCharges:'+chargesObj.totalCharges.toString(),
    ];
    xmlValues = fieldList.map((v) => '<string>$v</string>').join();
    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<update xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<id>${chargesObj.id}</id>"
        "<fieldList>${xmlValues}</fieldList>"
        "<timeZoneName>${timeZoneName}</timeZoneName>"
        "</update>"
        "</soap:Body>"
        "</soap:Envelope>";



    final response = await http.post(
        api.baseURL+'towedVehicleChargesTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/update",
          "Host": api.host
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["updateResponse"]["updateResult"];

    chargesUpdateResponse = Map.from(extractedData);
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
        api.baseURL+'towedVehicleChargesTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/delete",
          "Host": api.host
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["deleteResponse"]["deleteResult"];
   chargesDeleteResponse = Map.from(extractedData);
  }
  Future<List> listMini(int pageIndex, int pageSize,String _towedVehicle) async {
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
        api.baseURL+'towedVehicleChargesTable.asmx',
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
    ["listMiniResponse"]["listMiniResult"]["items"]
    ["towedVehicleChargesSummarys"];

    int count = (int.parse(data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"]));

    getTowedVehicleCharges(extractedData, count, iStart);
    // print(extractedData);
    return towedVehicleCharges;
  }

  getTowedVehicleCharges(extractedData, count, iStart) {
    final List<TowedVehicleCharge> towedVehicleCharges = [];

    if (count == 1 || iStart == count) {
      towedVehicleCharges.add(new TowedVehicleCharge.fromJson(extractedData));
    }

    else if(count > 1){
      for (var i = 0; i < extractedData.length; i++) {
        towedVehicleCharges.add(new TowedVehicleCharge.fromJson(extractedData[i]));
      }
    }
      _towedVehicleCharges = towedVehicleCharges;
      notifyListeners();
  }
}
