import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import '../providers/secureStoreMixin_provider.dart';


class TowCustomer {
  String errorStatus;
  String errorMessage;
  int id;
  String pinNumber;
  int towCustomer;
  String towCustomerName;
  int towBillTo=0;
  String towBillToName;
  int towAuthorization;
  String towAuthorizationName;
  int storageCompany;
  String storageCompanyName;
  int towType;
  String towTypeName;
  int towReason;
  String towReasonName;
  int towJurisdiction;
  String towJurisdictionName;
  int storageMunicipal;
  String storageMunicipalName;
  int vehicleMake;
  String vehicleMakeName;
  int vehicleYearMakeModel;
  String vehicleYearMakeModelName;
  String vehicleYear;
  int vehicleColor;
  String vehicleColorName;
  String discountPercent;
  String discountRate;
  bool defaultVIN = false;
  bool invoiceRequired= false;
  bool PORequired = false;
  bool billingRequired = false;
  bool discountRequired = false;
  bool defaultPlate = false;
  bool defaultFromAddress = false;
  bool defaultToAddress = false;
  String QBReference;
  String instructions;
  String instructions_string;
  String contact;
  String email;
  String businessStreet;
  String businessStreetTwo;
  int businessCity;
  int businessState;
  String businessCityName;
  String businessStateName;
  String businessZipCode;
  String businessMainPhone;
  String businessCityStateZipName;
  String towedToStreet;
  String towedToStreetTwo;
  int towedToCity;
  int towedToState;
  String towedToCityName;
  String towedToStateName;
  String towedToZipCode;
  String billingMainPhone;
  String name; //used in listmini for searching

  TowCustomer({
    this.errorStatus,
    this.errorMessage,
    this.id,
    this.pinNumber,
    this.towCustomer,
    this.towCustomerName,
    this.towBillTo,
    this.towBillToName,
    this.towAuthorization,
    this.towAuthorizationName,
    this.storageCompany,
    this.storageCompanyName,
    this.towType,
    this.towTypeName,
    this.towReason,
    this.towReasonName,
    this.towJurisdiction,
    this.towJurisdictionName,
    this.storageMunicipal,
    this.storageMunicipalName,
    this.vehicleMake,
    this.vehicleMakeName,
    this.vehicleYearMakeModel,
    this.vehicleYearMakeModelName,
    this.vehicleYear,
    this.vehicleColor,
    this.vehicleColorName,
    this.discountPercent,
    this.discountRate,
    this.defaultVIN,
    this.invoiceRequired,
    this.PORequired,
    this.billingRequired,
    this.discountRequired,
    this.defaultPlate,
    this.defaultFromAddress,
    this.defaultToAddress,
    this.QBReference,
    this.instructions,
    this.instructions_string,
    this.contact,
    this.email,
    this.businessStreet,
    this.businessStreetTwo,
    this.businessCity,
    this.businessState,
    this.businessCityName,
    this.businessStateName,
    this.businessZipCode,
    this.businessMainPhone,
    this.businessCityStateZipName,
    this.towedToStreet,
    this.towedToStreetTwo,
    this.towedToCity,
    this.towedToState,
    this.towedToCityName,
    this.towedToStateName,
    this.towedToZipCode,
    this.billingMainPhone,
  });

  factory TowCustomer.fromJson(Map<String, dynamic> json) =>
      _towCustomerFromJson(json);
}

TowCustomer _towCustomerFromJson(Map<String, dynamic> parsedJson) {
    return TowCustomer(
      errorStatus: parsedJson['errorStatus'],
      errorMessage: parsedJson['errorStatus'] as String,
      id: (parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
      pinNumber: parsedJson['pinNumber'] as String,
      towCustomer:(parsedJson['towCustomer'] != null ? int.parse(parsedJson['towCustomer']): 0),
      towCustomerName: parsedJson['towCustomerName'] as String,
      towBillTo: (parsedJson['towBillTo'] != null ? int.parse(parsedJson['towBillTo']): 0),
      towBillToName: parsedJson['towBillToName'] as String,
      towAuthorization: (parsedJson['towAuthorization'] != null ? int.parse(parsedJson['towAuthorization']): 0),
      towAuthorizationName: parsedJson['towAuthorizationName'] as String,
      storageCompany: (parsedJson['storageCompany'] != null ? int.parse(parsedJson['storageCompany']): 0),
      storageCompanyName: parsedJson['storageCompanyName'] as String,
      towType: (parsedJson['towType'] != null ? int.parse(parsedJson['towType']): 0),
      towTypeName: parsedJson['towTypeName'] as String,
      towReason: (parsedJson['towReason'] != null ? int.parse(parsedJson['towReason']): 0),
      towReasonName: parsedJson['towReasonName'] as String,
      towJurisdiction: (parsedJson['towJurisdiction'] != null ? int.parse(parsedJson['towJurisdiction']): 0),
      towJurisdictionName: parsedJson['towJurisdictionName'] as String,
      storageMunicipal: (parsedJson['storageMunicipal'] != null ? int.parse(parsedJson['storageMunicipal']): 0),
      storageMunicipalName: parsedJson['storageMunicipalName'] as String,
      vehicleMake:(parsedJson['vehicleMake'] != null ? int.parse(parsedJson['vehicleMake']): 0),
      vehicleMakeName: parsedJson['vehicleMakeName'] as String,
      vehicleYearMakeModel: (parsedJson['vehicleYearMakeModel'] != null ? int.parse(parsedJson['vehicleYearMakeModel']): 0),
      vehicleYearMakeModelName: parsedJson['vehicleYearMakeModelName'] as String,
      vehicleYear: parsedJson['vehicleYear'] as String,
      vehicleColor: (parsedJson['vehicleColor'] != null ? int.parse(parsedJson['vehicleColor']): 0),
      vehicleColorName: parsedJson['vehicleColorName'] as String,
      discountPercent: parsedJson['discountPercent'] as String,
      discountRate: parsedJson['discountRate'] as String,
      defaultVIN: _convertTobool(parsedJson['defaultVIN']),
      invoiceRequired:  _convertTobool(parsedJson['invoiceRequired']),
      PORequired:  _convertTobool(parsedJson['PORequired']),
      billingRequired:  _convertTobool(parsedJson['billingRequired']),
      discountRequired:  _convertTobool(parsedJson['discountRequired']),
      defaultPlate: _convertTobool(parsedJson['defaultPlate']),
      defaultFromAddress: _convertTobool(parsedJson['defaultFromAddress']),
      defaultToAddress:  _convertTobool(parsedJson['defaultToAddress']),
      QBReference: parsedJson['QBReference'] as String,
      instructions: parsedJson['instructions'] as String,
      instructions_string: parsedJson['instructions_string'] as String,
      contact: parsedJson['contact'] as String,
      email: parsedJson['email'] as String,
      businessStreet: parsedJson['businessStreet'] as String,
      businessStreetTwo: parsedJson['businessStreetTwo'] as String,
      businessCity: (parsedJson['businessCity'] != null ? int.parse(parsedJson['businessCity']): 0),
      businessState: (parsedJson['businessState'] != null ? int.parse(parsedJson['businessState']): 0),
      businessCityName: parsedJson['businessCityName'] as String,
      businessStateName: parsedJson['businessStateName'] as String,
      businessZipCode: parsedJson['businessZipCode'] as String,
      businessMainPhone: parsedJson['businessMainPhone'] as String,
      businessCityStateZipName: parsedJson['businessCityStateZipName'] as String,
      towedToStreet: parsedJson['towedToStreet'] as String,
      towedToStreetTwo: parsedJson['towedToStreetTwo'] as String,
      towedToCity: (parsedJson['towedToCity'] != null ? int.parse(parsedJson['towedToCity']): 0),
      towedToState: (parsedJson['towedToState'] != null ? int.parse(parsedJson['towedToState']): 0),
      towedToCityName: parsedJson['towedToCityName'] as String,
      towedToStateName: parsedJson['towedToStateName'] as String,
      towedToZipCode: parsedJson['towedToZipCode'] as String,
      billingMainPhone: parsedJson['billingMainPhone'] as String,
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

class TowCustomersVM with ChangeNotifier, SecureStoreMixin {
  List<TowCustomer> _towCustomers = [];
  List<TowCustomer> _defaultsData = [];
  List<TowCustomer> get towC {
    return [..._towCustomers]; //gets a copy of the items
  }

  List<TowCustomer> get defaultsData {
    return [..._defaultsData]; //gets a copy of the items
  }

  List<TowCustomer> tc;
  Future getDefaults(int a) async{
    Xml2Json xml2json = new Xml2Json();

    final String appName = "towing";
    final int userId = 3556;
    final int towCustomer = a;
    String pinNumber="";
    await getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<getDefaults xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<towCustomer>${towCustomer}</towCustomer>"
        "<pinNumber>${pinNumber}</pinNumber>"
        "</getDefaults >"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://cktsystems.com/vtscloud/WebServices/relationTowCustomerTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/getDefaults",
          "Host": "cktsystems.com"
          //"Accept": "text/xml"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    //final data = json.decode(jsondata);
    final data = JsonDecoder().convert(jsondata);
    print(data);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["getDefaultsResponse"]["getDefaultsResult"];

    final List<TowCustomer> dd = [];
    dd.add(new TowCustomer.fromJson(extractedData));
    _defaultsData=dd;
  }


  Future list() async {
    Xml2Json xml2json = new Xml2Json();
    tc = new List<TowCustomer>();

    final String appName = "towing";
    final int userId = 3556;
    String filterFields = "";
    String pinNumber="";
    await getSecureStore('pinNumber', (token) {
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
        'http://cktsystems.com/vtscloud/WebServices/relationTowCustomerTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/list",
          "Host": "cktsystems.com"
          //"Accept": "text/xml"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
        ["listResponse"]["listResult"]["relationTowCustomerSummarys"];

    for (int i = 0; i < extractedData.length; i++) {
      tc.add(new TowCustomer.fromJson(extractedData[i]));
    }
    _towCustomers = tc;

  }
}
