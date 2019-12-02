import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:xml2json/xml2json.dart';
import 'dart:convert';

class Call {
//  int id;
//  String pinNumber;
//  String VIN;
//  String licensePlate;
//  int topColor;
//  String topColorName;
//  int secondColor;
//  String secondColorName;
//  int vehicleMake;
//  String vehicleMakeName;
//  int vehicleYearMakeModel;
//  String vehicleYearMakeModelName;
//  int vehicleStyle;
//  String vehicleStyleName;
//  int vehicleYear;
//  String vehicleLicenseType;
//  String vehicleLicenseTypeName;
//  int vehicleLicenseYear;
//  int vehicleLicenseState;
//  String vehicleLicenseStateName;
//  String vehicleTitle;
//  int towType;
//  String towTypeName;
//  int towCustomer;
//  String towCustomerName;
//  int towBillTo;
//  String towBillToName;
//  int towReason;
//  String towReasonName;
//  String towReasonExportCode;
//  int towJurisdiction;
//  String towJurisdictionName;
//  int towAuthorization;
//  String towAuthorizationName;
//  String towAuthorizationStreet;
//  String towAuthorizationStreetTwo;
//  int towAuthorizationCity;
//  String towAuthorizationCityName;
//  int towAuthorizationState;
//  String towAuthorizationStateName;
//  String towAuthorizationZipCode;
//  String towAuthorizationContact;
//  String towAuthorizationPhone;
//  String towedStreet;
//  String towedStreetTwo;
//  int towedCity;
//  String towedCityName;
//  int towedState;
//  String towedStateName;
//  String towedZipCode;
//  String towedDate;
//  String towedTime;
//  String towTruckNumber;
//  String towTruckMedallion;
//  int towTruck;
//  String towTruckName;
//  String towTruckLicensePlate;
//  int towTruckLicenseState;
//  String towTruckLicenseStateName;
//  String wreckerDriverLicense;
//  int wreckerDriver;
//  String wreckerDriverName;
//  String wreckerDriverPayment;
//  String wreckerDriverPaid;
//  String wreckerDriverPhone;
//  String wreckerDriverStateLicense;
//  String wreckerDriverCityLicense;
//  int wreckerDriverSMSType;
//  int wreckerCompany;
//  String wreckerCompanyName;
//  String wreckerCompanyStateLicense;
//  String wreckerCompanyCityLicense;
//  String payStatus;
//  String payStatusName;
//  int TVRMSRefNumber;
//  String stockNumber;
//  int storageStatus;
//  String storageStatusName;
//  String storageCompanyLicenseState;
//  int storageCompany;
//  String storageCompanyName;
//  String storageReceivedDate;
//  String storageReceivedTime;
//  String storageReleaseDate;
//  String storageReleaseTime;
//  String storageReleaseToName;
//  String storageReleaseToStreet;
//  String storageReleaseToStreetTwo;
//  int storageReleaseToCity;
//  String storageReleaseToCityName;
//  int storageReleaseToState;
//  String storageReleaseToStateName;
//  String storageReleaseToZipCode;
//  String storageReleaseToPhone;
//  int storageReleaseIDType;
//  String storageReleaseIDTypeName;
//  String storageReleaseIDNumber;
//  int storageReleaseOwnerType;
//  String storageReleaseOwnerTypeName;
//  int storageReleaseOwnership;
//  String storageReleaseOwnershipName;
//  String storageMvrDate;
//  String storageMvrTime;
//  String storageMvrUUID;
//  bool storageMvrAutoData;
//  String storageLienRefNumber;
//  int storageLienHolder;
//  String storageLienHolderName;
//  int storageMunicipal;
//  String storageMunicipalName;
//  bool noCharge;
//  int  systemRuntimeType;
//  String systemRuntimeTypeName;
//  String QBReference;
//  String towedStatus;
//  String towedStatusName;
//  bool towedBonus;
//  String towedPONumber;
//  String towedInvoice;
//  String towedRONumber;
//  String towedToStreet;
//  String towedToStreetTwo;
//  String towedToCityName;
//  int towedToCity;
//  String towedToStateName;
//  int towedToState;
//  String towedToZipCode;
//  String towedTrailerNumber;
//  String towedTruckNumber;
//  bool towedNoCommission;
//  String towedDiscountRate;
//  String towedDiscountAmount;
//  String dispatchStatus;
//  String dispatchStatusName;
//  int dispatchSortStatus;
//  String dispatchDate;
//  String dispatchReceivedTime;
//  String dispatchDispatchTime;
//  String dispatchEnrouteTime;
//  String dispatchOnsiteTime;
//  String dispatchRollingTime;
//  String dispatchArrivedTime;
//  String dispatchClearedTime;
//  int dispatchETAMinutes;
//  bool dispatchAlarmConfirm;
//  bool dispatchCancel;
//  int dispatchLimitMiles;
//  String dispatchLimitAmount;
//  String dispatchContact;
//  String dispatchContactPhone;
//  //<dispatchInstructions;base64Binary</dispatchInstructions;
//  String dispatchInstructions_string;
//  String dispatchJobID;
//  String dispatchID;
//  String dispatchResponseID;
//  String dispatchAuthorizationNumber;
//  int dispatchPriorityLevel;
//  String dispatchPriorityLevelName;
//  String dispatchMemberNumber;
//  int bodyShop;
//  String bodyShopName;
//  String bodyShopAtShopDate;
//  String bodyShopPendingDate;
//  String bodyShopWorkingDate;
//  String bodyShopTotaledDate;
//  String bodyShopMovedDate;
//  String bodyShopDriverTransferDate;
//  String bodyShopDriverRepairDate;
//  String bodyShopPaymentDate;
//  String bodyShopDriverTransferAmount;
//  String bodyShopDriverRepairAmount;
//  String bodyShopPaymentAmount;
//  //<storageMvrRawData;base64Binary</storageMvrRawData;
//  //<storageMvrXMLRawData;base64Binary</storageMvrXMLRawData;
//  String storageMvrRawData_string;
//  String storageMvrXMLRawData_string;
//  int vehicleOdometer;
//  String storageInventoryDate;
//  String storageInventoryTime;
//  String lawContactName;
//  String lawDate;
//  String lawTime;
//  String lawCaseNumber;
//  String auctionReturnDate;
//  String auctionReturnTime;
//  String searchYearMakeModelName;
//  String towedSubTotal;
//  String towedDiscountTotal;
//  String towedTaxAmount;
//  String towedTotalAmount;
//  String towedPaidAmount;
//  String towedBalance;
//  String towedCommissionTotal;
//  String towedTaxableTotal;
//  String releaseAmount;
//  String releaseChangeDue;
//  int releaseTowedVehicle;
//  int dispatchETAMaximum;
//  String dispatchProviderResponse;
//  int dispatchProviderSelectedResponse;
//  String dispatchProviderSelectedResponseName;
//  String dispatchRequestorResponse;
//  int systemMotorClub;
//  String providerContactName;
//  String providerContactPhone;
//  String contractorId;
//  String locationId;
//  String clientId;
//  bool keys;
//  String keyTag;
//  bool junk;
//  bool repairable;
//  bool ownerRelease;
//  bool onHold;
//  String tarpDate;
//  String tarpTime;
//  int timeZone;
//  String timeZoneName;
//  String count;
//  String color;


  int count;
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
  String towedStatus;
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

  Call({
//    this.id,
//    this.pinNumber,
//    this.VIN,
//    this.licensePlate,
//    this.topColor,
//    this.topColorName,
//    this.secondColor,
//    this.secondColorName,
//    this.vehicleMake,
//    this.vehicleMakeName,
//    this.vehicleYearMakeModel,
//    this.vehicleYearMakeModelName,
//    this.vehicleStyle,
//    this.vehicleStyleName,
//    this.vehicleYear,
//    this.vehicleLicenseType,
//    this.vehicleLicenseTypeName,
//    this.vehicleLicenseYear,
//    this.vehicleLicenseState,
//    this.vehicleLicenseStateName,
//    this.vehicleTitle,
//    this.towType,
//    this.towTypeName,
//    this.towCustomer,
//    this.towCustomerName,
//    this.towBillTo,
//    this.towBillToName,
//    this.towReason,
//    this.towReasonName,
//    this.towReasonExportCode,
//    this.towJurisdiction,
//    this.towJurisdictionName,
//    this.towAuthorization,
//    this.towAuthorizationName,
//    this.towAuthorizationStreet,
//    this.towAuthorizationStreetTwo,
//    this.towAuthorizationCity,
//    this.towAuthorizationCityName,
//    this.towAuthorizationState,
//    this.towAuthorizationStateName,
//    this.towAuthorizationZipCode,
//    this.towAuthorizationContact,
//    this.towAuthorizationPhone,
//    this.towedStreet,
//    this.towedStreetTwo,
//    this.towedCity,
//    this.towedCityName,
//    this.towedState,
//    this.towedStateName,
//    this.towedZipCode,
//    this.towedDate,
//    this.towedTime,
//    this.towTruckNumber,
//    this.towTruckMedallion,
//    this.towTruck,
//    this.towTruckName,
//    this.towTruckLicensePlate,
//    this.towTruckLicenseState,
//    this.towTruckLicenseStateName,
//    this.wreckerDriverLicense,
//    this.wreckerDriver,
//    this.wreckerDriverName,
//    this.wreckerDriverPayment,
//    this.wreckerDriverPaid,
//    this.wreckerDriverPhone,
//    this.wreckerDriverStateLicense,
//    this.wreckerDriverCityLicense,
//    this.wreckerDriverSMSType,
//    this.wreckerCompany,
//    this.wreckerCompanyName,
//    this.wreckerCompanyStateLicense,
//    this.wreckerCompanyCityLicense,
//    this.payStatus,
//    this.payStatusName,
//    this.TVRMSRefNumber,
//    this.stockNumber,
//    this.storageStatus,
//    this.storageStatusName,
//    this.storageCompanyLicenseState,
//    this.storageCompany,
//    this.storageCompanyName,
//    this.storageReceivedDate,
//    this.storageReceivedTime,
//    this.storageReleaseDate,
//    this.storageReleaseTime,
//    this.storageReleaseToName,
//    this.storageReleaseToStreet,
//    this.storageReleaseToStreetTwo,
//    this.storageReleaseToCity,
//    this.storageReleaseToCityName,
//    this.storageReleaseToState,
//    this.storageReleaseToStateName,
//    this.storageReleaseToZipCode,
//    this.storageReleaseToPhone,
//    this.storageReleaseIDType,
//    this.storageReleaseIDTypeName,
//    this.storageReleaseIDNumber,
//    this.storageReleaseOwnerType,
//    this.storageReleaseOwnerTypeName,
//    this.storageReleaseOwnership,
//    this.storageReleaseOwnershipName,
//    this.storageMvrDate,
//    this.storageMvrTime,
//    this.storageMvrUUID,
//    this.storageMvrAutoData,
//    this.storageLienRefNumber,
//    this.storageLienHolder,
//    this.storageLienHolderName,
//    this.storageMunicipal,
//    this.storageMunicipalName,
//    this.noCharge,
//    this. systemRuntimeType,
//    this.systemRuntimeTypeName,
//    this.QBReference,
//    this.towedStatus,
//    this.towedStatusName,
//    this.towedBonus,
//    this.towedPONumber,
//    this.towedInvoice,
//    this.towedRONumber,
//    this.towedToStreet,
//    this.towedToStreetTwo,
//    this.towedToCityName,
//    this.towedToCity,
//    this.towedToStateName,
//    this.towedToState,
//    this.towedToZipCode,
//    this.towedTrailerNumber,
//    this.towedTruckNumber,
//    this.towedNoCommission,
//    this.towedDiscountRate,
//    this.towedDiscountAmount,
//    this.dispatchStatus,
//    this.dispatchStatusName,
//    this.dispatchSortStatus,
//    this.dispatchDate,
//    this.dispatchReceivedTime,
//    this.dispatchDispatchTime,
//    this.dispatchEnrouteTime,
//    this.dispatchOnsiteTime,
//    this.dispatchRollingTime,
//    this.dispatchArrivedTime,
//    this.dispatchClearedTime,
//    this.dispatchETAMinutes,
//    this.dispatchAlarmConfirm,
//    this.dispatchCancel,
//    this.dispatchLimitMiles,
//    this.dispatchLimitAmount,
//    this.dispatchContact,
//    this.dispatchContactPhone,
//    //<dispatchInstructions,base64Binary</dispatchInstructions,
//    this.dispatchInstructions_string,
//    this.dispatchJobID,
//    this.dispatchID,
//    this.dispatchResponseID,
//    this.dispatchAuthorizationNumber,
//    this.dispatchPriorityLevel,
//    this.dispatchPriorityLevelName,
//    this.dispatchMemberNumber,
//    this.bodyShop,
//    this.bodyShopName,
//    this.bodyShopAtShopDate,
//    this.bodyShopPendingDate,
//    this.bodyShopWorkingDate,
//    this.bodyShopTotaledDate,
//    this.bodyShopMovedDate,
//    this.bodyShopDriverTransferDate,
//    this.bodyShopDriverRepairDate,
//    this.bodyShopPaymentDate,
//    this.bodyShopDriverTransferAmount,
//    this.bodyShopDriverRepairAmount,
//    this.bodyShopPaymentAmount,
//    //<storageMvrRawData,base64Binary</storageMvrRawData,
//    //<storageMvrXMLRawData,base64Binary</storageMvrXMLRawData,
//    this.storageMvrRawData_string,
//    this.storageMvrXMLRawData_string,
//    this.vehicleOdometer,
//    this.storageInventoryDate,
//    this.storageInventoryTime,
//    this.lawContactName,
//    this.lawDate,
//    this.lawTime,
//    this.lawCaseNumber,
//    this.auctionReturnDate,
//    this.auctionReturnTime,
//    this.searchYearMakeModelName,
//    this.towedSubTotal,
//    this.towedDiscountTotal,
//    this.towedTaxAmount,
//    this.towedTotalAmount,
//    this.towedPaidAmount,
//    this.towedBalance,
//    this.towedCommissionTotal,
//    this.towedTaxableTotal,
//    this.releaseAmount,
//    this.releaseChangeDue,
//    this.releaseTowedVehicle,
//    this.dispatchETAMaximum,
//    this.dispatchProviderResponse,
//    this.dispatchProviderSelectedResponse,
//    this.dispatchProviderSelectedResponseName,
//    this.dispatchRequestorResponse,
//    this.systemMotorClub,
//    this.providerContactName,
//    this.providerContactPhone,
//    this.contractorId,
//    this.locationId,
//    this.clientId,
//    this.keys,
//    this.keyTag,
//    this.junk,
//    this.repairable,
//    this.ownerRelease,
//    this.onHold,
//    this.tarpDate,
//    this.tarpTime,
//    this.timeZone,
//    this.timeZoneName,
//    this.count,
//    this.color,


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
  });

  factory Call.fromJson(Map<String, dynamic> json) =>
      _towedVehicleCallsFromJson(json);

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
      towedStatus: parsedJson["towedStatus"] != null
          ? parsedJson["towedStatus"]
          : "",
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
      wreckerCompany: parsedJson["wreckerCompany"] != "0" ? int.parse(
          parsedJson["wreckerCompany"]) : 0,
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