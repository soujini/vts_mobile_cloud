import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

import '../models/call.dart';
import '../providers/secureStoreMixin_provider.dart';
import 'user_provider.dart';

class ProcessTowedVehicle {
  bool errorStatus;
  String errorMessage;
  String pinNumber;
  String storageCompanyName;
  String towedStatusName;
  String payStatusName;
  String storageStatusName;
  String dispatchStatusName;
  String dispatchDate;
  String dispatchReceivedTime;
  String towedDate;
  String towedTime;
  String storageReceivedDate;
  String storageReceivedTime;
  String storageReleaseDate;
  String storageReleaseTime;
  String VIN;
  bool VINDuplicate;
  String vehicleColorName;
  String searchYearMakeModelName;
  int vehicleYearMakeModel;
  bool yearMakeModelDuplicate;
  String licensePlate;
  String vehicleLicenseStateName;
  int wreckerCompany;
  String wreckerCompanyName;
  String towedInvoice;
  bool towedInvoiceDuplicate;
  String stockNumber;
  int id;

  ProcessTowedVehicle({
    this.errorStatus,
    this.errorMessage,
    this.pinNumber,
    this.storageCompanyName,
    this.towedStatusName,
    this.payStatusName,
    this.storageStatusName,
    this.dispatchStatusName,
    this.dispatchDate,
    this.dispatchReceivedTime,
    this.towedDate,
    this.towedTime,
    this.storageReceivedDate,
    this.storageReceivedTime,
    this.storageReleaseDate,
    this.storageReleaseTime,
    this.VIN,
    this.VINDuplicate,
    this.vehicleColorName,
    this.searchYearMakeModelName,
    this.vehicleYearMakeModel,
    this.yearMakeModelDuplicate,
    this.licensePlate,
    this.vehicleLicenseStateName,
    this.wreckerCompany,
    this.wreckerCompanyName,
    this.towedInvoice,
    this.towedInvoiceDuplicate,
    this.stockNumber,
    this.id
  });

  factory ProcessTowedVehicle.fromJson(Map<String, dynamic> parsedJson) {
    return ProcessTowedVehicle(
      errorStatus : _convertTobool(parsedJson['errorStatus']),
      errorMessage : parsedJson['errorMessage'] as String,
      pinNumber : parsedJson['pinNumber'] as String,
      storageCompanyName : parsedJson['storageCompanyName'] as String,
      towedStatusName : parsedJson['towedStatusName'] as String,
      payStatusName : parsedJson['payStatusName'] as String,
      storageStatusName : parsedJson['storageStatusName'] as String,
      dispatchStatusName : parsedJson['dispatchStatusName'] as String,
      dispatchDate : parsedJson['dispatchDate'] as String,
      dispatchReceivedTime : parsedJson['dispatchReceivedTime'] as String,
      towedDate : parsedJson['towedDate'] as String,
      towedTime : parsedJson['towedTime'] as String,
      storageReceivedDate : parsedJson['storageReceivedDate'] as String,
      storageReceivedTime : parsedJson['storageReceivedTime'] as String,
      storageReleaseDate : parsedJson['storageReleaseDate'] as String,
      storageReleaseTime : parsedJson['storageReleaseTime'] as String,
      VIN : parsedJson['VIN'] as String,
      VINDuplicate : _convertTobool(parsedJson['VINDuplicate']),
      vehicleColorName : parsedJson['vehicleColorName'] as String,
      searchYearMakeModelName : parsedJson['searchYearMakeModelName'] as String,
      vehicleYearMakeModel :(parsedJson['vehicleYearMakeModel'] != null ? int.parse(parsedJson['vehicleYearMakeModel']): 0),
      yearMakeModelDuplicate :_convertTobool(parsedJson['yearMakeModelDuplicate']),
      licensePlate : parsedJson['licensePlate'] as String,
      vehicleLicenseStateName : parsedJson['vehicleLicenseStateName'] as String,
      wreckerCompany : (parsedJson['wreckerCompany'] != null ? int.parse(parsedJson['wreckerCompany']): 0),
      wreckerCompanyName : parsedJson['wreckerCompanyName'] as String,
      towedInvoice : parsedJson['towedInvoice'] as String,
      towedInvoiceDuplicate : _convertTobool(parsedJson['towedInvoiceDuplicate']),
      stockNumber : parsedJson['stockNumber'] as String,
      id : (parsedJson['id'] != null ? int.parse(parsedJson['id']): 0)
    );
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

class ProcessTowedVehiclesVM with ChangeNotifier, SecureStoreMixin {
var duplicateData;

  Future checkForDuplicateTickets(Call _call) async {
    Xml2Json xml2json = new Xml2Json();
    //final userData = UsersVM.getUserDa


    final String appName = "towing";
    final int userId = 200;
    String pinNumber="";
    await getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });
    //final towedInvoice = _call.towedInvoice;
    final towedInvoice = 780679;
    final int wreckerCompany =_call.wreckerCompany;
    final VIN =_call.VIN;
   // final int vehicleYearMakeModel =_call.vehicleYearMakeModel;
    final int vehicleYearMakeModel =63922;

    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<checkForDuplicateTickets xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<pinNumber>${pinNumber}</pinNumber>"
        "<towedInvoice>${towedInvoice}</towedInvoice>"
        "<wreckerCompany>${wreckerCompany}</wreckerCompany>"
        "<VIN>${VIN}</VIN>"
        "</checkForDuplicateTickets>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://cktsystems.com/vtscloud/WebServices/processTowedVehicle.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/checkForDuplicateTickets",
          "Host": "cktsystems.com"
          //"Accept": "text/xml"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["checkForDuplicateTicketsResponse"]["checkForDuplicateTicketsResult"];

    duplicateData = Map.from(extractedData);


//    tc[0].errorMessage = extractedData.errorMessage;
//    tc.add(
//      new ProcessTowedVehicle(
////       errorStatus:  extractedData["errorStatus"],
//        errorMessage:  extractedData["errorMessage"].toString(),
//      )
//    );
//    for (int i = 0; i < extractedData.length; i++) {
//      tc.add(new ProcessTowedVehicle.fromJson(extractedData[0]));
//    }

//    payStatusName : parsedJson['payStatusName'] as String,
//    storageStatusName : parsedJson['storageStatusName'] as String,
//    dispatchStatusName : parsedJson['dispatchStatusName'] as String,
//    dispatchDate : parsedJson['dispatchDate'] as String,
//    dispatchReceivedTime : parsedJson['dispatchReceivedTime'] as String,


  //  tc.errorStatus = _convertTobool(extractedData["errorStatus"]);
//    tc.add(ProcessTowedVehicle( errorMessage : extractedData['errorMessage'] as String));
//    tc.add(ProcessTowedVehicle( pinNumber : extractedData['pinNumber'] as String));
//    tc.add(ProcessTowedVehicle( storageCompanyName : extractedData['storageCompanyName'] as String));
//    tc.add(ProcessTowedVehicle( towedStatusName : extractedData['towedStatusName'] as String));
//    tc.add(ProcessTowedVehicle( payStatusName: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( storageStatusName: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( dispatchStatusName: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( dispatchDate: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( dispatchReceivedTime: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( towedDate: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( towedTime: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//
//    tc.add(ProcessTowedVehicle( storageReceivedDate: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( storageReceivedTime: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( storageReleaseDate: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( storageReleaseTime: (extractedData["errorStatus"] != 0 ? extractedData["storageCompanyName"] : 0)));
//    tc.add(ProcessTowedVehicle( VIN: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( VINDuplicate: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( vehicleColorName: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( searchYearMakeModelName: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( vehicleYearMakeModel: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( yearMakeModelDuplicate: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( licensePlate: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( vehicleLicenseStateName: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//
//    tc.add(ProcessTowedVehicle( wreckerCompany: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( wreckerCompanyName: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( towedInvoice: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( towedInvoiceDuplicate: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( stockNumber: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
//    tc.add(ProcessTowedVehicle( id: (extractedData["errorStatus"] != 0 ? extractedData["errorStatus"] : 0)));
  }
}


