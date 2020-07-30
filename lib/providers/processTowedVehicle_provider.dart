import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../models/call.dart';
import '../providers/secureStoreMixin_provider.dart';

class Charge{
  bool errorStatus;
  String errorMessage;
  String chargesQuantity;
  String discountQuantity;
  String chargesRate;

  Charge({
  this.errorStatus,
  this.errorMessage,
  this.chargesQuantity,
    this.discountQuantity,
    this.chargesRate,
  });

  factory Charge.fromJson(Map<String, dynamic> parsedJson) {
    return Charge(
      errorStatus : _convertTobool(parsedJson['errorStatus']),
      errorMessage : parsedJson['errorMessage'] as String,
      chargesQuantity :  parsedJson['chargesQuantity'] as String,
      discountQuantity :  parsedJson['discountQuantity'] as String,
      chargesRate :  parsedJson['chargesRate'] as String
    );
  }
}
class SMS{
  bool errorStatus;
  String errorMessage;
  int id;

  SMS({
    this.errorStatus,
    this.errorMessage,
    this.id,
  });

  factory SMS.fromJson(Map<String, dynamic> parsedJson) {
    return SMS(
        errorStatus : _convertTobool(parsedJson['errorStatus']),
        errorMessage : parsedJson['errorMessage'] as String,
        id : (parsedJson['id'] != null ? int.parse(parsedJson['id']): 0)
    );
  }
}
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
  Xml2Json xml2json = new Xml2Json();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";

  var duplicateData;
  var defaultCharges;
  var smsResult;

  Future processDriverSMSMessage(towedVehicle) async {
   await  getSecureStore('userId', (token) {
      userId=token;
    });

    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<processDriverSMSMessage  xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<towedVehicle>${towedVehicle}</towedVehicle>"
        "</processDriverSMSMessage>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://74.95.253.45/vtscloud/WebServices/processTowedVehicle.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/processDriverSMSMessage",
          "Host": "cktsystems.com"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["processDriverSMSMessageResponse"]["processDriverSMSMessageResult"];

    getSMSResponse(extractedData);
  }
  getSMSResponse(extractedData){
    final List<SMS> smsResponse = [];
    smsResponse.add(new SMS.fromJson(extractedData));
    smsResult=smsResponse;
    //notifyListeners();
  }

  Future checkForDuplicateTickets(Call _call) async {
   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

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
        "<towedInvoice>${_call.towedInvoice}</towedInvoice>"
        "<wreckerCompany>${_call.wreckerCompany}</wreckerCompany>"
        "<VIN>${_call.VIN}</VIN>"
        "</checkForDuplicateTickets>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://74.95.253.45/vtscloud/WebServices/processTowedVehicle.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/checkForDuplicateTickets",
          "Host": "cktsystems.com"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["checkForDuplicateTicketsResponse"]["checkForDuplicateTicketsResult"];

    duplicateData = Map.from(extractedData);
  }

  Future getDefaultCharges(towCharges, towCustomer, towType) async {
   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<getDefaultCharges xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<pinNumber>${pinNumber}</pinNumber>"
        "<towCharges>${towCharges}</towCharges>"
        "<towCustomer>${towCustomer}</towCustomer>"
        "<towType>${towType}</towType>"
        "</getDefaultCharges>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://74.95.253.45/vtscloud/WebServices/processTowedVehicle.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/getDefaultCharges",
          "Host": "cktsystems.com"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["getDefaultChargesResponse"]["getDefaultChargesResult"];

      getDefaultsForCharges(extractedData);
  }
  getDefaultsForCharges(extractedData){
    final List<Charge> towedVehicleNotes = [];
    towedVehicleNotes.add(new Charge.fromJson(extractedData));
    defaultCharges=towedVehicleNotes;
    //notifyListeners();
  }
}


