import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'calls_provider.dart';
import '../providers/secureStoreMixin_provider.dart';


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
  var selectedCharge = new TowedVehicleCharge();
  List<TowedVehicleCharge> _towedVehicleCharges = [];
  List<TowedVehicleCharge> notes;

  List<TowedVehicleCharge> get towedVehicleCharges {
    return [..._towedVehicleCharges]; //gets a copy of the items
  }

  Future<List> listMini(int pageIndex, int pageSize,
      String _towedVehicle) async {
    Xml2Json xml2json = new Xml2Json();

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
    String pinNumber="";
    await await getSecureStore('pinNumber', (token) {
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
        'https://cktsystems.com/vtscloud/WebServices/towedVehicleChargesTable.asmx',
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
    ["towedVehicleChargesSummarys"];

    int count = (int.parse(data["soap:Envelope"]["soap:Body"]
    ["listMiniResponse"]["listMiniResult"]["count"]));

    getTowedVehicleCharges(extractedData, count);
    return towedVehicleCharges;
  }

  getTowedVehicleCharges(extractedData, count) {
    final List<TowedVehicleCharge> towedVehicleCharges = [];

    if (count == 1) {
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
