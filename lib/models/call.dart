import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:xml2json/xml2json.dart';
import 'dart:convert';

class Call {
  String count;
  int id;
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

//   DateTime dispatchDate;
//   DateTime dispatchDispatchTime;
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

//
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
  });

  Map<String, dynamic> toJson() => _itemToJson(this);
}

Map<String, dynamic> _itemToJson(Call instance) {
  return <String, dynamic>{
    'id': instance.id,
    'dispatchStatusName': instance.dispatchStatusName,
    'towedTotalAmount': instance.towedTotalAmount,
    'towReasonName': instance.towReasonName,
    'vehicleMakeName': instance.vehicleMakeName,
    'vehicleYearMakeModelName': instance.vehicleYearMakeModelName,
    'vehicleYear': instance.vehicleYear,
    'color': instance.color,
    'towedInvoice': instance.towedInvoice,
    'towCustomerName': instance.towCustomerName,
    'dispatchContact': instance.dispatchContact,
    'dispatchContactPhone': instance.dispatchContactPhone,
    'dispatchDate': instance.dispatchDate,
    'dispatchDispatchTime': instance.dispatchDispatchTime,
    'towedStreet': instance.towedStreet,
    'towedStreetTwo': instance.towedStreetTwo,
    'towedCityName': instance.towedCityName,
    'towedStateName': instance.towedStateName,
    'towedZipCode': instance.towedZipCode,
    'towedToStreet': instance.towedToStreet,
    'towedToStreetTwo': instance.towedToStreetTwo,
    'towedToCityName': instance.towedToCityName,
    'towedToStateName': instance.towedToStateName,
    'towedToZipCode': instance.towedToZipCode,
    'dispatchInstructions_string': instance.dispatchInstructions_string,
    'licensePlate': instance.licensePlate,
    'VIN': instance.VIN,
    'wreckerDriverName': instance.wreckerDriverName,
    'towTruckName': instance.towTruckName,
    'dispatchReceivedTime': instance.dispatchReceivedTime,
    'dispatchEnrouteTime': instance.dispatchEnrouteTime,
    'dispatchOnsiteTime': instance.dispatchOnsiteTime,
    'dispatchRollingTime': instance.dispatchRollingTime,
    'dispatchClearedTime': instance.dispatchClearedTime,
    'dispatchArrivedTime': instance.dispatchArrivedTime,
    'progressStyleColor': instance.progressStyleColor,
    'progressPercentage': instance.progressPercentage,
    'towedPONumber': instance.towedPONumber,
    'towCustomer': instance.towCustomer,
    'towedDate': instance.towedDate,
    'towedTime': instance.towedTime,
    'towTypeName': instance.towTypeName,
    'towType': instance.towType,
    'towAuthorization': instance.towAuthorization,
    'towAuthorizationName': instance.towAuthorizationName,
    'towJurisdiction': instance.towJurisdiction,
    'towJurisdictionName': instance.towJurisdictionName,
    'topColor': instance.topColor,
    'topColorName': instance.topColorName,
    'secondColor': instance.secondColor,
    'secondColorName': instance.secondColorName,
    'vehicleLicenseState': instance.vehicleLicenseState,
    'vehicleLicenseStateName': instance.vehicleLicenseStateName,
    'towReason': instance.towReason,
    'towedState': instance.towedState,
    'wreckerCompany': instance.wreckerCompany,
    'wreckerCompanyName': instance.wreckerCompanyName,
    'wreckerDriver': instance.wreckerDriver,
    'towTruck': instance.towTruck,
    'billTo': instance.billTo,
    'billToName': instance.billToName,
    'vehicleMake': instance.vehicleMake,
    'vehicleStyle': instance.vehicleStyle,
    'vehicleStyleName': instance.vehicleStyleName,
    'dispatchInstructions': instance.dispatchInstructions,
    'towedStateName': instance.towedStateName,
    'towedZipCode': instance.towedZipCode,
    'towedToStreet': instance.towedToStreet,
    'towedToStreetTwo': instance.towedToStreetTwo,
    'towedToCityName': instance.towedToCityName,
    'towedToStateName': instance.towedToStateName,
    'towedToZipCode': instance.towedToZipCode,
    'dispatchInstructions_string': instance.dispatchInstructions_string,
    'storageMunicipal': instance.storageMunicipal,
    'PORequired': instance.PORequired,
    'wreckerDriverName': instance.wreckerDriverName,
    'towTruckName': instance.towTruckName,
    'dispatchReceivedTime': instance.dispatchReceivedTime,
    'dispatchEnrouteTime': instance.dispatchEnrouteTime,
    'dispatchOnsiteTime': instance.dispatchOnsiteTime,
    'dispatchRollingTime': instance.dispatchRollingTime,
    'dispatchClearedTime': instance.dispatchClearedTime,
    'dispatchArrivedTime': instance.dispatchArrivedTime,
    'progressStyleColor': instance.progressStyleColor,
    'progressPercentage': instance.progressPercentage,
    'towedPONumber': instance.towedPONumber,
    'invoiceRequired': instance.invoiceRequired,
    'storageCompany': instance.storageCompany,
    'storageCompanyName': instance.storageCompanyName,
    'towedDiscountRate': instance.towedDiscountRate,
    'towedDiscountAmount': instance.towedDiscountAmount,
    'vehicleYearMakeModel': instance.vehicleYearMakeModel,
    'towedToCity': instance.towedToCity,
    'towedToState': instance.towedToState,
    'towBillTo': instance.towBillTo,
    'towBillToName': instance.towBillToName,
    'towBillTo': instance.towedStatus,
    'towBillToName': instance.towedStatusName,
    'dispatchMemberNumber': instance.dispatchMemberNumber,
    'dispatchLimitAmount': instance.dispatchLimitAmount,
    'dispatchLimitMiles': instance.dispatchLimitMiles,
    'towedTrailerNumber': instance.towedTrailerNumber,
    'towedTruckNumber': instance.towedTruckNumber,
    'vehicleTitle': instance.vehicleTitle,
    'vehicleOdometer': instance.vehicleOdometer,
    'vehicleLicenseYear': instance.vehicleLicenseYear,
    'wreckerDriverPaid': instance.wreckerDriverPaid,
    'wreckerDriverPayment': instance.wreckerDriverPayment,
    'towedBonus': instance.towedBonus,
    'towedNoCommission': instance.towedNoCommission,
    'dispatchETAMinutes': instance.dispatchETAMinutes,
    'dispatchPriorityLevel': instance.dispatchPriorityLevel,
    'dispatchPriorityLevelName': instance.dispatchPriorityLevelName,
    'dispatchETAMaximum': instance.dispatchETAMaximum,
    'dispatchRequestorResponse': instance.dispatchRequestorResponse,
    'dispatchProviderSelectedResponseName':instance.dispatchProviderSelectedResponseName,
    'dispatchProviderResponse': instance.dispatchProviderResponse,
    'dispatchJobID': instance.dispatchJobID,
    'dispatchAuthorizationNumber': instance.dispatchAuthorizationNumber,
    'dispatchResponseID': instance.dispatchResponseID,
    'dispatchID': instance.dispatchID,
    'bodyShop': instance.bodyShop,
    'bodyShopName': instance.bodyShopName,
    'towedRONumber': instance.towedRONumber,
    'bodyShopAtShopDate': instance.bodyShopAtShopDate,
    'bodyShopPendingDate': instance.bodyShopPendingDate,
    'bodyShopWorkingDate': instance.bodyShopWorkingDate,
    'bodyShopTotaledDate': instance.bodyShopTotaledDate,
    'bodyShopMovedDate': instance.bodyShopMovedDate,
    'bodyShopDriverTransferDate': instance.bodyShopDriverTransferDate,
    'bodyShopDriverTransferAmount': instance.bodyShopDriverTransferAmount,
    'bodyShopDriverRepairDate': instance.bodyShopDriverRepairDate,
    'bodyShopDriverRepairAmount': instance.bodyShopDriverRepairAmount,
    'bodyShopPaymentDate': instance.bodyShopPaymentDate,
    'bodyShopPaymentAmount': instance.bodyShopPaymentAmount,
    'junk': instance.junk,
    'repairable': instance.repairable
  };
}
