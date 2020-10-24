import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../models/call.dart';
import '../models/call_add.dart';
import '../providers/secureStoreMixin_provider.dart';
import '../providers/common_provider.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class Calls with ChangeNotifier, SecureStoreMixin {
  Xml2Json xml2json = new Xml2Json();
  final String appName = "towing";
  String userId="";
  String pinNumber="";
  String timeZoneName="";
  String restrictWreckerDriver;

  int _activeCount = 0;
  int _completedCount = 0;
  int _cancelledCount = 0;
  int _searchedCount = 0;

  var selectedCall = new Call();
  int id;
  List<Call> _activeCalls = [];
  List<Call> _completedCalls = [];
  List<Call> _cancelledCalls = [];
  List<Call> _searchedCalls = [];
  List<Call> _callDetails =[];
  var createResponse;
  var updateResponse;

  final dateAndTime = DateAndTime();

  get activeCount {
    return _activeCount; //gets a copy of the items
  }

  get completedCount {
    return _completedCount; //gets a copy of the items
  }

  get cancelledCount {
    return _cancelledCount; //gets a copy of the items
  }

  List<Call> get callDetails{
    return _callDetails;
  }

  List<Call> get activeCalls {
    //getter
    return [..._activeCalls]; //gets a copy of the items
  }

  List<Call> get completedCalls {
    return [..._completedCalls]; //gets a copy of the items
  }

  List<Call> get cancelledCalls {
    return [..._cancelledCalls]; //gets a copy of the items
  }
  List<Call> get searchedCalls {
    return [..._searchedCalls]; //gets a copy of the items
  }
  Future<List> updateCall(_call) async {
    final int id = _call.id;
    List<String> fieldList = new List<String>();
    List<String> filteredFieldList = new List<String>();
    String tabUpdate = "Mobile Update";
    String fieldName="";
    bool moveStatus=false;
    String dispatchInstructions_string=_call.dispatchInstructions_string;//Need to be updated
    String xmlValues="";
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM-dd-yyyy').format(now);
    String formattedTime = DateFormat('kk.mm').format(now);
    String formattedTime2 = DateFormat('kk^mm').format(now);

    var formatTowedTime = _call.towedTime.split(":");
     String formattedTowedTime = formatTowedTime[0]+'.'+formatTowedTime[1];
      dispatchInstructions_string = dispatchInstructions_string == '--' ? '' : dispatchInstructions_string;
    List<int> dispatchInstructionsBytes = utf8.encode("dispatchInstructions_string");
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
      "towBillTo:"+_call.towBillTo.toString(),
      'towedInvoice:'+_call.towedInvoice.toString(),
      "towedPONumber:"+_call.towedPONumber.toString(),
      "dispatchMemberNumber:"+_call.dispatchMemberNumber.toString(),
      "dispatchLimitAmount:"+_call.dispatchLimitAmount.toString(),
      "dispatchLimitMiles:"+_call.dispatchLimitMiles.toString(),
      "VIN:"+_call.VIN.toString(),
      "vehicleYearMakeModel:"+_call.vehicleYearMakeModel.toString(),
      'vehicleYear:'+_call.vehicleYear.toString(),
      'vehicleMake:'+_call.vehicleMake.toString(),
      "topColor:"+_call.topColor.toString() ,
      "secondColor:"+_call.secondColor.toString(),
      "licensePlate:"+_call.licensePlate.toString(),
      "vehicleLicenseState:"+_call.vehicleLicenseState.toString(),
      "vehicleOdometer:"+_call.vehicleOdometer.toString(),
      "towType:"+_call.towType.toString(),
      "towReason:"+ _call.towReason.toString(),
      'towAuthorization:'+_call.towAuthorization.toString(),
      "towJurisdiction:"+ _call.towJurisdiction.toString(),
      "towedDate:"+_call.towedDate.toString(),
      "towedTime:"+_call.towedTime.toString().replaceAll(':','.'),//not in view
      "dispatchDate:"+_call.dispatchDate.toString(), //not in view
      // "dispatchReceivedTime:"+_call.dispatchReceivedTime.toString().replaceAll(':','.'),//not in view
      "towedStreet:"+_call.towedStreet.toString(),
      "towedStreetTwo:"+_call.towedStreetTwo.toString(),
      "towedCity:"+_call.towedCity.toString(),
      "towedState:"+_call.towedState.toString(),
      // "towedZipCode:"+_call.towedZipCode.toString(), //removed this from view and here
      "towedToStreet:"+_call.towedToStreet.toString(),
      "towedToStreetTwo:"+_call.towedToStreetTwo.toString(),
      "towedToCity:"+_call.towedToCity.toString(),
      "towedToState:"+_call.towedToState.toString(),
      // "towedToZipCode:"+_call.towedToZipCode.toString(),//removed this from view and here
      "wreckerCompany:"+_call.wreckerCompany.toString(),
      "wreckerDriver:"+_call.wreckerDriver.toString(),
      "towTruck:"+_call.towTruck.toString(),
      "towCustomer:"+_call.towCustomer.toString(),
      "dispatchContact:"+_call.dispatchContact.toString(),
      "dispatchContactPhone:"+_call.dispatchContactPhone.toString(),
      "dispatchPriorityLevel:"+_call.dispatchPriorityLevel.toString(),
      // "dispatchETAMaximum:"+_call.dispatchETAMaximum.toString(),
      "towedStatus:"+_call.towedStatus.toString(),
      "pinNumber:"+pinNumber,
      "systemRuntimeType:2",
      "dispatchETAMinutes:" +_call.dispatchETAMinutes.toString(),
      "towedDiscountRate:" + _call.towedDiscountRate, //fails
      "towedDiscountAmount:" + _call.towedDiscountAmount,//fails
      "dispatchReceivedTime:"+_call.dispatchReceivedTime.toString().replaceAll(':','^'),//not in view Mandatory field
      "dispatchDispatchTime:"+_call.dispatchDispatchTime.toString().replaceAll(':','^'),//not in view  Mandatory field
      "dispatchEnrouteTime:"+_call.dispatchEnrouteTime.toString().replaceAll(':','^'),//not in view  Mandatory field
      "dispatchOnsiteTime:"+_call.dispatchOnsiteTime.toString().replaceAll(':','^'),//not in view  Mandatory field
      "dispatchRollingTime:"+_call.dispatchRollingTime.toString().replaceAll(':','^'),//not in view  Mandatory field
      "dispatchArrivedTime:"+_call.dispatchArrivedTime.toString().replaceAll(':','^'),//not in view  Mandatory field
      "dispatchClearedTime:"+_call.dispatchClearedTime.toString().replaceAll(':','^'),//not in view  Mandatory field
//      "dispatchResponseID:"+call.dispatchResponseID.toString(),
//      "dispatchAuthorizationNumber:"+call.dispatchAuthorizationNumber.toString(),
//      "dispatchProviderResponse:"+call.dispatchProviderResponse.toString(),
//      "vehicleStyle:"+call.vehicleStyle.toString(),
      // "dispatchInstructions:" +dispatchInstructionsBytes.toString(),
    ];
    // filteredFieldList = fieldList.where((v) => v.split(':')[1] != "null" && v.split(':')[1] != null).toList();
    print(fieldList);

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
        "<id>${id}</id>"
        "<fieldList>${xmlValues}</fieldList>"
        "<tabUpdate>${tabUpdate}</tabUpdate>"
        "<fieldName>${fieldName}</fieldName>"
        "<moveStatus>${moveStatus}</moveStatus>"
        "<dispatchInstructions_string>${dispatchInstructions_string}</dispatchInstructions_string>"
        "<timeZoneName>${timeZoneName}</timeZoneName>"
        "</update>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'https://cktsystems.com/vtscloud/WebServices/towedvehicletable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/update",
          "Host": "cktsystems.com",
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["updateResponse"]["updateResult"];

    updateResponse = Map.from(extractedData);
  }
  Future<List> create(call) async {
    List<String> fieldList;
    String xmlValues="";
    String dispatchInstructions_string="";

   await  getSecureStore('userId', (token) {
      userId=token;
    });
   await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });
   await  getSecureStore('timeZoneName', (token) {
      timeZoneName=token;
    });

    await dateAndTime.getCurrentDateAndTime();

    var objText = jsonEncode(call);

   Call_Add user = Call_Add.fromJsonForAdd(jsonDecode(objText));

    fieldList = [
      "towCustomer:"+call.towCustomer.toString(),
      "VIN:"+call.VIN.toString(),
      "vehicleYearMakeModel:"+call.vehicleYearMakeModel.toString(),
      'vehicleYear:'+call.vehicleYear.toString(),
      'vehicleMake:'+call.vehicleMake.toString(),
      "vehicleStyle:"+call.vehicleStyle.toString(),
      "topColor:"+call.topColor.toString(),
      "secondColor:"+call.secondColor.toString(),
      "licensePlate:"+call.licensePlate.toString(),
      "vehicleLicenseState:"+call.vehicleLicenseState.toString(),
      "towType:"+call.towType.toString(),
      "towReason:"+call.towReason.toString(),
      'towAuthorization:'+call.towAuthorization.toString(),
      "towJurisdiction:"+call.towJurisdiction.toString(),
      "dispatchDate:"+call.dispatchDate.toString(),
      "dispatchReceivedTime:"+call.dispatchReceivedTime.toString().replaceAll(':','^'),
      "towedDate:"+call.towedDate.toString(),
      "towedTime:"+call.towedTime.toString().replaceAll(':','^'),
      "storageReceivedDate:"+dateAndTime.date.toString(),
      "storageReceivedTime:"+dateAndTime.time.toString().replaceAll(':','^'),
      "towedStreet:"+call.towedStreet.toString(),
      "towedStreetTwo:"+call.towedStreetTwo.toString(),
      "towedCity:"+call.towedCity.toString(),
      "towedState:"+call.towedState.toString(),
      "towedZipCode:"+call.towedZipCode.toString(),
      "towedToStreet:"+call.towedToStreet.toString(),
      "towedToCity:"+call.towedToCity.toString(),
      "towedToState:"+call.towedToState.toString(),
      "towedToZipCode:"+call.towedToZipCode.toString(),
      "wreckerCompany:"+call.wreckerCompany.toString(),
      "towedStatus:C",
      "wreckerDriver:"+call.wreckerDriver.toString(),
      "towTruck:"+call.towTruck.toString(),
      "towBillTo:"+call.towBillTo.toString(),
      'towedInvoice:'+call.towedInvoice.toString(),//newTowedInvoice =>Check
      // "towedPONumber:"+call.towedPONumber.toString(),
      "pinNumber:"+pinNumber,
      "systemRuntimeType:2",
      "dispatchPriorityLevel:1", // not in view
      "vehicleLicenseType:1" //not in view
    ];
    print(fieldList);
    xmlValues = fieldList.map((v) => '<string>$v</string>').join();
    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<create  xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<fieldList>${xmlValues}</fieldList>"
        "<dispatchInstructions_string>${dispatchInstructions_string}</dispatchInstructions_string>"
        "<timeZoneName>${timeZoneName}</timeZoneName>"
        "</create>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'https://cktsystems.com/vtscloud/WebServices/towedvehicletable.asmx',
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

    createResponse = Map.from(extractedData);
  }
  Future<String> update(var selectedCall, String field_name, String mode, bool moveStatus) async {
    final int id = selectedCall.id;
    List<String> fieldList = new List<String>();
    String tabUpdate = "Mobile Update";
    String fieldName=field_name;
    bool moveStatus=false;
    String dispatchInstructions_string=selectedCall.dispatchInstructions_string;//Need to be updated
    String xmlValues="";
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM-dd-yyyy').format(now);
    String formattedTime = DateFormat('kk.mm').format(now);
    String formattedTime2 = DateFormat('kk^mm').format(now);

    await  getSecureStore('userId', (token) {
      userId=token;
    });
    await  getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });
    await  getSecureStore('timeZoneName', (token) {
      timeZoneName=token;
    });
    bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //var geoLocator = GeoLocator();
     //geoLocator.getCurrentPosition();
     var latitude = position.latitude;
     var longitude = position.longitude;

    if(fieldName == "Dispatch")
    {
      fieldList = [
        "pinNumber:"+pinNumber,
        "dispatchDate:"+formattedDate,
        "dispatchDispatchTime:"+formattedTime2,
        "towedStatus:C",
        "lastLatitude:"+latitude.toString(),
        "lastLongitude:"+longitude.toString(),
        "dispatchReceivedTime:"+selectedCall.dispatchReceivedTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchEnrouteTime:00^00",
        // +selectedCall.dispatchEnrouteTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchOnsiteTime:00^00",
        "dispatchRollingTime:00^00",
        "dispatchArrivedTime:00^00",
        "dispatchClearedTime:00^00"
      ];
      fieldName = "Dispatch - "+formattedTime2;
      xmlValues = fieldList.map((v) => '<string>$v</string>').join();
    }
    if(fieldName == "Enroute")
    {
      fieldList = [
        "pinNumber:"+pinNumber,
        "dispatchEnrouteTime:"+formattedTime2,
        "towedStatus:C",
        "lastLatitude:"+latitude.toString(),
        "lastLongitude:"+longitude.toString(),
        "dispatchReceivedTime:"+selectedCall.dispatchReceivedTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchDispatchTime:"+selectedCall.dispatchDispatchTime.toString().replaceAll(':','^'),//not in view Mandatory field

        "dispatchOnsiteTime:00^00",
        "dispatchRollingTime:00^00",
        "dispatchArrivedTime:00^00",
        "dispatchClearedTime:00^00",
      ];
      fieldName = "Enroute - "+formattedTime2;
      xmlValues = fieldList.map((v) => '<string>$v</string>').join();
    }

    else  if(fieldName == "Onsite")
    {
      fieldList = [
        "pinNumber:"+pinNumber,
        "dispatchOnsiteTime:"+formattedTime2,
        "towedStatus:C",
        "lastLatitude:"+latitude.toString(),
        "lastLongitude:"+longitude.toString(),
        "dispatchReceivedTime:"+selectedCall.dispatchReceivedTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchDispatchTime:"+selectedCall.dispatchDispatchTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchEnrouteTime:"+selectedCall.dispatchEnrouteTime.toString().replaceAll(':','^'),//not in view Mandatory field

        "dispatchRollingTime:00^00",
        "dispatchArrivedTime:00^00",
        "dispatchClearedTime:00^00",
      ];
      fieldName = "Onsite - "+formattedTime2;
      xmlValues = fieldList.map((v) => '<string>$v</string>').join();
    }
    else  if(fieldName == "Rolling")
    {
      fieldList = [
        "pinNumber:"+pinNumber,
        "dispatchRollingTime:"+formattedTime2,
        "towedStatus:C",
        "lastLatitude:"+latitude.toString(),
        "lastLongitude:"+longitude.toString(),
        "dispatchReceivedTime:"+selectedCall.dispatchReceivedTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchDispatchTime:"+selectedCall.dispatchDispatchTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchEnrouteTime:"+selectedCall.dispatchEnrouteTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchOnsiteTime:"+selectedCall.dispatchOnsiteTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchArrivedTime:00^00",
        "dispatchClearedTime:00^00",
      ];
      fieldName = "Rolling - "+formattedTime2;
      xmlValues = fieldList.map((v) => '<string>$v</string>').join();
    }
    else  if(fieldName == "Arrived")
    {
      fieldList = [
        "pinNumber:"+pinNumber,
        "dispatchArrivedTime:"+formattedTime2,
        "towedStatus:C",
        "lastLatitude:"+latitude.toString(),
        "lastLongitude:"+longitude.toString(),
        "dispatchReceivedTime:"+selectedCall.dispatchReceivedTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchDispatchTime:"+selectedCall.dispatchDispatchTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchEnrouteTime:"+selectedCall.dispatchEnrouteTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchOnsiteTime:"+selectedCall.dispatchOnsiteTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchRollingTime:"+selectedCall.dispatchRollingTime.toString().replaceAll(':','^'),//not in view Mandatory field
        "dispatchClearedTime:00^00",

      ];
      fieldName = "Arrived - "+formattedTime2;
      xmlValues = fieldList.map((v) => '<string>$v</string>').join();
    }
    else if(fieldName == "Cleared")
    {
      var towedStatus;
      if(mode == "tow"){
        towedStatus='T';
        moveStatus=true;
      }
      else if(mode == "impound"){
        towedStatus='I';
        moveStatus=true;
      }
      fieldList = [
        "pinNumber:"+pinNumber,
        "towedStatus:"+towedStatus,
        "dispatchProviderResponse:",
        "dispatchProviderSelectedResponse:0",
        "towType:"+selectedCall.towType.toString(),
        "lastLatitude:"+latitude.toString(),
        "lastLongitude:"+longitude.toString(),
    "dispatchReceivedTime:"+selectedCall.dispatchReceivedTime.toString().replaceAll(':','^'),//not in view Mandatory field
    "dispatchDispatchTime:"+selectedCall.dispatchDispatchTime.toString().replaceAll(':','^'),//not in view Mandatory field
    "dispatchEnrouteTime:"+selectedCall.dispatchEnrouteTime.toString().replaceAll(':','^'),//not in view Mandatory field
    "dispatchOnsiteTime:"+selectedCall.dispatchOnsiteTime.toString().replaceAll(':','^'),//not in view Mandatory field
    "dispatchRollingTime:"+selectedCall.dispatchRollingTime.toString().replaceAll(':','^'),//not in view Mandatory field
    "dispatchArrivedTime:"+selectedCall.dispatchArrivedTime.toString().replaceAll(':','^'),//not in view Mandatory field
    // "dispatchClearedTime:"+selectedCall.dispatchClearedTime.toString().replaceAll(':','^'),//not in view Mandatory field
      ];
      fieldName = "Cleared - "+formattedTime2;
      xmlValues = fieldList.map((v) => '<string>$v</string>').join();
    }
    print(fieldList);

    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<update xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<id>${id}</id>"
        "<fieldList>${xmlValues}</fieldList>"
        "<tabUpdate>${tabUpdate}</tabUpdate>"
        "<fieldName>${fieldName}</fieldName>"
        "<moveStatus>${moveStatus}</moveStatus>"
        "<dispatchInstructions_string>${dispatchInstructions_string}</dispatchInstructions_string>"
        "<timeZoneName>${timeZoneName}</timeZoneName>"
        "</update>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'https://cktsystems.com/vtscloud/WebServices/towedvehicletable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/update",
          "Host": "cktsystems.com",
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    return response.body;
  }
  Future<List> get(id) async {
   await  getSecureStore('userId', (token) {
      userId=token;
    });

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
        'https://cktsystems.com/vtscloud/WebServices/towedvehicletable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/get",
          "Host": "cktsystems.com"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);
    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["getResponse"]["getResult"];

    getCallDetails(extractedData);
    return callDetails;
  }
  Future<List> listMiniMobile(String mode, int pageIndex, int pageSize, String _filterFields) async {
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
    String towedStatus;
    bool listAfterInsert = false;
    final bool currentDayList = true;
    bool activeDispatch = true;

    await getSecureStore('userId', (token) {
      userId=token;
    });
    await getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });
    await  getSecureStore('timeZoneName', (token) {
      timeZoneName=token;
    });
    await getSecureStore('restrictWreckerDriver', (token) {
      restrictWreckerDriver=token;
    });


    if (mode == 'active') {
      if(restrictWreckerDriver != '0'){
        filterFields = "pinNumber:"+pinNumber+"|towedStatus:C|wreckerDriver:"+restrictWreckerDriver;
      }
      else{
        filterFields = "pinNumber:"+pinNumber+"|towedStatus:C";
      }
      towedStatus = "C";
      activeDispatch = true;
    } else if (mode == 'completed') {
      if(restrictWreckerDriver != '0'){
        filterFields = "pinNumber:"+pinNumber+"|towedStatus:C|wreckerDriver:"+restrictWreckerDriver;
      }
      else{
        filterFields = "pinNumber:"+pinNumber+"|towedStatus:C";
      }
      towedStatus = "C";
      activeDispatch = false;
    } else if (mode == 'cancelled') {
      if(restrictWreckerDriver != '0') {
        filterFields = "pinNumber:" + pinNumber + "|towedStatus:X|wreckerDriver:"+restrictWreckerDriver;
      }
      else{
        filterFields = "pinNumber:" + pinNumber + "|towedStatus:X";
      }
      towedStatus = "X";
      activeDispatch = true;
    }
      else if (mode == 'search') {
      if(restrictWreckerDriver != '0') {
        filterFields = _filterFields +"|wreckerDriver:"+restrictWreckerDriver;
      }
      else{
        filterFields = _filterFields;
      }
      towedStatus = "C";
      activeDispatch = true;
      listAfterInsert = true;
  }
    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<listMiniMobile xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<filterFields>${filterFields}</filterFields>"
        "<iStart>${iStart}</iStart>"
        "<iEnd>${iEnd}</iEnd>"
        "<towedStatus>${towedStatus}</towedStatus>"
        "<listAfterInsert>${listAfterInsert}</listAfterInsert>"
        "<currentDayList>${currentDayList}</currentDayList>"
        "<timeZoneName>${timeZoneName}</timeZoneName>"
        "<activeDispatch>${activeDispatch}</activeDispatch>"
        "</listMiniMobile>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'https://cktsystems.com/vtscloud/WebServices/towedvehicletable.asmx?op=listMiniMobile',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/listMiniMobile",
          "Host": "cktsystems.com"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    final data = json.decode(jsondata);
    final extractedData = await data["soap:Envelope"]["soap:Body"]
            ["listMiniMobileResponse"]["listMiniMobileResult"]["items"]["towedVehicleSummarys"];

    int count = (int.parse(data["soap:Envelope"]["soap:Body"]
        ["listMiniMobileResponse"]["listMiniMobileResult"]["count"]));

    if (mode == 'active') {
      getActiveCalls(extractedData, count, iStart);
      _activeCount = count;
      notifyListeners();
      return activeCalls;
    }
    else if (mode == 'completed') {
      getCompletedCalls(extractedData, count, iStart);
      _completedCount = count;
     // notifyListeners();
      return completedCalls;
    }
    else if (mode == "cancelled") {
      getCancelledCalls(extractedData,count, iStart);
     _cancelledCount=count;
      // notifyListeners();
      return cancelledCalls;
    }
    else if (mode == "search") {
      getSearchedCalls(extractedData, count, iStart);
      _searchedCount=count;
      return searchedCalls;
    }
  }
  getCallDetails(extractedData){
    final List<Call> callDetails = [];
    callDetails.add(new Call.fromJson(extractedData));
    _callDetails=callDetails;
    //notifyListeners();
  }
  getActiveCalls(_activeCallsFiltered, count, iStart) {
    final List<Call> activeCalls = [];
    if (count == 1 || count == iStart) {
      activeCalls.add(Call(
          count: count,
        id: (_activeCallsFiltered["id"] != "0"
            ? int.parse(_activeCallsFiltered["id"])
            : 0),
        dispatchStatusName:
        _activeCallsFiltered["dispatchStatusName"] != null
            ? _activeCallsFiltered["dispatchStatusName"]
            : '--',
        dispatchInstructions_string:
        _activeCallsFiltered["dispatchInstructions_string"] != null && _activeCallsFiltered["dispatchInstructions_string"] != 'null'
            ? _activeCallsFiltered["dispatchInstructions_string"]
            : '--',
        progressStyleColor:
        getProgressStyleColor(_activeCallsFiltered["dispatchStatus"]),
        progressPercentage: getProgressStylePercentage(
            _activeCallsFiltered["dispatchStatus"]),
        towedTotalAmount: _activeCallsFiltered["towedTotalAmount"] != null
            ? double.parse(_activeCallsFiltered["towedTotalAmount"])
            : double.parse('0.00'),
        towReasonName: _activeCallsFiltered["towReasonName"] != null
            ? _activeCallsFiltered["towReasonName"]
            : '',
        vehicleMakeName:
        _activeCallsFiltered["vehicleMakeName"] != null
            ? _activeCallsFiltered["vehicleMakeName"]
            : '',
        vehicleYearMakeModelName:
        _activeCallsFiltered["vehicleYearMakeModelName"] != null
            ? _activeCallsFiltered["vehicleYearMakeModelName"]
            : '',
        vehicleYear: (_activeCallsFiltered["vehicleYear"] != "0"
            ? int.parse(_activeCallsFiltered["vehicleYear"])
            : 0),
        color: _activeCallsFiltered["topColorName"],
        towedInvoice: _activeCallsFiltered["towedInvoice"] != null
            ? _activeCallsFiltered["towedInvoice"]
            : '',
        towCustomerName: _activeCallsFiltered["towCustomerName"] != null
            ? _activeCallsFiltered["towCustomerName"]
            : '',
        dispatchContact: _activeCallsFiltered["dispatchContact"] != null
            ? (_activeCallsFiltered["dispatchContact"])
            : 'Contact',
        dispatchContactPhone:
        _activeCallsFiltered["dispatchContactPhone"] != null
            ? _activeCallsFiltered["dispatchContactPhone"]
            : '',
        dispatchDate: _activeCallsFiltered["dispatchDate"],
        dispatchDispatchTime: _activeCallsFiltered["dispatchDispatchTime"],
        towedStreet: _activeCallsFiltered["towedStreet"] != null
            ? _activeCallsFiltered["towedStreet"]
            : 'Location',
        towedStreetTwo: _activeCallsFiltered["towedStreetTwo"] != null
            ? _activeCallsFiltered["towedStreetTwo"]
            : '',
        towedCityName: _activeCallsFiltered["towedCityName"] != null
            ? _activeCallsFiltered["towedCityName"]
            : '',
        towedStateName: _activeCallsFiltered["towedStateName"] != null
            ? _activeCallsFiltered["towedStateName"]
            : '',
        towedZipCode: _activeCallsFiltered["towedZipCode"] != null
            ? _activeCallsFiltered["towedZipCode"]
            : '',
        towedToStreet: _activeCallsFiltered["towedToStreet"] != null
            ? _activeCallsFiltered["towedToStreet"]
            : '',
        towedToStreetTwo: _activeCallsFiltered["towedToStreetTwo"] != null
            ? _activeCallsFiltered["towedToStreetTwo"]
            : '',
        towedToCityName: _activeCallsFiltered["towedToCityName"] != null
            ? _activeCallsFiltered["towedToCityName"]
            : '',
        towedToStateName: _activeCallsFiltered["towedToStateName"] != null
            ? _activeCallsFiltered["towedToStateName"]
            : '',
        towedToZipCode: _activeCallsFiltered["towedToZipCode"] != null
            ? _activeCallsFiltered["towedToZipCode"]
            : '',
        licensePlate: _activeCallsFiltered["licensePlate"] != null
            ? _activeCallsFiltered["licensePlate"]
            : '',
        VIN: _activeCallsFiltered["VIN"] != null
            ? _activeCallsFiltered["VIN"]
            : '',
        wreckerDriverName: _activeCallsFiltered["wreckerDriverName"] != null
            ? _activeCallsFiltered["wreckerDriverName"]
            : '',
        towTruckName: _activeCallsFiltered["towTruckName"] != null
            ? _activeCallsFiltered["towTruckName"]
            : '',
        dispatchReceivedTime: _activeCallsFiltered["dispatchReceivedTime"] != null
            ? _activeCallsFiltered["dispatchReceivedTime"]
            : '',
        dispatchEnrouteTime: _activeCallsFiltered["dispatchEnrouteTime"] != null
            ? _activeCallsFiltered["dispatchEnrouteTime"]
            : '',
        dispatchOnsiteTime: _activeCallsFiltered["dispatchOnsiteTime"] != null
            ? _activeCallsFiltered["dispatchOnsiteTime"]
            : '',
        dispatchRollingTime: _activeCallsFiltered["dispatchRollingTime"] != null
            ? _activeCallsFiltered["dispatchRollingTime"]
            : '',
        dispatchClearedTime: _activeCallsFiltered["dispatchClearedTime"] != null
            ? _activeCallsFiltered["dispatchClearedTime"]
            : '',
        dispatchArrivedTime: _activeCallsFiltered["dispatchArrivedTime"] != null
            ? _activeCallsFiltered["dispatchArrivedTime"]
            : '',
      ));
    }
    else if(count > 1){

      for (var i = 0; i < _activeCallsFiltered.length; i++) {
        activeCalls.add(Call(
          count:count,
          id: (_activeCallsFiltered[i]["id"] != "0"
              ? int.parse(_activeCallsFiltered[i]["id"])
              : 0),
          dispatchStatusName:
          _activeCallsFiltered[i]["dispatchStatusName"] != null
              ? _activeCallsFiltered[i]["dispatchStatusName"]
              : '--',
          dispatchInstructions_string:
          _activeCallsFiltered[i]["dispatchInstructions_string"] != null
              ? _activeCallsFiltered[i]["dispatchInstructions_string"]
              : '--',
          progressStyleColor:
          getProgressStyleColor(_activeCallsFiltered[i]["dispatchStatus"]),
          progressPercentage: getProgressStylePercentage(
              _activeCallsFiltered[i]["dispatchStatus"]),
          towedTotalAmount: _activeCallsFiltered[i]["towedTotalAmount"] != null
              ? double.parse(_activeCallsFiltered[i]["towedTotalAmount"])
              : double.parse('0.00'),
          towReasonName: _activeCallsFiltered[i]["towReasonName"] != null
              ? _activeCallsFiltered[i]["towReasonName"]
              : '',
          vehicleMakeName:
          _activeCallsFiltered[i]["vehicleMakeName"] != null
              ? _activeCallsFiltered[i]["vehicleMakeName"]
              : '',
          vehicleYearMakeModelName:
          _activeCallsFiltered[i]["vehicleYearMakeModelName"] != null
              ? _activeCallsFiltered[i]["vehicleYearMakeModelName"]
              : '',
          vehicleYear: (_activeCallsFiltered[i]["vehicleYear"] != "0"
              ? int.parse(_activeCallsFiltered[i]["vehicleYear"])
              : 0),
          color: _activeCallsFiltered[i]["topColorName"],
          towedInvoice: _activeCallsFiltered[i]["towedInvoice"] != null
              ? _activeCallsFiltered[i]["towedInvoice"]
              : '',
          towCustomerName: _activeCallsFiltered[i]["towCustomerName"] != null
              ? _activeCallsFiltered[i]["towCustomerName"]
              : '',
          dispatchContact: _activeCallsFiltered[i]["dispatchContact"] != null
              ? _activeCallsFiltered[i]["dispatchContact"]
              : 'Contact',
          dispatchContactPhone:
          _activeCallsFiltered[i]["dispatchContactPhone"] != null
              ? _activeCallsFiltered[i]["dispatchContactPhone"]
              : '',
          dispatchDate: _activeCallsFiltered[i]["dispatchDate"],
          dispatchDispatchTime: _activeCallsFiltered[i]["dispatchDispatchTime"],
          towedStreet: _activeCallsFiltered[i]["towedStreet"] != null
              ? _activeCallsFiltered[i]["towedStreet"]
              : 'Location',
          towedStreetTwo: _activeCallsFiltered[i]["towedStreetTwo"] != null
              ? _activeCallsFiltered[i]["towedStreetTwo"]
              : '',
          towedCityName: _activeCallsFiltered[i]["towedCityName"] != null
              ? _activeCallsFiltered[i]["towedCityName"]
              : '',
          towedStateName: _activeCallsFiltered[i]["towedStateName"] != null
              ? _activeCallsFiltered[i]["towedStateName"]
              : '',
          towedZipCode: _activeCallsFiltered[i]["towedZipCode"] != null
              ? _activeCallsFiltered[i]["towedZipCode"]
              : '',
          towedToStreet: _activeCallsFiltered[i]["towedToStreet"] != null
              ? _activeCallsFiltered[i]["towedToStreet"]
              : '',
          towedToStreetTwo: _activeCallsFiltered[i]["towedToStreetTwo"] != null
              ? _activeCallsFiltered[i]["towedToStreetTwo"]
              : '',
          towedToCityName: _activeCallsFiltered[i]["towedToCityName"] != null
              ? _activeCallsFiltered[i]["towedToCityName"]
              : '',
          towedToStateName: _activeCallsFiltered[i]["towedToStateName"] != null
              ? _activeCallsFiltered[i]["towedToStateName"]
              : '',
          towedToZipCode: _activeCallsFiltered[i]["towedToZipCode"] != null
              ? _activeCallsFiltered[i]["towedToZipCode"]
              : '',
          licensePlate: _activeCallsFiltered[i]["licensePlate"] != null
              ? _activeCallsFiltered[i]["licensePlate"]
              : ' ',
          VIN: _activeCallsFiltered[i]["VIN"] != null
              ? _activeCallsFiltered[i]["VIN"]
              : '',
          wreckerDriverName: _activeCallsFiltered[i]["wreckerDriverName"] != null
              ? _activeCallsFiltered[i]["wreckerDriverName"]
              : '',
          towTruckName: _activeCallsFiltered[i]["towTruckName"] != null
              ? _activeCallsFiltered[i]["towTruckName"]
              : '',
          dispatchReceivedTime: _activeCallsFiltered[i]["dispatchReceivedTime"] != null
              ? _activeCallsFiltered[i]["dispatchReceivedTime"]
              : '',
          dispatchEnrouteTime: _activeCallsFiltered[i]["dispatchEnrouteTime"] != null
              ? _activeCallsFiltered[i]["dispatchEnrouteTime"]
              : '',
          dispatchOnsiteTime: _activeCallsFiltered[i]["dispatchOnsiteTime"] != null
              ? _activeCallsFiltered[i]["dispatchOnsiteTime"]
              : '',
          dispatchRollingTime: _activeCallsFiltered[i]["dispatchRollingTime"] != null
              ? _activeCallsFiltered[i]["dispatchRollingTime"]
              : '',
          dispatchClearedTime: _activeCallsFiltered[i]["dispatchClearedTime"] != null
              ? _activeCallsFiltered[i]["dispatchClearedTime"]
              : '',
          dispatchArrivedTime: _activeCallsFiltered[i]["dispatchArrivedTime"] != null
              ? _activeCallsFiltered[i]["dispatchArrivedTime"]
              : '',
        ));
      }
    }
      _activeCalls = activeCalls;
//      notifyListeners();
  }
  getCompletedCalls(_completedCallsFiltered, count, iStart) {
    final List<Call> completedCalls = [];
    if (count == 1 || count == iStart) {
      completedCalls.add(Call(
        count:count,
        id: (_completedCallsFiltered["id"] != "0"
            ? int.parse(_completedCallsFiltered["id"])
            : 0),
        dispatchStatusName:
        _completedCallsFiltered["dispatchStatusName"] != null
            ? _completedCallsFiltered["dispatchStatusName"]
            : '--',
        dispatchInstructions_string:
        _completedCallsFiltered["dispatchInstructions_string"] != null
            ? _completedCallsFiltered["dispatchInstructions_string"]
            : '--',
        progressStyleColor:
        getProgressStyleColor(_completedCallsFiltered["dispatchStatus"]),
        progressPercentage: getProgressStylePercentage(
            _completedCallsFiltered["dispatchStatus"]),
        towedTotalAmount: _completedCallsFiltered["towedTotalAmount"] != null
            ? double.parse(_completedCallsFiltered["towedTotalAmount"])
            : double.parse('0.00'),
        towReasonName: _completedCallsFiltered["towReasonName"] != null
            ? _completedCallsFiltered["towReasonName"]
            : '',
        vehicleMakeName:
        _completedCallsFiltered["vehicleMakeName"] != null
            ? _completedCallsFiltered["vehicleMakeName"]
            : '',
        vehicleYearMakeModelName:
        _completedCallsFiltered["vehicleYearMakeModelName"] != null
            ? _completedCallsFiltered["vehicleYearMakeModelName"]
            : '',
        vehicleYear: (_completedCallsFiltered["vehicleYear"] != "0"
            ? int.parse(_completedCallsFiltered["vehicleYear"])
            : 0),
        color: _completedCallsFiltered["topColorName"],
        towedInvoice: _completedCallsFiltered["towedInvoice"] != null
            ? _completedCallsFiltered["towedInvoice"]
            : '',
        towCustomerName: _completedCallsFiltered["towCustomerName"] != null
            ? _completedCallsFiltered["towCustomerName"]
            : '',
        dispatchContact: _completedCallsFiltered["dispatchContact"] != null
            ? (_completedCallsFiltered["dispatchContact"])
            : 'Contact',
        dispatchContactPhone:
        _completedCallsFiltered["dispatchContactPhone"] != null
            ? _completedCallsFiltered["dispatchContactPhone"]
            : '',
        dispatchDate: _completedCallsFiltered["dispatchDate"],
        dispatchDispatchTime: _completedCallsFiltered["dispatchDispatchTime"],
        towedStreet: _completedCallsFiltered["towedStreet"] != null
            ? _completedCallsFiltered["towedStreet"]
            : 'Location',
        towedStreetTwo: _completedCallsFiltered["towedStreetTwo"] != null
            ? _completedCallsFiltered["towedStreetTwo"]
            : '',
        towedCityName: _completedCallsFiltered["towedCityName"] != null
            ? _completedCallsFiltered["towedCityName"]
            : '',
        towedStateName: _completedCallsFiltered["towedStateName"] != null
            ? _completedCallsFiltered["towedStateName"]
            : '',
        towedZipCode: _completedCallsFiltered["towedZipCode"] != null
            ? _completedCallsFiltered["towedZipCode"]
            : '',
        towedToStreet: _completedCallsFiltered["towedToStreet"] != null
            ? _completedCallsFiltered["towedToStreet"]
            : '',
        towedToStreetTwo: _completedCallsFiltered["towedToStreetTwo"] != null
            ? _completedCallsFiltered["towedToStreetTwo"]
            : '',
        towedToCityName: _completedCallsFiltered["towedToCityName"] != null
            ? _completedCallsFiltered["towedToCityName"]
            : '',
        towedToStateName: _completedCallsFiltered["towedToStateName"] != null
            ? _completedCallsFiltered["towedToStateName"]
            : '',
        towedToZipCode: _completedCallsFiltered["towedToZipCode"] != null
            ? _completedCallsFiltered["towedToZipCode"]
            : '',
        licensePlate: _completedCallsFiltered["licensePlate"] != null
            ? _completedCallsFiltered["licensePlate"]
            : '',
        VIN: _completedCallsFiltered["VIN"] != null
            ? _completedCallsFiltered["VIN"]
            : '',
        wreckerDriverName: _completedCallsFiltered["wreckerDriverName"] != null
            ? _completedCallsFiltered["wreckerDriverName"]
            : '',
        towTruckName: _completedCallsFiltered["towTruckName"] != null
            ? _completedCallsFiltered["towTruckName"]
            : '',
        dispatchReceivedTime: _completedCallsFiltered["dispatchReceivedTime"] != null
            ? _completedCallsFiltered["dispatchReceivedTime"]
            : '',
        dispatchEnrouteTime: _completedCallsFiltered["dispatchEnrouteTime"] != null
            ? _completedCallsFiltered["dispatchEnrouteTime"]
            : '',
        dispatchOnsiteTime: _completedCallsFiltered["dispatchOnsiteTime"] != null
            ? _completedCallsFiltered["dispatchOnsiteTime"]
            : '',
        dispatchRollingTime: _completedCallsFiltered["dispatchRollingTime"] != null
            ? _completedCallsFiltered["dispatchRollingTime"]
            : '',
        dispatchClearedTime: _completedCallsFiltered["dispatchClearedTime"] != null
            ? _completedCallsFiltered["dispatchClearedTime"]
            : '',
        dispatchArrivedTime: _completedCallsFiltered["dispatchArrivedTime"] != null
            ? _completedCallsFiltered["dispatchArrivedTime"]
            : '',
      ));
    }
    else if(count > 1) {
      for (var i = 0; i < _completedCallsFiltered.length; i++) {
//      var a = _activeCallsFiltered.id;
        completedCalls.add(Call(
          count:count,
          id: (_completedCallsFiltered[i]["id"] != "0"
              ? int.parse(_completedCallsFiltered[i]["id"])
              : 0),
          dispatchStatusName:
          _completedCallsFiltered[i]["dispatchStatusName"] != null
              ? _completedCallsFiltered[i]["dispatchStatusName"]
              : '--',
          dispatchInstructions_string:
          _completedCallsFiltered[i]["dispatchInstructions_string"] != null
              ? _completedCallsFiltered[i]["dispatchInstructions_string"]
              : '--',
          progressStyleColor:
          getProgressStyleColor(_completedCallsFiltered[i]["dispatchStatus"]),
          progressPercentage: getProgressStylePercentage(
              _completedCallsFiltered[i]["dispatchStatus"]),
          towedTotalAmount: _completedCallsFiltered[i]["towedTotalAmount"] != null
              ? double.parse(_completedCallsFiltered[i]["towedTotalAmount"])
              : double.parse('0.00'),
          towReasonName: _completedCallsFiltered[i]["towReasonName"] != null
              ? _completedCallsFiltered[i]["towReasonName"]
              : '',
          vehicleMakeName:
          _completedCallsFiltered[i]["vehicleMakeName"] != null
              ? _completedCallsFiltered[i]["vehicleMakeName"]
              : '',
          vehicleYearMakeModelName:
          _completedCallsFiltered[i]["vehicleYearMakeModelName"] != null
              ? _completedCallsFiltered[i]["vehicleYearMakeModelName"]
              : '',
          vehicleYear: (_completedCallsFiltered[i]["vehicleYear"] != "0"
              ? int.parse(_completedCallsFiltered[i]["vehicleYear"])
              : 0),
          color: _completedCallsFiltered[i]["topColorName"],
          towedInvoice: _completedCallsFiltered[i]["towedInvoice"] != null
              ? _completedCallsFiltered[i]["towedInvoice"]
              : '',
          towCustomerName: _completedCallsFiltered[i]["towCustomerName"] != null
              ? _completedCallsFiltered[i]["towCustomerName"]
              : '',
          dispatchContact: _completedCallsFiltered[i]["dispatchContact"] != null
              ? _completedCallsFiltered[i]["dispatchContact"]
              : 'Contact',
          dispatchContactPhone:
          _completedCallsFiltered[i]["dispatchContactPhone"] != null
              ? _completedCallsFiltered[i]["dispatchContactPhone"]
              : '',
          dispatchDate: _completedCallsFiltered[i]["dispatchDate"],
          dispatchDispatchTime: _completedCallsFiltered[i]["dispatchDispatchTime"],
          towedStreet: _completedCallsFiltered[i]["towedStreet"] != null
              ? _completedCallsFiltered[i]["towedStreet"]
              : 'Location',
          towedStreetTwo: _completedCallsFiltered[i]["towedStreetTwo"] != null
              ? _completedCallsFiltered[i]["towedStreetTwo"]
              : '',
          towedCityName: _completedCallsFiltered[i]["towedCityName"] != null
              ? _completedCallsFiltered[i]["towedCityName"]
              : '',
          towedStateName: _completedCallsFiltered[i]["towedStateName"] != null
              ? _completedCallsFiltered[i]["towedStateName"]
              : '',
          towedZipCode: _completedCallsFiltered[i]["towedZipCode"] != null
              ? _completedCallsFiltered[i]["towedZipCode"]
              : '',
          towedToStreet: _completedCallsFiltered[i]["towedToStreet"] != null
              ? _completedCallsFiltered[i]["towedToStreet"]
              : '',
          towedToStreetTwo: _completedCallsFiltered[i]["towedToStreetTwo"] != null
              ? _completedCallsFiltered[i]["towedToStreetTwo"]
              : '',
          towedToCityName: _completedCallsFiltered[i]["towedToCityName"] != null
              ? _completedCallsFiltered[i]["towedToCityName"]
              : '',
          towedToStateName: _completedCallsFiltered[i]["towedToStateName"] != null
              ? _completedCallsFiltered[i]["towedToStateName"]
              : '',
          towedToZipCode: _completedCallsFiltered[i]["towedToZipCode"] != null
              ? _completedCallsFiltered[i]["towedToZipCode"]
              : '',
          licensePlate: _completedCallsFiltered[i]["licensePlate"] != null
              ? _completedCallsFiltered[i]["licensePlate"]
              : ' ',
          VIN: _completedCallsFiltered[i]["VIN"] != null
              ? _completedCallsFiltered[i]["VIN"]
              : '',
          wreckerDriverName: _completedCallsFiltered[i]["wreckerDriverName"] != null
              ? _completedCallsFiltered[i]["wreckerDriverName"]
              : '',
          towTruckName: _completedCallsFiltered[i]["towTruckName"] != null
              ? _completedCallsFiltered[i]["towTruckName"]
              : '',
          dispatchReceivedTime: _completedCallsFiltered[i]["dispatchReceivedTime"] != null
              ? _completedCallsFiltered[i]["dispatchReceivedTime"]
              : '',
          dispatchEnrouteTime: _completedCallsFiltered[i]["dispatchEnrouteTime"] != null
              ? _completedCallsFiltered[i]["dispatchEnrouteTime"]
              : '',
          dispatchOnsiteTime: _completedCallsFiltered[i]["dispatchOnsiteTime"] != null
              ? _completedCallsFiltered[i]["dispatchOnsiteTime"]
              : '',
          dispatchRollingTime: _completedCallsFiltered[i]["dispatchRollingTime"] != null
              ? _completedCallsFiltered[i]["dispatchRollingTime"]
              : '',
          dispatchClearedTime: _completedCallsFiltered[i]["dispatchClearedTime"] != null
              ? _completedCallsFiltered[i]["dispatchClearedTime"]
              : '',
          dispatchArrivedTime: _completedCallsFiltered[i]["dispatchArrivedTime"] != null
              ? _completedCallsFiltered[i]["dispatchArrivedTime"]
              : '',
        ));
      }
    }
      _completedCalls = completedCalls;
      notifyListeners();
  }
  getCancelledCalls(_cancelledCallsFiltered, count, iStart) {
    final List<Call> cancelledCalls = [];
    if (count == 1 || count == iStart) {
      cancelledCalls.add(Call(
        count:count,
        id: (_cancelledCallsFiltered["id"] != "0"
            ? int.parse(_cancelledCallsFiltered["id"])
            : 0),
        dispatchStatusName:
        _cancelledCallsFiltered["dispatchStatusName"] != null
            ? _cancelledCallsFiltered["dispatchStatusName"]
            : '--',
        dispatchInstructions_string:
        _cancelledCallsFiltered["dispatchInstructions_string"] != null
            ? _cancelledCallsFiltered["dispatchInstructions_string"]
            : '--',
        progressStyleColor:
        getProgressStyleColor(_cancelledCallsFiltered["dispatchStatus"]),
        progressPercentage: getProgressStylePercentage(
            _cancelledCallsFiltered["dispatchStatus"]),
        towedTotalAmount: _cancelledCallsFiltered["towedTotalAmount"] != null
            ? double.parse(_cancelledCallsFiltered["towedTotalAmount"])
            : double.parse('0.00'),
        towReasonName: _cancelledCallsFiltered["towReasonName"] != null
            ? _cancelledCallsFiltered["towReasonName"]
            : '',
        vehicleMakeName:
        _cancelledCallsFiltered["vehicleMakeName"] != null
            ? _cancelledCallsFiltered["vehicleMakeName"]
            : '',
        vehicleYearMakeModelName:
        _cancelledCallsFiltered["vehicleYearMakeModelName"] != null
            ? _cancelledCallsFiltered["vehicleYearMakeModelName"]
            : '',
        vehicleYear: (_cancelledCallsFiltered["vehicleYear"] != "0"
            ? int.parse(_cancelledCallsFiltered["vehicleYear"])
            : 0),
        color: _cancelledCallsFiltered["topColorName"],
        towedInvoice: _cancelledCallsFiltered["towedInvoice"] != null
            ? _cancelledCallsFiltered["towedInvoice"]
            : '',
        towCustomerName: _cancelledCallsFiltered["towCustomerName"] != null
            ? _cancelledCallsFiltered["towCustomerName"]
            : '',
        dispatchContact: _cancelledCallsFiltered["dispatchContact"] != null
            ? (_cancelledCallsFiltered["dispatchContact"])
            : 'Contact',
        dispatchContactPhone:
        _cancelledCallsFiltered["dispatchContactPhone"] != null
            ? _cancelledCallsFiltered["dispatchContactPhone"]
            : '',
        dispatchDate: _cancelledCallsFiltered["dispatchDate"],
        dispatchDispatchTime: _cancelledCallsFiltered["dispatchDispatchTime"],
        towedStreet: _cancelledCallsFiltered["towedStreet"] != null
            ? _cancelledCallsFiltered["towedStreet"]
            : 'Location',
        towedStreetTwo: _cancelledCallsFiltered["towedStreetTwo"] != null
            ? _cancelledCallsFiltered["towedStreetTwo"]
            : '',
        towedCityName: _cancelledCallsFiltered["towedCityName"] != null
            ? _cancelledCallsFiltered["towedCityName"]
            : '',
        towedStateName: _cancelledCallsFiltered["towedStateName"] != null
            ? _cancelledCallsFiltered["towedStateName"]
            : '',
        towedZipCode: _cancelledCallsFiltered["towedZipCode"] != null
            ? _cancelledCallsFiltered["towedZipCode"]
            : '',
        towedToStreet: _cancelledCallsFiltered["towedToStreet"] != null
            ? _cancelledCallsFiltered["towedToStreet"]
            : '',
        towedToStreetTwo: _cancelledCallsFiltered["towedToStreetTwo"] != null
            ? _cancelledCallsFiltered["towedToStreetTwo"]
            : '',
        towedToCityName: _cancelledCallsFiltered["towedToCityName"] != null
            ? _cancelledCallsFiltered["towedToCityName"]
            : '',
        towedToStateName: _cancelledCallsFiltered["towedToStateName"] != null
            ? _cancelledCallsFiltered["towedToStateName"]
            : '',
        towedToZipCode: _cancelledCallsFiltered["towedToZipCode"] != null
            ? _cancelledCallsFiltered["towedToZipCode"]
            : '',
        licensePlate: _cancelledCallsFiltered["licensePlate"] != null
            ? _cancelledCallsFiltered["licensePlate"]
            : '',
        VIN: _cancelledCallsFiltered["VIN"] != null
            ? _cancelledCallsFiltered["VIN"]
            : '',
        wreckerDriverName: _cancelledCallsFiltered["wreckerDriverName"] != null
            ? _cancelledCallsFiltered["wreckerDriverName"]
            : '',
        towTruckName: _cancelledCallsFiltered["towTruckName"] != null
            ? _cancelledCallsFiltered["towTruckName"]
            : '',
        dispatchReceivedTime: _cancelledCallsFiltered["dispatchReceivedTime"] != null
            ? _cancelledCallsFiltered["dispatchReceivedTime"]
            : '',
        dispatchEnrouteTime: _cancelledCallsFiltered["dispatchEnrouteTime"] != null
            ? _cancelledCallsFiltered["dispatchEnrouteTime"]
            : '',
        dispatchOnsiteTime: _cancelledCallsFiltered["dispatchOnsiteTime"] != null
            ? _cancelledCallsFiltered["dispatchOnsiteTime"]
            : '',
        dispatchRollingTime: _cancelledCallsFiltered["dispatchRollingTime"] != null
            ? _cancelledCallsFiltered["dispatchRollingTime"]
            : '',
        dispatchClearedTime: _cancelledCallsFiltered["dispatchClearedTime"] != null
            ? _cancelledCallsFiltered["dispatchClearedTime"]
            : '',
        dispatchArrivedTime: _cancelledCallsFiltered["dispatchArrivedTime"] != null
            ? _cancelledCallsFiltered["dispatchArrivedTime"]
            : '',
      ));
    }
    else if(count > 1) {
      for (var i = 0; i < _cancelledCallsFiltered.length; i++) {
//      var a = _activeCallsFiltered.id;
        cancelledCalls.add(Call(
          count:count,
          id: (_cancelledCallsFiltered[i]["id"] != "0"
              ? int.parse(_cancelledCallsFiltered[i]["id"])
              : 0),
          dispatchStatusName:
          _cancelledCallsFiltered[i]["dispatchStatusName"] != null
              ? _cancelledCallsFiltered[i]["dispatchStatusName"]
              : '--',
          dispatchInstructions_string:
          _cancelledCallsFiltered[i]["dispatchInstructions_string"] != null
              ? _cancelledCallsFiltered[i]["dispatchInstructions_string"]
              : '--',
          progressStyleColor:
          getProgressStyleColor(_cancelledCallsFiltered[i]["dispatchStatus"]),
          progressPercentage: getProgressStylePercentage(
              _cancelledCallsFiltered[i]["dispatchStatus"]),
          towedTotalAmount: _cancelledCallsFiltered[i]["towedTotalAmount"] != null
              ? double.parse(_cancelledCallsFiltered[i]["towedTotalAmount"])
              : double.parse('0.00'),
          towReasonName: _cancelledCallsFiltered[i]["towReasonName"] != null
              ? _cancelledCallsFiltered[i]["towReasonName"]
              : '',
          vehicleMakeName:
          _cancelledCallsFiltered[i]["vehicleMakeName"] != null
              ? _cancelledCallsFiltered[i]["vehicleMakeName"]
              : '',
          vehicleYearMakeModelName:
          _cancelledCallsFiltered[i]["vehicleYearMakeModelName"] != null
              ? _cancelledCallsFiltered[i]["vehicleYearMakeModelName"]
              : '',
          vehicleYear: (_cancelledCallsFiltered[i]["vehicleYear"] != "0"
              ? int.parse(_cancelledCallsFiltered[i]["vehicleYear"])
              : 0),
          color: _cancelledCallsFiltered[i]["topColorName"],
          towedInvoice: _cancelledCallsFiltered[i]["towedInvoice"] != null
              ? _cancelledCallsFiltered[i]["towedInvoice"]
              : '',
          towCustomerName: _cancelledCallsFiltered[i]["towCustomerName"] != null
              ? _cancelledCallsFiltered[i]["towCustomerName"]
              : '',
          dispatchContact: _cancelledCallsFiltered[i]["dispatchContact"] != null
              ? _cancelledCallsFiltered[i]["dispatchContact"]
              : 'Contact',
          dispatchContactPhone:
          _cancelledCallsFiltered[i]["dispatchContactPhone"] != null
              ? _cancelledCallsFiltered[i]["dispatchContactPhone"]
              : '',
          dispatchDate: _cancelledCallsFiltered[i]["dispatchDate"],
          dispatchDispatchTime: _cancelledCallsFiltered[i]["dispatchDispatchTime"],
          towedStreet: _cancelledCallsFiltered[i]["towedStreet"] != null
              ? _cancelledCallsFiltered[i]["towedStreet"]
              : 'Location',
          towedStreetTwo: _cancelledCallsFiltered[i]["towedStreetTwo"] != null
              ? _cancelledCallsFiltered[i]["towedStreetTwo"]
              : '',
          towedCityName: _cancelledCallsFiltered[i]["towedCityName"] != null
              ? _cancelledCallsFiltered[i]["towedCityName"]
              : '',
          towedStateName: _cancelledCallsFiltered[i]["towedStateName"] != null
              ? _cancelledCallsFiltered[i]["towedStateName"]
              : '',
          towedZipCode: _cancelledCallsFiltered[i]["towedZipCode"] != null
              ? _cancelledCallsFiltered[i]["towedZipCode"]
              : '',
          towedToStreet: _cancelledCallsFiltered[i]["towedToStreet"] != null
              ? _cancelledCallsFiltered[i]["towedToStreet"]
              : '',
          towedToStreetTwo: _cancelledCallsFiltered[i]["towedToStreetTwo"] != null
              ? _cancelledCallsFiltered[i]["towedToStreetTwo"]
              : '',
          towedToCityName: _cancelledCallsFiltered[i]["towedToCityName"] != null
              ? _cancelledCallsFiltered[i]["towedToCityName"]
              : '',
          towedToStateName: _cancelledCallsFiltered[i]["towedToStateName"] != null
              ? _cancelledCallsFiltered[i]["towedToStateName"]
              : '',
          towedToZipCode: _cancelledCallsFiltered[i]["towedToZipCode"] != null
              ? _cancelledCallsFiltered[i]["towedToZipCode"]
              : '',
          licensePlate: _cancelledCallsFiltered[i]["licensePlate"] != null
              ? _cancelledCallsFiltered[i]["licensePlate"]
              : ' ',
          VIN: _cancelledCallsFiltered[i]["VIN"] != null
              ? _cancelledCallsFiltered[i]["VIN"]
              : '',
          wreckerDriverName: _cancelledCallsFiltered[i]["wreckerDriverName"] != null
              ? _cancelledCallsFiltered[i]["wreckerDriverName"]
              : '',
          towTruckName: _cancelledCallsFiltered[i]["towTruckName"] != null
              ? _cancelledCallsFiltered[i]["towTruckName"]
              : '',
          dispatchReceivedTime: _cancelledCallsFiltered[i]["dispatchReceivedTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchReceivedTime"]
              : '',
          dispatchEnrouteTime: _cancelledCallsFiltered[i]["dispatchEnrouteTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchEnrouteTime"]
              : '',
          dispatchOnsiteTime: _cancelledCallsFiltered[i]["dispatchOnsiteTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchOnsiteTime"]
              : '',
          dispatchRollingTime: _cancelledCallsFiltered[i]["dispatchRollingTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchRollingTime"]
              : '',
          dispatchClearedTime: _cancelledCallsFiltered[i]["dispatchClearedTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchClearedTime"]
              : '',
          dispatchArrivedTime: _cancelledCallsFiltered[i]["dispatchArrivedTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchArrivedTime"]
              : '',
        ));
      }
    }
    _cancelledCalls = cancelledCalls;
    notifyListeners();
  }
  getSearchedCalls(_cancelledCallsFiltered, count, iStart) {
    final List<Call> cancelledCalls = [];
    if (count == 1 || count == iStart) {
      cancelledCalls.add(Call(
        count:count,
        id: (_cancelledCallsFiltered["id"] != "0"
            ? int.parse(_cancelledCallsFiltered["id"])
            : 0),
        dispatchStatusName:
        _cancelledCallsFiltered["dispatchStatusName"] != null
            ? _cancelledCallsFiltered["dispatchStatusName"]
            : '--',
        dispatchInstructions_string:
        _cancelledCallsFiltered["dispatchInstructions_string"] != null
            ? _cancelledCallsFiltered["dispatchInstructions_string"]
            : '--',
        progressStyleColor:
        getProgressStyleColor(_cancelledCallsFiltered["dispatchStatus"]),
        progressPercentage: getProgressStylePercentage(
            _cancelledCallsFiltered["dispatchStatus"]),
        towedTotalAmount: _cancelledCallsFiltered["towedTotalAmount"] != null
            ? double.parse(_cancelledCallsFiltered["towedTotalAmount"])
            : double.parse('0.00'),
        towReasonName: _cancelledCallsFiltered["towReasonName"] != null
            ? _cancelledCallsFiltered["towReasonName"]
            : '',
        vehicleMakeName:
        _cancelledCallsFiltered["vehicleMakeName"] != null
            ? _cancelledCallsFiltered["vehicleMakeName"]
            : '',
        vehicleYearMakeModelName:
        _cancelledCallsFiltered["vehicleYearMakeModelName"] != null
            ? _cancelledCallsFiltered["vehicleYearMakeModelName"]
            : '',
        vehicleYear: (_cancelledCallsFiltered["vehicleYear"] != "0"
            ? int.parse(_cancelledCallsFiltered["vehicleYear"])
            : 0),
        color: _cancelledCallsFiltered["topColorName"],
        towedInvoice: _cancelledCallsFiltered["towedInvoice"] != null
            ? _cancelledCallsFiltered["towedInvoice"]
            : '',
        towCustomerName: _cancelledCallsFiltered["towCustomerName"] != null
            ? _cancelledCallsFiltered["towCustomerName"]
            : '',
        dispatchContact: _cancelledCallsFiltered["dispatchContact"] != null
            ? (_cancelledCallsFiltered["dispatchContact"])
            : '',
        dispatchContactPhone:
        _cancelledCallsFiltered["dispatchContactPhone"] != null
            ? _cancelledCallsFiltered["dispatchContactPhone"]
            : '',
        dispatchDate: _cancelledCallsFiltered["dispatchDate"],
        dispatchDispatchTime: _cancelledCallsFiltered["dispatchDispatchTime"],
        towedStreet: _cancelledCallsFiltered["towedStreet"] != null
            ? _cancelledCallsFiltered["towedStreet"]
            : 'Location',
        towedStreetTwo: _cancelledCallsFiltered["towedStreetTwo"] != null
            ? _cancelledCallsFiltered["towedStreetTwo"]
            : '',
        towedCityName: _cancelledCallsFiltered["towedCityName"] != null
            ? _cancelledCallsFiltered["towedCityName"]
            : '',
        towedStateName: _cancelledCallsFiltered["towedStateName"] != null
            ? _cancelledCallsFiltered["towedStateName"]
            : '',
        towedZipCode: _cancelledCallsFiltered["towedZipCode"] != null
            ? _cancelledCallsFiltered["towedZipCode"]
            : '',
        towedToStreet: _cancelledCallsFiltered["towedToStreet"] != null
            ? _cancelledCallsFiltered["towedToStreet"]
            : '',
        towedToStreetTwo: _cancelledCallsFiltered["towedToStreetTwo"] != null
            ? _cancelledCallsFiltered["towedToStreetTwo"]
            : '',
        towedToCityName: _cancelledCallsFiltered["towedToCityName"] != null
            ? _cancelledCallsFiltered["towedToCityName"]
            : '',
        towedToStateName: _cancelledCallsFiltered["towedToStateName"] != null
            ? _cancelledCallsFiltered["towedToStateName"]
            : '',
        towedToZipCode: _cancelledCallsFiltered["towedToZipCode"] != null
            ? _cancelledCallsFiltered["towedToZipCode"]
            : '',
        licensePlate: _cancelledCallsFiltered["licensePlate"] != null
            ? _cancelledCallsFiltered["licensePlate"]
            : '',
        VIN: _cancelledCallsFiltered["VIN"] != null
            ? _cancelledCallsFiltered["VIN"]
            : '',
        wreckerDriverName: _cancelledCallsFiltered["wreckerDriverName"] != null
            ? _cancelledCallsFiltered["wreckerDriverName"]
            : '',
        towTruckName: _cancelledCallsFiltered["towTruckName"] != null
            ? _cancelledCallsFiltered["towTruckName"]
            : '',
        dispatchReceivedTime: _cancelledCallsFiltered["dispatchReceivedTime"] != null
            ? _cancelledCallsFiltered["dispatchReceivedTime"]
            : '',
        dispatchEnrouteTime: _cancelledCallsFiltered["dispatchEnrouteTime"] != null
            ? _cancelledCallsFiltered["dispatchEnrouteTime"]
            : '',
        dispatchOnsiteTime: _cancelledCallsFiltered["dispatchOnsiteTime"] != null
            ? _cancelledCallsFiltered["dispatchOnsiteTime"]
            : '',
        dispatchRollingTime: _cancelledCallsFiltered["dispatchRollingTime"] != null
            ? _cancelledCallsFiltered["dispatchRollingTime"]
            : '',
        dispatchClearedTime: _cancelledCallsFiltered["dispatchClearedTime"] != null
            ? _cancelledCallsFiltered["dispatchClearedTime"]
            : '',
        dispatchArrivedTime: _cancelledCallsFiltered["dispatchArrivedTime"] != null
            ? _cancelledCallsFiltered["dispatchArrivedTime"]
            : '',
      ));
    }
    else if(count > 1){
      for (var i = 0; i < _cancelledCallsFiltered.length; i++) {
        cancelledCalls.add(Call(
          count:count,
          id: (_cancelledCallsFiltered[i]["id"] != "0"
              ? int.parse(_cancelledCallsFiltered[i]["id"])
              : 0),
          dispatchStatusName:
          _cancelledCallsFiltered[i]["dispatchStatusName"] != null
              ? _cancelledCallsFiltered[i]["dispatchStatusName"]
              : '--',
          dispatchInstructions_string:
         _cancelledCallsFiltered[i]["dispatchInstructions_string"] != null
              ? _cancelledCallsFiltered[i]["dispatchInstructions_string"]
              : '--',
          progressStyleColor:
          getProgressStyleColor(_cancelledCallsFiltered[i]["dispatchStatus"]),
          progressPercentage: getProgressStylePercentage(
              _cancelledCallsFiltered[i]["dispatchStatus"]),
          towedTotalAmount: _cancelledCallsFiltered[i]["towedTotalAmount"] != null
              ? double.parse(_cancelledCallsFiltered[i]["towedTotalAmount"])
              : double.parse('0.00'),
          towReasonName: _cancelledCallsFiltered[i]["towReasonName"] != null
              ? _cancelledCallsFiltered[i]["towReasonName"]
              : '',
          vehicleMakeName:
          _cancelledCallsFiltered[i]["vehicleMakeName"] != null
              ? _cancelledCallsFiltered[i]["vehicleMakeName"]
              : '',
          vehicleYearMakeModelName:
          _cancelledCallsFiltered[i]["vehicleYearMakeModelName"] != null
              ? _cancelledCallsFiltered[i]["vehicleYearMakeModelName"]
              : '',
          vehicleYear: (_cancelledCallsFiltered[i]["vehicleYear"] != "0"
              ? int.parse(_cancelledCallsFiltered[i]["vehicleYear"])
              : 0),
          color: _cancelledCallsFiltered[i]["topColorName"],
          towedInvoice: _cancelledCallsFiltered[i]["towedInvoice"] != null
              ? _cancelledCallsFiltered[i]["towedInvoice"]
              : '',
          towCustomerName: _cancelledCallsFiltered[i]["towCustomerName"] != null
              ? _cancelledCallsFiltered[i]["towCustomerName"]
              : '',
          dispatchContact: _cancelledCallsFiltered[i]["dispatchContact"] != null
              ? _cancelledCallsFiltered[i]["dispatchContact"]
              : 'Contact',
          dispatchContactPhone:
          _cancelledCallsFiltered[i]["dispatchContactPhone"] != null
              ? _cancelledCallsFiltered[i]["dispatchContactPhone"]
              : '',
          dispatchDate: _cancelledCallsFiltered[i]["dispatchDate"],
          dispatchDispatchTime: _cancelledCallsFiltered[i]["dispatchDispatchTime"],
          towedStreet: _cancelledCallsFiltered[i]["towedStreet"] != null
              ? _cancelledCallsFiltered[i]["towedStreet"]
              : 'Location',
          towedStreetTwo: _cancelledCallsFiltered[i]["towedStreetTwo"] != null
              ? _cancelledCallsFiltered[i]["towedStreetTwo"]
              : '',
          towedCityName: _cancelledCallsFiltered[i]["towedCityName"] != null
              ? _cancelledCallsFiltered[i]["towedCityName"]
              : '',
          towedStateName: _cancelledCallsFiltered[i]["towedStateName"] != null
              ? _cancelledCallsFiltered[i]["towedStateName"]
              : '',
          towedZipCode: _cancelledCallsFiltered[i]["towedZipCode"] != null
              ? _cancelledCallsFiltered[i]["towedZipCode"]
              : '',
          towedToStreet: _cancelledCallsFiltered[i]["towedToStreet"] != null
              ? _cancelledCallsFiltered[i]["towedToStreet"]
              : '',
          towedToStreetTwo: _cancelledCallsFiltered[i]["towedToStreetTwo"] != null
              ? _cancelledCallsFiltered[i]["towedToStreetTwo"]
              : '',
          towedToCityName: _cancelledCallsFiltered[i]["towedToCityName"] != null
              ? _cancelledCallsFiltered[i]["towedToCityName"]
              : '',
          towedToStateName: _cancelledCallsFiltered[i]["towedToStateName"] != null
              ? _cancelledCallsFiltered[i]["towedToStateName"]
              : '',
          towedToZipCode: _cancelledCallsFiltered[i]["towedToZipCode"] != null
              ? _cancelledCallsFiltered[i]["towedToZipCode"]
              : '',
          licensePlate: _cancelledCallsFiltered[i]["licensePlate"] != null
              ? _cancelledCallsFiltered[i]["licensePlate"]
              : ' ',
          VIN: _cancelledCallsFiltered[i]["VIN"] != null
              ? _cancelledCallsFiltered[i]["VIN"]
              : '',
          wreckerDriverName: _cancelledCallsFiltered[i]["wreckerDriverName"] != null
              ? _cancelledCallsFiltered[i]["wreckerDriverName"]
              : '',
          towTruckName: _cancelledCallsFiltered[i]["towTruckName"] != null
              ? _cancelledCallsFiltered[i]["towTruckName"]
              : '',
          dispatchReceivedTime: _cancelledCallsFiltered[i]["dispatchReceivedTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchReceivedTime"]
              : '',
          dispatchEnrouteTime: _cancelledCallsFiltered[i]["dispatchEnrouteTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchEnrouteTime"]
              : '',
          dispatchOnsiteTime: _cancelledCallsFiltered[i]["dispatchOnsiteTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchOnsiteTime"]
              : '',
          dispatchRollingTime: _cancelledCallsFiltered[i]["dispatchRollingTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchRollingTime"]
              : '',
          dispatchClearedTime: _cancelledCallsFiltered[i]["dispatchClearedTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchClearedTime"]
              : '',
          dispatchArrivedTime: _cancelledCallsFiltered[i]["dispatchArrivedTime"] != null
              ? _cancelledCallsFiltered[i]["dispatchArrivedTime"]
              : '',
        ));
      }
    }
      _searchedCalls = cancelledCalls;
      notifyListeners();
  }
  Color getProgressStyleColor(dispatchStatus) {
    Color color;
    switch (dispatchStatus) {
      case 'R':
        {
          //Received
          color = Colors.red;
        }
        break;

      case 'D':
        {
          //Dispatch
          color = Colors.amber;
        }
        break;
      case 'E':
        {
          //Enroute
          color = Colors.green;
        }
        break;
      case 'O':
        {
          //Onsite
          color = Colors.cyan;
        }
        break;
      case 'G':
        {
          //Rolling
          color = Colors.purpleAccent;
        }
        break;
      case 'A':
        {
          //Arrived
          color = Colors.grey;
        }
        break;
      case 'C':
        {
          //Cleared
          color = Colors.black;
        }
        break;
    }
    return color;
  }
  double getProgressStylePercentage(dispatchStatus) {
    switch (dispatchStatus) {
      case 'R':
        {
          //Received
          return 0.1;
        }
        break;

      case 'D':
        {
          //Dispatch
          return 0.2;
        }
        break;
      case 'E':
        {
          //Enroute
          return 0.4;
        }
        break;
      case 'O':
        {
          //Onsite
          return 0.6;
        }
        break;
      case 'G':
        {
          //Rolling
          return 0.8;
        }
        break;
      case 'A':
        {
          //Arrived
          return 0.9;
        }
        break;
      case 'C':
        {
          //Cleared
          return 1.0;
        }
        break;
    }
  }
}

