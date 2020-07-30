class Call_Add {
  int towCustomer;
  String VIN;
  String vehicleModel;
  int vehicleYearMakeModel;
  int vehicleYear;
  int vehicleMake;
  int vehicleStyle;
  int topColor;
  int secondColor;
  String licensePlate;
  int vehicleLicenseState;
  int towType;
  int towReason;
  int towAuthorization;
  int towJurisdiction;
  String dispatchDate;
  String dispatchReceivedTime;
  String towedDate;
  String towedTime;
  String towedStreet;
  int towedCity;
  int towedState;
  String towedZipCode;
  String towedStreetTwo;
  int wreckerCompany;
  String towedStatus;// =>CHECK IN CKT WEB
  int wreckerDriver;
  int towTruck;
  int towBillTo;
  String towedInvoice; ///newTowedInvoice =>Check
  String towedPONumber;

  Map<String, dynamic> toJson() => <String, dynamic>{
"towCustomer":towCustomer,
"VIN":VIN,
    "vehicleYearMakeModel":vehicleYearMakeModel,
"vehicleModel":vehicleModel,
'vehicleYear':vehicleYear,
'vehicleMake':vehicleMake,
"vehicleStyle":vehicleStyle,
"topColor":topColor,
"secondColor":secondColor,
"licensePlate":licensePlate,
  "vehicleLicenseState":vehicleLicenseState,
  "towType":towType,
  "towReason":towReason,
  'towAuthorization':towAuthorization,
  "towJurisdiction":towJurisdiction,
  "dispatchDate":dispatchDate,
  "dispatchReceivedTime":dispatchReceivedTime,
  "towedDate":towedDate,
  "towedTime":towedTime,
  "towedStreet":towedStreet,
  "towedCity":towedCity,
  "towedState":towedState,
  "towedZipCode":towedZipCode,
  "towedStreetTwo":towedStreetTwo,
  "wreckerCompany":wreckerCompany,
  "towedStatus":towedStatus, //=>CHECK IN CKT WEB
  "wreckerDriver":wreckerDriver,
  "towTruck":towTruck,
  "towBillTo":towBillTo,
  'towedInvoice':towedInvoice,//newTowedInvoice =>Check
  "towedPONumber":towedPONumber,
  };
  Call_Add({
    this.towCustomer,
    this.VIN,
    this.vehicleYearMakeModel,
    this.vehicleModel,
    this.vehicleYear,
    this.vehicleMake,
    this.vehicleStyle,
    this.topColor,
    this.secondColor,
    this.licensePlate,
    this.vehicleLicenseState,
    this.towType,
    this.towReason,
    this.towAuthorization,
    this.towJurisdiction,
    this.dispatchDate,
    this.dispatchReceivedTime,
    this.towedDate,
    this.towedTime,
    this.towedStreet,
    this.towedCity,
    this.towedState,
    this.towedZipCode,
    this.towedStreetTwo,
    this.wreckerCompany,
    this.towedStatus, //=>CHECK IN CKT WEB
    this.wreckerDriver,
    this.towTruck,
    this.towBillTo,
    this.towedInvoice, //newTowedInvoice =>Check
    this.towedPONumber,
  });

  factory Call_Add.fromJsonForAdd(Map<String, dynamic> json) =>
      _towedVehicleCallsFromJsonForAdd(json);
}
Call_Add _towedVehicleCallsFromJsonForAdd(Map<String, dynamic> parsedJson) {
  return Call_Add(
    towCustomer: parsedJson['towCustomer'] as int,
    VIN: parsedJson['VIN'] as String,
      vehicleYearMakeModel:parsedJson['vehicleYearMakeModel'] as int,
      vehicleYear:parsedJson['vehicleYear'] as int,
      vehicleMake:parsedJson['vehicleMake'] as int,
      vehicleStyle:parsedJson['vehicleStyle'] as int,
      topColor:parsedJson['topColor'] as int,
      secondColor:parsedJson['secondColor'] as int,
      licensePlate:parsedJson['licensePlate'] as String,
      vehicleLicenseState:parsedJson['vehicleLicenseState'] as int,
      towType:parsedJson['towType'] as int,
      towReason:parsedJson['towReason'] as int,
      towAuthorization:parsedJson['towAuthorization'] as int,
      towJurisdiction:parsedJson['towJurisdiction'] as int,
      dispatchDate:parsedJson['dispatchDate'] as String,
      dispatchReceivedTime:parsedJson['dispatchReceivedTime'] as String,
      towedDate:parsedJson['towedDate'] as String,
      towedTime:parsedJson['towedTime'] as String,
      towedStreet:parsedJson['towedStreet'] as String,
      towedCity:parsedJson['towedCity'] as int,
      towedState:parsedJson['towedState'] as int,
      towedZipCode:parsedJson['towedZipCode'] as String,
      towedStreetTwo:parsedJson['towedStreetTwo'] as String,
      wreckerCompany:parsedJson['wreckerCompany'] as int,
      towedStatus:parsedJson['towedStatus'] as String,// =>CHECK IN CKT WEB
      wreckerDriver:parsedJson['wreckerDriver'] as int,
      towTruck:parsedJson['towTruck'] as int,
      towBillTo:parsedJson['towBillTo'] as int,
      towedInvoice:parsedJson['towedInvoice'] as String,///newTowedInvoice =>Check
      towedPONumber:parsedJson['towedPONumber'] as String
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
