import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TowCustomer {
  String errorStatus;
  String errorMessage;
  String id;
  String name;
  String shortName;
  String contact;
  String businessStreet;
  String businessStreetTwo;
  String businessCity;
  String businessCityName;
  String businessState;
  String businessStateName;
  String businessZipCode;
  String businessMainPhone;
  String businessFaxPhone;
  String systemRuntimeType;
  String systemRuntimeTypeName;
  String businessCityStateZipName;

  TowCustomer({
    this.errorStatus,
    this.errorMessage,
    @required this.id,
    @required this.name,
    @required this.shortName,
    @required this.contact,
    @required this.businessStreet,
    @required this.businessStreetTwo,
    @required this.businessCity,
    @required this.businessCityName,
    @required this.businessState,
    @required this.businessStateName,
    @required this.businessZipCode,
    @required this.businessMainPhone,
    @required this.businessFaxPhone,
    @required this.systemRuntimeType,
    @required this.systemRuntimeTypeName,
    @required this.businessCityStateZipName,
  });
}

