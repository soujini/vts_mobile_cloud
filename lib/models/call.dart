import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:xml2json/xml2json.dart';
import 'dart:convert';

Test imgFromJson(String str) => Test.fromJson(json.decode(str));
String imgToJson(Test data) => json.encode(data.toJson());

class Test {
  String topColorName;
  String bottomColorName;

  Test({
    this.topColorName,
    this.bottomColorName,
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    topColorName: json["topColorName"],
    bottomColorName: json["bottomColorName"],
  );

  Map<String, dynamic> toJson() => {
    "topColorName": topColorName,
    "bottomColorName": bottomColorName,
  };
}

class Call {
  int count;
  int id;
  String pinNumber;
  String dispatchStatusName;
  double towedTotalAmount;
  String towReasonName;
  String vehicleMakeName;
  String vehicleYearMakeModelName;
  int vehicleYear;
  String color;
  String towedInvoice;
  String towCustomerName;
  String dispatchContact;
  String dispatchContactPhone;
  String dispatchDate;
  String dispatchDispatchTime;
  String towedStreet;
  String towedStreetTwo;
  int towedCity;
  String towedCityName;
  String towedStateName;
  String towedZipCode;
  String towedToStreet;
  String towedToStreetTwo;
  String towedToCityName;
  String towedToStateName;
  String towedToZipCode;
  String dispatchInstructions_string;
  String licensePlate;
  String VIN;
  String wreckerDriverName;
  String towTruckName;
  String dispatchReceivedTime;
  String dispatchEnrouteTime;
  String dispatchOnsiteTime;
  String dispatchRollingTime;
  String dispatchClearedTime;
  String dispatchArrivedTime;
  Color progressStyleColor;
  double progressPercentage;
  String towedPONumber;
  int towCustomer;
  String towedDate;
  String towedTime;
  String towTypeName;
  int towType;
  int towAuthorization;
  String towAuthorizationName;
  int towJurisdiction;
  String towJurisdictionName;
  int topColor;
  String topColorName;
  int secondColor;
  String secondColorName;
  int vehicleLicenseState;
  String vehicleLicenseStateName;
  int towReason;
  int towedState;
  int wreckerCompany;
  String wreckerCompanyName;
  int wreckerDriver;
  int towTruck;
  int billTo;
  String billToName;
  int vehicleMake;
  int vehicleStyle;
  String vehicleStyleName;
  String dispatchInstructions;
  int storageMunicipal;
  String storageMunicipalName;
  bool PORequired;
  bool invoiceRequired;
  int storageCompany;
  String storageCompanyName;
  String towedDiscountRate;
  String towedDiscountAmount;
  int vehicleYearMakeModel;
  int towedToCity;
  int towedToState;
  int towBillTo;
  String towBillToName;
  int towedStatus;
  String towedStatusName;
  String dispatchMemberNumber;
  String dispatchLimitAmount;
  String dispatchLimitMiles;
  String towedTrailerNumber;
  String towedTruckNumber;
  String vehicleTitle;
  String vehicleOdometer;
  String vehicleLicenseYear;
  String wreckerDriverPaid;
  String wreckerDriverPayment;
  bool towedBonus;
  bool towedNoCommission;
  String dispatchETAMinutes;
  int dispatchPriorityLevel;
  String dispatchPriorityLevelName;
  String dispatchETAMaximum;
  String dispatchRequestorResponse;
  String dispatchProviderSelectedResponseName;
  String dispatchProviderResponse;
  String dispatchJobID;
  String dispatchAuthorizationNumber;
  String dispatchResponseID;
  String dispatchID;
  int bodyShop;
  String bodyShopName;
  String towedRONumber;
  String bodyShopAtShopDate;
  String bodyShopPendingDate;
  String bodyShopWorkingDate;
  String bodyShopTotaledDate;
  String bodyShopMovedDate;
  String bodyShopDriverTransferDate;
  String bodyShopDriverTransferAmount;
  String bodyShopDriverRepairDate;
  String bodyShopDriverRepairAmount;
  String bodyShopPaymentDate;
  String bodyShopPaymentAmount;
  bool junk;
  bool repairable;
  bool noCharge;
  bool dispatchAlarmConfirm;
  bool dispatchCancel;
  int vehicleLicenseType;
  String vehicleLicenseTypeName;
  String storageMvrAutoData;
  String systemRuntimeType;
  String keys;
  String ownerRelease;
  bool onHold;
  String bodyShopRepairAmount;

  Map<String, dynamic> toJson() => <String, dynamic>{
  "topColorName":topColorName,
  "secondColorName":secondColorName,
  "vehicleMakeName":vehicleMakeName,
  "vehicleYearMakeModelName":vehicleYearMakeModelName,
  "vehicleLicenseStateName":vehicleLicenseStateName,
  "towTypeName":towTypeName,
  "towCustomerName":towCustomerName,
  "towBillToName":towBillToName,
  "towJurisdictionName":towJurisdictionName,
  "wreckerDriverName":wreckerDriverName,
  "wreckerCompanyName":wreckerCompanyName,
  "towAuthorizationName":towAuthorizationName,
  "towReasonName":towReasonName,
  "pinNumber":"PIN0000074",
  "VIN":VIN,
  "licensePlate":licensePlate,
  "topColor":topColor,
  "secondColor":secondColor,
  "vehicleMake":vehicleMake,
  "vehicleYearMakeModel":vehicleYearMakeModel,
  "vehicleStyle":vehicleStyle,
  "vehicleYear":vehicleYear,
  "vehicleLicenseType":vehicleLicenseType,
  "vehicleLicenseState":vehicleLicenseState,
  "vehicleTitle":vehicleTitle,
  "vehicleOdometer":vehicleOdometer,
  "towType":towType,
  "towCustomer":towCustomer,
  "towBillTo":towBillTo,
  "towReason":towReason,
  "towJurisdiction":towJurisdiction,
  "storageMunicipal":storageMunicipal,
  "towAuthorization":towAuthorization,
//  "towAuthorizationStreet":towAuthorizationStreet,
//  "towAuthorizationStreetTwo":towAuthorizationStreetTwo,
//  "towAuthorizationCity":towAuthorizationCity,
//  "towAuthorizationState":towAuthorizationState,
//  "towAuthorizationCityName":towAuthorizationCityName,
//  "towAuthorizationStateName":towAuthorizationStateName,
//  "towAuthorizationZipCode":towAuthorizationZipCode,
//  "towAuthorizationContact":towAuthorizationContact,
//  "towAuthorizationPhone":towAuthorizationPhone,
  "towedStreet":towedStreet,
  "towedStreetTwo":towedStreetTwo,
  "towedCity":towedCity,
  "towedState":towedState,
  "towedZipCode":towedZipCode,
//  "towTruckNumber":towTruckNumber,
  "towTruck":towTruck,
//  "towTruckLicensePlate":towTruckLicensePlate,
//  "towTruckLicenseState":towTruckLicenseState,
//  "wreckerDriverLicense":wreckerDriverLicense,
  "wreckerDriver":wreckerDriver,
  "wreckerDriverPayment":wreckerDriverPayment,
  "wreckerDriverPaid":wreckerDriverPaid,
  "wreckerCompany":wreckerCompany,
//  "TVRMSRefNumber":TVRMSRefNumber,
  "storageCompany":storageCompany,
//  "storageCompanyLicenseState":storageCompanyLicenseState,
//  "storageReleaseDate":storageReleaseDate,
//  "storageReleaseTime":storageReleaseTime,
//  "storageReleaseToName":storageReleaseToName,
//  "storageReleaseToStreet":storageReleaseToStreet,
//  "storageReleaseToStreetTwo":storageReleaseToStreetTwo,
//  "storageReleaseToCity":storageReleaseToCity,
//  "storageReleaseToState":storageReleaseToState,
//  "storageReleaseToZipCode":storageReleaseToZipCode,
//  "storageReleaseToPhone":storageReleaseToPhone,
//  "storageReleaseIDType":storageReleaseIDType,
//  "storageReleaseIDNumber":storageReleaseIDNumber,
//  "storageReleaseOwnerType":storageReleaseOwnerType,
//  "storageReleaseOwnership":storageReleaseOwnership,
//  "storageMvrDate":storageMvrDate,
//  "storageMvrTime":storageMvrTime,
//  "storageMvrUUID":storageMvrUUID,
  "storageMvrAutoData":false,
//  "storageLienRefNumber":storageLienRefNumber,
//  "storageLienHolder":storageLienHolder,
  "noCharge":false,
  "systemRuntimeType":2,
//  "QBReference":QBReference,
  "towedStatus":towedStatus,
  "towedBonus":false,
  "towedPONumber":towedPONumber,
  "towedInvoice":towedInvoice,
  "towedRONumber":towedRONumber,
  "towedToStreet":towedToStreet,
  "towedToStreetTwo":towedToStreetTwo,
  "towedToCity":towedToCity,
  "towedToState":towedToState,
  "towedToZipCode":towedToZipCode,
  "towedTrailerNumber":towedTrailerNumber,
  "towedTruckNumber":towedTruckNumber,
  "towedNoCommission":false,
  "towedDiscountRate":towedDiscountRate,
  "towedDiscountAmount":towedDiscountAmount,
  "keys":false,
  "junk":false,
  "repairable":false,
  "ownerRelease":false,
  "onHold":false,
  "dispatchDate":dispatchDate,
  "dispatchReceivedTime":dispatchReceivedTime,
  "towedDate":towedDate,
  "towedTime":towedTime,
//  "storageReceivedDate":storageReceivedDate,
//  "storageReceivedTime":storageReceivedTime,
  "dispatchDispatchTime":dispatchDispatchTime,
  "dispatchEnrouteTime":dispatchEnrouteTime,
  "dispatchOnsiteTime":dispatchOnsiteTime,
  "dispatchRollingTime":dispatchRollingTime,
  "dispatchArrivedTime":dispatchArrivedTime,
//  "dispatchClearedTime":dispatchClearedTime,
  "dispatchETAMinutes":dispatchETAMinutes,
  "dispatchAlarmConfirm":false,
  "dispatchCancel":false,
  "dispatchLimitMiles":dispatchLimitMiles,
  "dispatchLimitAmount":dispatchLimitAmount,
  "dispatchContact":dispatchContact,
  "dispatchContactPhone":dispatchContactPhone,
  "dispatchPriorityLevel":1,
  "dispatchJobID":dispatchJobID,
  "dispatchID":dispatchID,
  "dispatchResponseID":dispatchResponseID,
  "dispatchAuthorizationNumber":dispatchAuthorizationNumber,
  "dispatchETAMaximum":30,
  "dispatchProviderResponse":dispatchProviderResponse,
//  "dispatchProviderSelectedResponse":dispatchProviderSelectedResponse,
  "dispatchRequestorResponse":dispatchRequestorResponse,
//  "systemMotorClub":systemMotorClub,
  "dispatchMemberNumber":dispatchMemberNumber,
  "bodyShop":bodyShop,
  "bodyShopAtShopDate":bodyShopAtShopDate,
  "bodyShopPendingDate":bodyShopPendingDate,
  "bodyShopWorkingDate":bodyShopWorkingDate,
  "bodyShopTotaledDate":bodyShopTotaledDate,
  "bodyShopMovedDate":bodyShopMovedDate,
  "bodyShopDriverTransferDate":bodyShopDriverTransferDate,
  "bodyShopDriverRepairDate":bodyShopDriverRepairDate,
  "bodyShopPaymentDate":bodyShopPaymentDate,
  "bodyShopDriverTransferAmount":0.00,
  "bodyShopDriverRepairAmount":0.00,
  "bodyShopPaymentAmount":bodyShopPaymentAmount,
//  "lawContactName":lawContactName,
//  "lawDate":lawDate,
//  "lawTime":lawTime,
//  "lawCaseNumber":lawCaseNumber,
//  "keyTag":keyTag,
//  "auctionReturnDate":auctionReturnDate,
//  "auctionReturnTime":auctionReturnTime,
  };

  Call({
    @required this.count,
    @required this.id,
    @required this.dispatchStatusName,
    @required this.towedTotalAmount,
    @required this.towReasonName,
    @required this.vehicleMakeName,
    @required this.vehicleYearMakeModelName,
    @required this.vehicleYear,
    @required this.color,
    @required this.towedInvoice,
    @required this.towCustomerName,
    @required this.dispatchContact,
    @required this.dispatchContactPhone,
    @required this.dispatchDate,
    @required this.dispatchDispatchTime,
    @required this.towedStreet,
    @required this.towedStreetTwo,
    @required this.towedCityName,
    @required this.towedStateName,
    @required this.towedZipCode,
    @required this.towedToStreet,
    @required this.towedToStreetTwo,
    @required this.towedToCityName,
    @required this.towedToStateName,
    @required this.towedToZipCode,
    @required this.dispatchInstructions_string,
    @required this.progressStyleColor,
    @required this.progressPercentage,
    @required this.licensePlate,
    @required this.VIN,
    @required this.wreckerDriverName,
    @required this.towTruckName,
    @required this.dispatchReceivedTime,
    @required this.dispatchEnrouteTime,
    @required this.dispatchOnsiteTime,
    @required this.dispatchRollingTime,
    @required this.dispatchClearedTime,
    @required this.dispatchArrivedTime,
    this.towedPONumber,
    this.towCustomer,
    this.towedDate,
    this.towedTime,
    this.towTypeName,
    this.towType,
    this.towAuthorization,
    this.towAuthorizationName,
    this.towedStatus,
    this.towedStatusName,
    this.dispatchMemberNumber,
    this.dispatchLimitAmount,
    this.dispatchLimitMiles,
    this.towedDiscountRate,
    this.towedTrailerNumber,
    this.towedTruckNumber,
    this.vehicleTitle,
    this.vehicleOdometer,
    this.vehicleLicenseYear,
    this.wreckerDriverPaid,
    this.wreckerDriverPayment,
    this.towedBonus,
    this.towedNoCommission,
    this.dispatchETAMinutes,
    this.dispatchPriorityLevel,
    this.dispatchPriorityLevelName,
    this.dispatchETAMaximum,
    this.dispatchRequestorResponse,
    this.dispatchProviderSelectedResponseName,
    this.dispatchProviderResponse,
    this.dispatchJobID,
    this.dispatchAuthorizationNumber,
    this.dispatchResponseID,
    this.dispatchID,
    this.bodyShop,
    this.bodyShopName,
    this.towedRONumber,
    this.bodyShopAtShopDate,
    this.bodyShopPendingDate,
    this.bodyShopWorkingDate,
    this.bodyShopTotaledDate,
    this.bodyShopMovedDate,
    this.bodyShopDriverTransferDate,
    this.bodyShopDriverTransferAmount,
    this.bodyShopDriverRepairDate,
    this.bodyShopDriverRepairAmount,
    this.bodyShopPaymentDate,
    this.bodyShopPaymentAmount,
    this.junk,
    this.repairable,
    this.noCharge,
    this.towBillTo,
    this.towBillToName,
    this.towedDiscountAmount,
    this.topColor,
    this.topColorName,
    this.secondColor,
    this.secondColorName,
    this.vehicleLicenseState,
    this.vehicleLicenseStateName,
    this.vehicleLicenseType,
    this.vehicleLicenseTypeName,
    this.vehicleMake,
    this.vehicleStyle,
    this.vehicleStyleName,
    this.towJurisdiction,
    this.towJurisdictionName,
    this.towedCity,
    this.towedState,
    this.towedToCity,
    this.towedToState,
    this.wreckerCompany,
    this.wreckerCompanyName,
    this.dispatchAlarmConfirm,
    this.dispatchCancel,
    this.pinNumber,
    this.vehicleYearMakeModel,
    this.towReason,
    this.storageMunicipal,
    this.towTruck,
    this.wreckerDriver,
    this.storageCompany,
    this.storageMvrAutoData,
    this.systemRuntimeType,
    this.keys,
    this.ownerRelease,
    this.onHold,
    this.bodyShopRepairAmount
  });

  factory Call.fromJson(Map<String, dynamic> json) =>
      _towedVehicleCallsFromJson(json);

  factory Call.fromJsonForAdd(Map<String, dynamic> json) =>
      _towedVehicleCallsFromJsonForAdd(json);
  }

Call _towedVehicleCallsFromJsonForAdd(Map<String, dynamic> parsedJson) {
  return Call(
      topColorName:parsedJson["topColorName"],
      secondColorName:parsedJson["secondColorName"]
//      vehicleMakeName:parsedJson["vehicleMakeName"] != null ? parsedJson["vehicleMakeName"] : '',
//      vehicleYearMakeModelName:parsedJson["vehicleYearMakeModelName"] != null ? parsedJson["vehicleYearMakeModelName"] : '',
//      vehicleLicenseStateName:parsedJson["vehicleLicenseStateName"] != null ? parsedJson["vehicleLicenseStateName"] : '',
//      towTypeName:parsedJson["towTypeName"] != null ? parsedJson["towTypeName"] : '',
//      towCustomerName:parsedJson["towCustomerName"] != null ? parsedJson["towCustomerName"] : '',
//      towBillToName:parsedJson["towBillToName"] != null ? parsedJson["towBillToName"] : '',
//      towJurisdictionName:parsedJson["towJurisdictionName"] != null ? parsedJson["towJurisdictionName"] : '',
//      wreckerDriverName:parsedJson["wreckerDriverName"] != null ? parsedJson["wreckerDriverName"] : '',
//      wreckerCompanyName:parsedJson["wreckerCompanyName"] != null ? parsedJson["wreckerCompanyName"] : '',
//      towAuthorizationName:parsedJson["towAuthorizationName"] != null ? parsedJson["towAuthorizationName"] : '',
//      towReasonName:parsedJson["towReasonName"] != null ? parsedJson["towReasonName"] : '',
//      pinNumber:"PIN0000074",
//      VIN:parsedJson["VIN"] != null ? parsedJson["VIN"] : '',
//      licensePlate:parsedJson["licensePlate"] != null ? parsedJson["licensePlate"] : '',
//      topColor:parsedJson["topColor"] != null ? parsedJson["topColor"] : '',
//      secondColor: parsedJson["secondColor"],
//      vehicleMake:parsedJson["vehicleMake"] != null ? parsedJson["vehicleMake"] : '',
//      vehicleYearMakeModel:parsedJson["vehicleYearMakeModel"] != null ? parsedJson["vehicleYearMakeModel"] : '',
//      vehicleStyle:parsedJson["vehicleStyle"] != null ? parsedJson["vehicleStyle"] : '',
//      vehicleYear:parsedJson["vehicleYear"] != null ? parsedJson["vehicleYear"] : '',
//      vehicleLicenseType:parsedJson["vehicleLicenseType"],
//      vehicleLicenseState:parsedJson["vehicleLicenseState"] != null ? parsedJson["vehicleLicenseState"] : '',
//      vehicleTitle:parsedJson["vehicleTitle"] != null ? parsedJson["vehicleTitle"] : '',
//      vehicleOdometer:parsedJson["vehicleOdometer"] != null ? parsedJson["vehicleOdometer"] : '',
//      towType:parsedJson["towType"],
//      towCustomer:parsedJson["towCustomer"] != null ? parsedJson["towCustomer"] : '',
//      towBillTo:parsedJson["towBillTo"] != null ? parsedJson["towBillTo"] : '',
//      towReason:parsedJson["towReason"] != null ? parsedJson["towReason"] : '',
//      towJurisdiction:parsedJson["towJurisdiction"] != null ? parsedJson["towJurisdiction"] : '',
//      storageMunicipal:parsedJson["storageMunicipal"] != null ? parsedJson["storageMunicipal"] : '',
//      towAuthorization:parsedJson["towAuthorization"] != null ? parsedJson["towAuthorization"] : '',
////  towAuthorizationStreet:parsedJson["towAuthorizationStreet"] != null ? parsedJson["towAuthorizationStreet"] : '',
////  towAuthorizationStreetTwo:parsedJson["towAuthorizationStreetTwo"] != null ? parsedJson["towAuthorizationStreetTwo"] : '',
////  towAuthorizationCity:parsedJson["towAuthorizationCity"] != null ? parsedJson["towAuthorizationCity"] : '',
////  towAuthorizationState:parsedJson["towAuthorizationState"] != null ? parsedJson["towAuthorizationState"] : '',
////  towAuthorizationCityName:parsedJson["towAuthorizationCityName"] != null ? parsedJson["towAuthorizationCityName"] : '',
////  towAuthorizationStateName:parsedJson["towAuthorizationStateName"] != null ? parsedJson["towAuthorizationStateName"] : '',
////  towAuthorizationZipCode:parsedJson["towAuthorizationZipCode"] != null ? parsedJson["towAuthorizationZipCode"] : '',
////  towAuthorizationContact:parsedJson["towAuthorizationContact"] != null ? parsedJson["towAuthorizationContact"] : '',
////  towAuthorizationPhone:parsedJson["towAuthorizationPhone"] != null ? parsedJson["towAuthorizationPhone"] : '',
//      towedStreet:parsedJson["towedStreet"] != null ? parsedJson["towedStreet"] : '',
//      towedStreetTwo:parsedJson["towedStreetTwo"] != null ? parsedJson["towedStreetTwo"] : '',
//      towedCity:parsedJson["towedCity"] != null ? parsedJson["towedCity"] : '',
//      towedState:parsedJson["towedState"] != null ? parsedJson["towedState"] : '',
//      towedZipCode:parsedJson["towedZipCode"] != null ? parsedJson["towedZipCode"] : '',
////  towTruckNumber:towTruckNumber,
//      towTruck:parsedJson["towTruck"],
////  towTruckLicensePlate:towTruckLicensePlate,
////  towTruckLicenseState:towTruckLicenseState,
////  wreckerDriverLicense:wreckerDriverLicense,
//      wreckerDriver:parsedJson["wreckerDriver"] != null ? parsedJson["wreckerDriver"] : '',
//      wreckerDriverPayment:parsedJson["wreckerDriverPayment"] != null ? parsedJson["wreckerDriverPayment"] : '',
//      wreckerDriverPaid:parsedJson["wreckerDriverPaid"] != null ? parsedJson["wreckerDriverPaid"] : '',
//      wreckerCompany:parsedJson["wreckerCompany"] != null ? parsedJson["wreckerCompany"] : '',
////  TVRMSRefNumber:parsedJson["TVRMSRefNumber"] != null ? parsedJson["TVRMSRefNumber"] : '',
//      storageCompany:parsedJson["storageCompany"] != null ? parsedJson["storageCompany"] : '',
////  storageCompanyLicenseState:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseDate:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseTime:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseToName:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseToStreet:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseToStreetTwo:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseToCity:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseToState:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseToZipCode:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseToPhone:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseIDType:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseIDNumber:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseOwnerType:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageReleaseOwnership:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageMvrDate:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageMvrTime:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageMvrUUID:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////      storageMvrAutoData:_convertTobool("false"),
////  storageLienRefNumber:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  storageLienHolder:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
//      noCharge:false,
////      systemRuntimeType:2,
////  QBReference:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
//      towedStatus:parsedJson["towedStatus"] != null ? parsedJson["towedStatus"] : '',
//      towedBonus:parsedJson["towedBonus"] != null ? parsedJson["towedBonus"] : '',
//      towedPONumber:parsedJson["towedPONumber"] != null ? parsedJson["towedPONumber"] : '',
//      towedInvoice:parsedJson["towedInvoice"] != null ? parsedJson["towedInvoice"] : '',
//      towedRONumber:parsedJson["towedRONumber"] != null ? parsedJson["towedRONumber"] : '',
//      towedToStreet:parsedJson["towedToStreet"] != null ? parsedJson["towedToStreet"] : '',
//      towedToStreetTwo:parsedJson["towedToStreetTwo"] != null ? parsedJson["towedToStreetTwo"] : '',
//      towedToCity:parsedJson["towedToCity"],
//      towedToState:parsedJson["towedToState"],
//      towedToZipCode:parsedJson["towedToZipCode"] != null ? parsedJson["towedToZipCode"] : '',
//      towedTrailerNumber:parsedJson["towedTrailerNumber"] != null ? parsedJson["towedTrailerNumber"] : '',
//      towedTruckNumber:parsedJson["towedTruckNumber"] != null ? parsedJson["towedTruckNumber"] : '',
//      towedNoCommission:false,
//      towedDiscountRate:parsedJson["towedDiscountRate"] != null ? parsedJson["towedDiscountRate"] : '',
//      towedDiscountAmount:parsedJson["towedDiscountAmount"] != null ? parsedJson["towedDiscountAmount"] : '',
////      keys:false,
//      junk:false,
//      repairable:false,
////      ownerRelease:false,
//      onHold:false,
//      dispatchDate:parsedJson["dispatchDate"] != null ? parsedJson["dispatchDate"] : '',
//      dispatchReceivedTime:parsedJson["dispatchReceivedTime"] != null ? parsedJson["dispatchReceivedTime"] : '',
//      towedDate:parsedJson["towedDate"] != null ? parsedJson["towedDate"] : '',
//      towedTime:parsedJson["towedTime"] != null ? parsedJson["towedTime"] : '',
////  storageReceivedDate:storageReceivedDate,
////  storageReceivedTime:storageReceivedTime,
//      dispatchDispatchTime:parsedJson["dispatchDispatchTime"] != null ? parsedJson["dispatchDispatchTime"] : '',
//      dispatchEnrouteTime:parsedJson["dispatchEnrouteTime"] != null ? parsedJson["dispatchEnrouteTime"] : '',
//      dispatchOnsiteTime:parsedJson["dispatchOnsiteTime"] != null ? parsedJson["dispatchOnsiteTime"] : '',
//      dispatchRollingTime:parsedJson["dispatchRollingTime"] != null ? parsedJson["dispatchRollingTime"] : '',
//      dispatchArrivedTime:parsedJson["dispatchArrivedTime"] != null ? parsedJson["dispatchArrivedTime"] : '',
////  dispatchClearedTime:dispatchClearedTime,
//      dispatchETAMinutes:parsedJson["dispatchETAMinutes"] != null ? parsedJson["dispatchETAMinutes"] : '',
//      dispatchAlarmConfirm:false,
//      dispatchCancel:false,
//      dispatchLimitMiles:parsedJson["dispatchLimitMiles"] != null ? parsedJson["dispatchLimitMiles"] : '',
//      dispatchLimitAmount:parsedJson["dispatchLimitAmount"] != null ? parsedJson["dispatchLimitAmount"] : '',
//      dispatchContact:parsedJson["dispatchContact"] != null ? parsedJson["dispatchContact"] : '',
//      dispatchContactPhone:parsedJson["dispatchContactPhone"] != null ? parsedJson["dispatchContactPhone"] : '',
//      dispatchPriorityLevel:1,
//      dispatchJobID:parsedJson["dispatchJobID"] != null ? parsedJson["dispatchJobID"] : '',
//      dispatchID:parsedJson["dispatchID"] != null ? parsedJson["dispatchID"] : '',
//      dispatchResponseID:parsedJson["dispatchResponseID"] != null ? parsedJson["dispatchResponseID"] : '',
//      dispatchAuthorizationNumber:parsedJson["dispatchAuthorizationNumber"] != null ? parsedJson["dispatchAuthorizationNumber"] : '',
//      dispatchETAMaximum:"30",
//      dispatchProviderResponse:parsedJson["dispatchProviderResponse"] != null ? parsedJson["dispatchProviderResponse"] : '',
////  dispatchProviderSelectedResponse:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
//      dispatchRequestorResponse:parsedJson["dispatchRequestorResponse"] != null ? parsedJson["dispatchRequestorResponse"] : '',
////  systemMotorClub:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
//      dispatchMemberNumber:parsedJson["dispatchMemberNumber"] != null ? parsedJson["dispatchMemberNumber"] : '',
//      bodyShop:parsedJson["bodyShop"] ,
//      bodyShopAtShopDate:parsedJson["bodyShopAtShopDate"] != null ? parsedJson["bodyShopAtShopDate"] : '',
//      bodyShopPendingDate:parsedJson["bodyShopPendingDate"] != null ? parsedJson["bodyShopPendingDate"] : '',
//      bodyShopWorkingDate:parsedJson["bodyShopWorkingDate"] != null ? parsedJson["bodyShopWorkingDate"] : '',
//      bodyShopTotaledDate:parsedJson["bodyShopTotaledDate"] != null ? parsedJson["bodyShopTotaledDate"] : '',
//      bodyShopMovedDate:parsedJson["bodyShopMovedDate"] != null ? parsedJson["bodyShopMovedDate"] : '',
//      bodyShopDriverTransferDate:parsedJson["bodyShopDriverTransferDate"] != null ? parsedJson["bodyShopDriverTransferDate"] : '',
//      bodyShopDriverRepairDate:parsedJson["bodyShopDriverRepairDate"] != null ? parsedJson["bodyShopDriverRepairDate"] : '',
//      bodyShopPaymentDate:parsedJson["bodyShopPaymentDate"] != null ? parsedJson["bodyShopPaymentDate"] : '',
//      bodyShopDriverTransferAmount:"0.00",
//      bodyShopDriverRepairAmount:"0.00",
//      bodyShopPaymentAmount:parsedJson["bodyShopPaymentAmount"] != null ? parsedJson["bodyShopPaymentAmount"] : '',
////  lawContactName:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  lawDate:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  lawTime:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  lawCaseNumber:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  keyTag:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  auctionReturnDate:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',
////  auctionReturnTime:parsedJson["topColorName"] != null ? parsedJson["topColorName"] : '',

  );
}

Call _towedVehicleCallsFromJson(Map<String, dynamic> parsedJson) {
  return Call(
      id: int.parse(parsedJson["id"]),
      dispatchStatusName: parsedJson["dispatchStatusName"],
      towedTotalAmount: double.parse(parsedJson["towedTotalAmount"]),
      towReasonName: parsedJson["towReasonName"],
      vehicleMakeName: parsedJson["vehicleMakeName"],
      vehicleYearMakeModelName: parsedJson["vehicleYearMakeModelName"],
      vehicleYear: int.parse(parsedJson["vehicleYear"]),
      color: parsedJson["color"],
      towedInvoice: parsedJson["towedInvoice"] != null
          ? parsedJson["towedInvoice"]
          : '',
      towCustomerName: parsedJson["towCustomerName"] != null
          ? parsedJson["towCustomerName"]
          : '',
      dispatchContact: parsedJson["dispatchContact"] != null
          ? parsedJson["dispatchContact"]
          : '',
      dispatchContactPhone: parsedJson["dispatchContactPhone"] != null
          ? parsedJson["dispatchContactPhone"]
          : '',
      dispatchDate: parsedJson["dispatchDate"] != null
          ? parsedJson["dispatchDate"]
          : '',
      dispatchDispatchTime: parsedJson["dispatchDispatchTime"] != null
          ? parsedJson["dispatchDispatchTime"]
          : '',
      towedStreet: parsedJson["towedStreet"] != null
          ? parsedJson["towedStreet"]
          : '',
      towedStreetTwo: parsedJson["towedStreetTwo"] != null
          ? parsedJson["towedStreetTwo"]
          : '',
      towedCity: parsedJson["towedCity"] != "0" ? int.parse(
          parsedJson["towedCity"]) : 0,
      towedCityName: parsedJson["towedCityName"] != null
          ? parsedJson["towedCityName"]
          : '',
      towedState: parsedJson["towedState"] != "0" ? int.parse(
          parsedJson["towedState"]) : 0,
      towedStateName: parsedJson["towedStateName"] != null
          ? parsedJson["towedStateName"]
          : '',
      towedZipCode: parsedJson["towedZipCode"] != null
          ? parsedJson["towedZipCode"]
          : '',
      towedToStreet: parsedJson["towedToStreet"] != null
          ? parsedJson["towedToStreet"]
          : '',
      towedToStreetTwo: parsedJson["towedToStreetTwo"] != null
          ? parsedJson["towedToStreetTwo"]
          : '',
      towedToCity: parsedJson["towedToCity"] != "0" ? int.parse(
          parsedJson["towedToCity"]) : 0,
      towedToCityName: parsedJson["towedToCityName"] != null
          ? parsedJson["towedToCityName"]
          : '',
      towedToState: parsedJson["towedToState"] != "0" ? int.parse(
          parsedJson["towedToState"]) : 0,
      towedToStateName: parsedJson["towedToStateName"] != null
          ? parsedJson["towedToStateName"]
          : '',
      towedToZipCode: parsedJson["towedToZipCode"] != null
          ? parsedJson["towedToZipCode"]
          : '',
      dispatchInstructions_string: parsedJson["dispatchInstructions_string"],
      towedStatus:int.parse(parsedJson["towedStatus"]),
      towedStatusName: parsedJson["towedStatusName"] != null
          ? parsedJson["towedStatusName"]
          : '',
      licensePlate: parsedJson["licensePlate"],
      VIN: parsedJson["VIN"],
      wreckerDriverName: parsedJson["wreckerDriverName"],
      towTruckName: parsedJson["towTruckName"],
      dispatchReceivedTime: parsedJson["dispatchReceivedTime"],
      dispatchEnrouteTime: parsedJson["dispatchEnrouteTime"],
      dispatchOnsiteTime: parsedJson["dispatchOnsiteTime"],
      dispatchRollingTime: parsedJson["dispatchRollingTime"],
      dispatchClearedTime: parsedJson["dispatchClearedTime"],
      dispatchArrivedTime: parsedJson["dispatchArrivedTime"],

//    progressStyleColor: parsedJson["progressStyleColor"],
//    progressPercentage: parsedJson["progressPercentage"],
      towedPONumber: parsedJson["towedPONumber"] != null
          ? parsedJson["towedPONumber"]
          : '',
      towCustomer: int.parse(parsedJson["towCustomer"]),
      towedDate: parsedJson["towedDate"],
      towedTime: parsedJson["towedTime"],
      towTypeName: parsedJson["towTypeName"],
      towType: int.parse(parsedJson["towType"]),
      towAuthorization: int.parse(parsedJson["towAuthorization"]) != 0 ? int
          .parse(parsedJson["towAuthorization"]) : 0,
      towAuthorizationName: parsedJson["towAuthorizationName"] != null
          ? parsedJson["towAuthorizationName"]
          : "",
      towJurisdiction: int.parse(parsedJson["towJurisdiction"]) != 0 ? int
          .parse(parsedJson["towJurisdiction"]) : 0,
      towJurisdictionName: parsedJson["towJurisdictionName"] != null
          ? parsedJson["towJurisdictionName"]
          : "",
      topColor: parsedJson["topColor"] != "0" ? int.parse(
          parsedJson["topColor"]) : 0,
      topColorName: parsedJson["topColorName"] != null
          ? parsedJson["topColorName"]
          : "",
      secondColor: parsedJson["secondColor"] != "0" ? int.parse(
          parsedJson["secondColor"]) : 0,
      secondColorName: parsedJson["secondColorName"] != null
          ? parsedJson["secondColorName"]
          : "",
      vehicleLicenseState: parsedJson["vehicleLicenseState"] != "0" ? int.parse(
          parsedJson["vehicleLicenseState"]) : 0,
      vehicleLicenseStateName: parsedJson["vehicleLicenseStateName"] != null
          ? parsedJson["vehicleLicenseStateName"]
          : "",
      vehicleLicenseType: parsedJson["vehicleLicenseType"] != "0" ? int.parse(
          parsedJson["vehicleLicenseType"]) : 0,
      vehicleLicenseTypeName: parsedJson["vehicleLicenseTypeName"] != null
          ? parsedJson["vehicleLicenseTypeName"]
          : "",
      //   towReason: parsedJson["towReason"],
      //   towedState: parsedJson["towedState"],
      wreckerCompany:int.parse(parsedJson["wreckerCompany"]),
      wreckerCompanyName: parsedJson["wreckerCompanyName"] != null
          ? parsedJson["wreckerCompanyName"]
          : '',
      //   wreckerDriver: parsedJson["wreckerDriver"],
      //   towTruck: parsedJson["towTruck"],
//    billTo: parsedJson["billTo"] != "0" ? int.parse(parsedJson["billTo"]):0,
      //   billToName: parsedJson["billToName"] != null ? parsedJson["billToName"] : '',
      vehicleMake: parsedJson["vehicleMake"] != "0" ? int.parse(
          parsedJson["vehicleMake"]) : 0,
      vehicleStyle: parsedJson["vehicleStyle"] != "0" ? int.parse(
          parsedJson["vehicleStyle"]) : 0,
      vehicleStyleName: parsedJson["vehicleStyleName"] != null
          ? parsedJson["vehicleStyleName"]
          : '',
      //   dispatchInstructions: parsedJson["dispatchInstructions"],
//    towedStateName: parsedJson["towedStateName"],
//    towedZipCode: parsedJson["towedZipCode"],
//    towedToStreet: parsedJson["towedToStreet"],
//    towedToStreetTwo: parsedJson["towedToStreetTwo"],
//    towedToCityName: parsedJson["towedToCityName"],
//    towedToStateName: parsedJson["towedToStateName"],
//    towedToZipCode: parsedJson["towedToZipCode"],
//    dispatchInstructions_string: parsedJson["dispatchInstructions_string"],
//    storageMunicipal: parsedJson["storageMunicipal"],
//    PORequired: parsedJson["PORequired"],
//    wreckerDriverName: parsedJson["wreckerDriverName"],
//    towTruckName: parsedJson["towTruckName"],
//    dispatchReceivedTime: parsedJson["dispatchReceivedTime"],
//    dispatchEnrouteTime: parsedJson["dispatchEnrouteTime"],
//    dispatchOnsiteTime: parsedJson["dispatchOnsiteTime"],
//    dispatchRollingTime: parsedJson["dispatchRollingTime"],
//    dispatchClearedTime: parsedJson["dispatchClearedTime"],
//    dispatchArrivedTime: parsedJson["dispatchArrivedTime"],
      progressStyleColor: parsedJson["progressStyleColor"],
      progressPercentage: parsedJson["progressPercentage"],
//    towedPONumber: parsedJson["towedPONumber"],
//    invoiceRequired: parsedJson["invoiceRequired"],
//    storageCompany: parsedJson["storageCompany"],
//    storageCompanyName: parsedJson["storageCompanyName"],
      towedDiscountRate: parsedJson["towedDiscountRate"] != null
          ? parsedJson["towedDiscountRate"]
          : '',
      towedDiscountAmount: parsedJson["towedDiscountAmount"] != null
          ? parsedJson["towedDiscountAmount"]
          : '',
//    vehicleYearMakeModel: parsedJson["vehicleYearMakeModel"],
//    towedToCity: parsedJson["towedToCity"],
//    towedToState: parsedJson["towedToState"],
      towBillTo: parsedJson["towBillTo"] != "0" ? int.parse(
          parsedJson["towBillTo"]) : 0,
      towBillToName: parsedJson["towBillToName"] != null
          ? parsedJson["towBillToName"]
          : '',
      dispatchMemberNumber: parsedJson["dispatchMemberNumber"] != null
          ? parsedJson["dispatchMemberNumber"]
          : '',
      dispatchLimitAmount: parsedJson["dispatchLimitAmount"] != null
          ? parsedJson["dispatchLimitAmount"]
          : '',
      dispatchLimitMiles: parsedJson["dispatchLimitMiles"] != null
          ? parsedJson["dispatchLimitMiles"]
          : '',
      towedTrailerNumber: parsedJson["towedTrailerNumber"] != null
          ? parsedJson["towedTrailerNumber"]
          : '',
      towedTruckNumber: parsedJson["towedTruckNumber"] != null
          ? parsedJson["towedTruckNumber"]
          : '',
      vehicleTitle: parsedJson["vehicleTitle"] != null
          ? parsedJson["vehicleTitle"]
          : '',
      vehicleOdometer: parsedJson["vehicleOdometer"] != null
          ? parsedJson["vehicleOdometer"]
          : '',
      vehicleLicenseYear: parsedJson["vehicleLicenseYear"] != null
          ? parsedJson["vehicleLicenseYear"]
          : '',
      wreckerDriverPaid: parsedJson["wreckerDriverPaid"] != null
          ? parsedJson["wreckerDriverPaid"]
          : '',
      wreckerDriverPayment: parsedJson["wreckerDriverPayment"] != null
          ? parsedJson["wreckerDriverPayment"]
          : '',
      towedBonus: _convertTobool(parsedJson["towedBonus"]),
      towedNoCommission: _convertTobool(parsedJson["towedNoCommission"]),
      dispatchETAMinutes: parsedJson["dispatchETAMinutes"] != null
          ? parsedJson["dispatchETAMinutes"]
          : '',
      dispatchPriorityLevel: parsedJson["dispatchPriorityLevel"] != "0" ? int
          .parse(parsedJson["dispatchPriorityLevel"]) : 0,
      dispatchPriorityLevelName: parsedJson["dispatchPriorityLevelName"] != null
          ? parsedJson["dispatchPriorityLevelName"]
          : '',
      dispatchETAMaximum: parsedJson["dispatchETAMaximum"] != null
          ? parsedJson["dispatchETAMaximum"]
          : '',
      dispatchRequestorResponse: parsedJson["dispatchRequestorResponse"] != null
          ? parsedJson["dispatchRequestorResponse"]
          : '',
      dispatchProviderSelectedResponseName: parsedJson["dispatchProviderSelectedResponseName"] !=
          null ? parsedJson["dispatchProviderSelectedResponseName"] : '',
      dispatchProviderResponse: parsedJson["dispatchProviderResponse"] != null
          ? parsedJson["dispatchProviderResponse"]
          : '',
      dispatchJobID: parsedJson["dispatchJobID"] != null
          ? parsedJson["dispatchJobID"]
          : '',
      dispatchAuthorizationNumber: parsedJson["dispatchAuthorizationNumber"] !=
          null ? parsedJson["dispatchAuthorizationNumber"] : '',
      dispatchResponseID: parsedJson["dispatchResponseID"] != null
          ? parsedJson["dispatchResponseID"]
          : '',
      dispatchID: parsedJson["dispatchID"] != null
          ? parsedJson["dispatchID"]
          : '',
      bodyShop: int.parse(parsedJson["bodyShop"]) != 0 ? int.parse(
          parsedJson["bodyShop"]) : 0,
      bodyShopName: parsedJson["bodyShopName"] != null
          ? parsedJson["bodyShopName"]
          : '',
      towedRONumber: parsedJson["towedRONumber"] != null
          ? parsedJson["towedRONumber"]
          : '',
      bodyShopAtShopDate: parsedJson["bodyShopAtShopDate"] != null
          ? parsedJson["bodyShopAtShopDate"]
          : '',
      bodyShopPendingDate: parsedJson["bodyShopPendingDate"] != null
          ? parsedJson["bodyShopPendingDate"]
          : '',
      bodyShopWorkingDate: parsedJson["bodyShopWorkingDate"] != null
          ? parsedJson["bodyShopWorkingDate"]
          : '',
      bodyShopTotaledDate: parsedJson["bodyShopTotaledDate"] != null
          ? parsedJson["bodyShopTotaledDate"]
          : '',
      bodyShopMovedDate: parsedJson["bodyShopMovedDate"] != null
          ? parsedJson["bodyShopMovedDate"]
          : '',
      bodyShopDriverTransferDate: parsedJson["bodyShopDriverTransferDate"] !=
          null ? parsedJson["bodyShopDriverTransferDate"] : '',
      bodyShopDriverTransferAmount: parsedJson["bodyShopDriverTransferAmount"] !=
          null ? parsedJson["bodyShopDriverTransferAmount"] : '',
      bodyShopDriverRepairDate: parsedJson["bodyShopDriverRepairDate"] != null
          ? parsedJson["bodyShopDriverRepairDate"]
          : '',
      bodyShopDriverRepairAmount: parsedJson["bodyShopDriverRepairAmount"] !=
          null ? parsedJson["bodyShopDriverRepairAmount"] : '',
      bodyShopPaymentDate: parsedJson["bodyShopPaymentDate"] != null
          ? parsedJson["bodyShopPaymentDate"]
          : '',
      bodyShopPaymentAmount: parsedJson["bodyShopPaymentAmount"] != null
          ? parsedJson["bodyShopPaymentAmount"]
          : '',
      junk: _convertTobool(parsedJson["junk"]),
      repairable: _convertTobool(parsedJson["repairable"]),
      noCharge: _convertTobool(parsedJson["noCharge"]),
      dispatchAlarmConfirm: _convertTobool(parsedJson["dispatchAlarmConfirm"]),
      dispatchCancel: _convertTobool(parsedJson["dispatchCancel"]));
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