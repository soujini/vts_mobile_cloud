import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../providers/secureStoreMixin_provider.dart';

class User{
bool errorStatus;
String errorMessage;
int id;
String email;
String userName;
String password;
String name;
String street;
String streetTwo;
int systemCity;
String systemCityName;
int systemState;
String systemStateName;
String zipCode;
String mainPhone;
String mobilePhone;
String stateLicense;
bool activeStatus;
String MVRLogin;
String MVRPassword;
String MVRPasswordDate;
int systemRuntimeType;
String systemRuntimeTypeName;
int systemTheme;
String systemThemeName;
String systemThemeClassName;
//userPicturebase64Binary;
//badgePicturebase64Binary;
String userPictureURL;
String badgePictureURL;
int defaultUserRolesOptions;
String defaultUserRolesOptionsName;
String defaultUserRolesOptionsDivName;
int defaultUserRolesSubOptions;
String defaultUserRolesSubOptionsName;
String defaultUserRolesSubOptionsDivName;
int userRole;
String userRoleName;
String pinNumber;
String companyName;
bool militaryTime;
int storageCompany;
String version;
int storageCompanyCity;
String storageCompanyCityName;
int storageCompanyState;
String storageCompanyStateName;
int sessionTimeOut;
bool muteSoundboolean;
bool enableSound;
String towedStatus;
bool reverseRelease;
bool MVRDetailXML;
bool letterDetailXML;
bool cancelTab;
int timeZone;
String timeZoneName;
bool motorClub;
bool dispatch;
bool storage;
bool quickbooks;
bool dispatchPaging;
bool tomTomTracking;
bool auctionPrepay;
bool biddersAuction;
bool vinFirstboolean;
bool postOfficeboolean;
bool ticketBillingTabView;
bool ticketBillingTabEdit;
bool ticketBillingTabDelete;
bool ticketVehicleTabView;
bool ticketVehicleTabEdit;
bool ticketVehicleTabDelete;
bool ticketTowTabView;
bool ticketTowTabEdit;
bool ticketTowTabDelete;
bool ticketImpoundTabView;
bool ticketImpoundTabEdit;
bool ticketImpoundTabDelete;
bool ticketMVRTabView;
bool ticketMVRTabEdit;
bool ticketMVRTabDelete;
bool ticketLettersTabView;
bool ticketLettersTabEdit;
bool ticketLettersTabDelete;
bool ticketLawTabView;
bool ticketLawTabEdit;
bool ticketLawTabDelete;
bool ticketPaymentsTabView;
bool ticketPaymentsTabEdit;
bool ticketPaymentsTabDelete;
bool ticketCallTabView;
bool ticketCallTabEdit;
bool ticketCallTabDelete;
bool ticketShopTabView;
bool ticketShopTabEdit;
bool ticketShopTabDelete;
bool ticketPhotosTabView;
bool ticketPhotosTabEdit;
bool ticketPhotosTabDelete;
bool ticketNotesTabView;
bool ticketNotesTabEdit;
bool ticketNotesTabDelete;
bool ticketActivityTabView;
bool ticketActivityTabEdit;
bool ticketActivityTabDelete;

User({
this.errorStatus,
this.errorMessage,
this.id,
this.email,
this.userName,
this.password,
this.name,
this.street,
this.streetTwo,
this.systemCity,
this.systemCityName,
this.systemState,
this.systemStateName,
this.zipCode,
this.mainPhone,
this.mobilePhone,
this.stateLicense,
this.activeStatus,
this.MVRLogin,
this.MVRPassword,
this.MVRPasswordDate,
this.systemRuntimeType,
this.systemRuntimeTypeName,
this.systemTheme,
this.systemThemeName,
this.systemThemeClassName,
//userPicturebase64Binary,
//badgePicturebase64Binary,
this.userPictureURL,
this.badgePictureURL,
this.defaultUserRolesOptions,
this.defaultUserRolesOptionsName,
this.defaultUserRolesOptionsDivName,
this.defaultUserRolesSubOptions,
this.defaultUserRolesSubOptionsName,
this.defaultUserRolesSubOptionsDivName,
this.userRole,
this.userRoleName,
this.pinNumber,
this.companyName,
this.militaryTime,
this.storageCompany,
this.version,
this.storageCompanyCity,
this.storageCompanyCityName,
this.storageCompanyState,
this.storageCompanyStateName,
this.sessionTimeOut,
this.muteSoundboolean,
this.enableSound,
this.towedStatus,
this.reverseRelease,
this.MVRDetailXML,
this.letterDetailXML,
this.cancelTab,
this.timeZone,
this.timeZoneName,
this.motorClub,
this.dispatch,
this.storage,
this.quickbooks,
this.dispatchPaging,
this.tomTomTracking,
this.auctionPrepay,
this.biddersAuction,
this.vinFirstboolean,
this.postOfficeboolean,
this.ticketBillingTabView,
this.ticketBillingTabEdit,
this.ticketBillingTabDelete,
this.ticketVehicleTabView,
this.ticketVehicleTabEdit,
this.ticketVehicleTabDelete,
this.ticketTowTabView,
this.ticketTowTabEdit,
this.ticketTowTabDelete,
this.ticketImpoundTabView,
this.ticketImpoundTabEdit,
this.ticketImpoundTabDelete,
this.ticketMVRTabView,
this.ticketMVRTabEdit,
this.ticketMVRTabDelete,
this.ticketLettersTabView,
this.ticketLettersTabEdit,
this.ticketLettersTabDelete,
this.ticketLawTabView,
this.ticketLawTabEdit,
this.ticketLawTabDelete,
this.ticketPaymentsTabView,
this.ticketPaymentsTabEdit,
this.ticketPaymentsTabDelete,
this.ticketCallTabView,
this.ticketCallTabEdit,
this.ticketCallTabDelete,
this.ticketShopTabView,
this.ticketShopTabEdit,
this.ticketShopTabDelete,
this.ticketPhotosTabView,
this.ticketPhotosTabEdit,
this.ticketPhotosTabDelete,
this.ticketNotesTabView,
this.ticketNotesTabEdit,
this.ticketNotesTabDelete,
this.ticketActivityTabView,
this.ticketActivityTabEdit,
this.ticketActivityTabDelete,
});

factory User.fromJson(Map<String, dynamic> json) =>_userFromJson(json);
}

User _userFromJson(Map<String, dynamic> parsedJson) {
  return User(
    errorStatus: _convertTobool(parsedJson['errorStatus']),
    errorMessage: parsedJson['errorMessage'],
    id: (parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
    email: parsedJson['email'],
    userName: parsedJson['userName'],
    password: parsedJson['password'],
    name: parsedJson['name'],
    street: parsedJson['street'],
    streetTwo: parsedJson['streetTwo'],
    systemCity: (parsedJson['systemCity'] != null ? int.parse(parsedJson['systemCity']): 0),
    systemCityName: parsedJson['systemCityName'],
    systemState: (parsedJson['systemState'] != null ? int.parse(parsedJson['systemState']): 0),
    systemStateName: parsedJson['systemStateName'],
    zipCode: parsedJson['zipCode'],
    mainPhone: parsedJson['mainPhone'],
    mobilePhone: parsedJson['mobilePhone'],
    stateLicense: parsedJson['stateLicense'],
    activeStatus: _convertTobool(parsedJson['activeStatus']),
    MVRLogin: parsedJson['MVRLogin'],
    MVRPassword: parsedJson['MVRPassword'],
    MVRPasswordDate: parsedJson['MVRPasswordDate'],
    systemRuntimeType: (parsedJson['systemRuntimeType'] != null ? int.parse(parsedJson['systemRuntimeType']): 0),
    systemRuntimeTypeName: parsedJson['systemRuntimeTypeName'],
//    systemTheme: (parsedJson['id'] != null ? int.parse(parsedJson['id']): 0),
//    systemThemeName: parsedJson['systemThemeName'],
//    systemThemeClassName: parsedJson['systemThemeClassName'],
//userPicturebase64Binary: parsedJson['errorStatus'],
//badgePicturebase64Binary: parsedJson['errorStatus'],
    userPictureURL: parsedJson['userPictureURL'],
    badgePictureURL: parsedJson['badgePictureURL'],
//    defaultUserRolesOptions: (parsedJson['defaultUserRolesOptions'] != null ? int.parse(parsedJson['defaultUserRolesOptions']): 0),
//    defaultUserRolesOptionsName: parsedJson['defaultUserRolesOptionsName'],
//    defaultUserRolesOptionsDivName: parsedJson['defaultUserRolesOptionsDivName'],
//    defaultUserRolesSubOptions:(parsedJson['defaultUserRolesSubOptions'] != null ? int.parse(parsedJson['defaultUserRolesSubOptions']): 0),
//    defaultUserRolesSubOptionsName: parsedJson['defaultUserRolesSubOptionsName'],
//    defaultUserRolesSubOptionsDivName: parsedJson['defaultUserRolesSubOptionsDivName'],
    userRole: (parsedJson['userRole'] != null ? int.parse(parsedJson['userRole']): 0),
    userRoleName: parsedJson['userRoleName'],
    pinNumber: parsedJson['pinNumber'],
    companyName: parsedJson['companyName'],
    militaryTime: _convertTobool(parsedJson['militaryTime']),
    storageCompany:  (parsedJson['storageCompany'] != null ? int.parse(parsedJson['storageCompany']): 0),
    version: parsedJson['version'],
    storageCompanyCity: (parsedJson['storageCompanyCity'] != null ? int.parse(parsedJson['storageCompanyCity']): 0),
    storageCompanyCityName: parsedJson['storageCompanyCityName'],
    storageCompanyState: (parsedJson['storageCompanyState'] != null ? int.parse(parsedJson['storageCompanyState']): 0),
    storageCompanyStateName: parsedJson['storageCompanyStateName'],
    sessionTimeOut:(parsedJson['sessionTimeOut'] != null ? int.parse(parsedJson['sessionTimeOut']): 0),
//    muteSoundboolean: parsedJson['muteSoundboolean'],
//    enableSound: parsedJson['enableSound'],
    towedStatus: parsedJson['towedStatus'],
    reverseRelease: _convertTobool(parsedJson['reverseRelease']),
    MVRDetailXML: _convertTobool(parsedJson['MVRDetailXML']),
    letterDetailXML: _convertTobool(parsedJson['letterDetailXML']),
    cancelTab: _convertTobool(parsedJson['cancelTab']),
    timeZone: (parsedJson['timeZone'] != null ? int.parse(parsedJson['timeZone']): 0),
    timeZoneName: parsedJson['timeZoneName'],
    motorClub: _convertTobool(parsedJson['motorClub']),
    dispatch: _convertTobool(parsedJson['dispatch']),
    storage: _convertTobool(parsedJson['storage']),
    quickbooks: _convertTobool(parsedJson['quickbooks']),
    dispatchPaging: _convertTobool(parsedJson['dispatchPaging']),
    tomTomTracking: _convertTobool(parsedJson['tomTomTracking']),
    auctionPrepay: _convertTobool(parsedJson['auctionPrepay']),
    biddersAuction: _convertTobool(parsedJson['biddersAuction']),
    vinFirstboolean: _convertTobool(parsedJson['vinFirstboolean']),
    postOfficeboolean: _convertTobool(parsedJson['postOfficeboolean']),
    ticketBillingTabView: _convertTobool(parsedJson['ticketBillingTabView']),
    ticketBillingTabEdit: _convertTobool(parsedJson['ticketBillingTabEdit']),
    ticketBillingTabDelete: _convertTobool(parsedJson['ticketBillingTabDelete']),
    ticketVehicleTabView: _convertTobool(parsedJson['ticketVehicleTabView']),
    ticketVehicleTabEdit: _convertTobool(parsedJson['ticketVehicleTabEdit']),
    ticketVehicleTabDelete: _convertTobool(parsedJson['ticketVehicleTabDelete']),
    ticketTowTabView: _convertTobool(parsedJson['ticketTowTabView']),
    ticketTowTabEdit: _convertTobool(parsedJson['ticketTowTabEdit']),
    ticketTowTabDelete: _convertTobool(parsedJson['ticketTowTabDelete']),
    ticketImpoundTabView: _convertTobool(parsedJson['ticketImpoundTabView']),
    ticketImpoundTabEdit: _convertTobool(parsedJson['ticketImpoundTabEdit']),
    ticketImpoundTabDelete: _convertTobool(parsedJson['ticketImpoundTabDelete']),
    ticketMVRTabView: _convertTobool(parsedJson['ticketMVRTabView']),
    ticketMVRTabEdit: _convertTobool(parsedJson['ticketMVRTabEdit']),
    ticketMVRTabDelete: _convertTobool(parsedJson['ticketMVRTabDelete']),
    ticketLettersTabView: _convertTobool(parsedJson['ticketLettersTabView']),
    ticketLettersTabEdit: _convertTobool(parsedJson['ticketLettersTabEdit']),
    ticketLettersTabDelete: _convertTobool(parsedJson['ticketLettersTabDelete']),
    ticketLawTabView: _convertTobool(parsedJson['ticketLawTabView']),
    ticketLawTabEdit: _convertTobool(parsedJson['ticketLawTabEdit']),
    ticketLawTabDelete: _convertTobool(parsedJson['ticketLawTabDelete']),
    ticketPaymentsTabView: _convertTobool(parsedJson['ticketPaymentsTabView']),
    ticketPaymentsTabEdit: _convertTobool(parsedJson['ticketPaymentsTabEdit']),
    ticketPaymentsTabDelete: _convertTobool(parsedJson['ticketPaymentsTabDelete']),
    ticketCallTabView: _convertTobool(parsedJson['ticketCallTabView']),
    ticketCallTabEdit: _convertTobool(parsedJson['ticketCallTabEdit']),
    ticketCallTabDelete: _convertTobool(parsedJson['ticketCallTabDelete']),
    ticketShopTabView: _convertTobool(parsedJson['ticketShopTabView']),
    ticketShopTabEdit: _convertTobool(parsedJson['ticketShopTabEdit']),
    ticketShopTabDelete: _convertTobool(parsedJson['ticketShopTabDelete']),
    ticketPhotosTabView: _convertTobool(parsedJson['ticketPhotosTabView']),
    ticketPhotosTabEdit: _convertTobool(parsedJson['ticketPhotosTabEdit']),
    ticketPhotosTabDelete: _convertTobool(parsedJson['ticketPhotosTabDelete']),
    ticketNotesTabView: _convertTobool(parsedJson['ticketNotesTabView']),
    ticketNotesTabEdit: _convertTobool(parsedJson['ticketNotesTabEdit']),
    ticketNotesTabDelete: _convertTobool(parsedJson['ticketNotesTabDelete']),
    ticketActivityTabView: _convertTobool(parsedJson['ticketActivityTabView']),
    ticketActivityTabEdit: _convertTobool(parsedJson['ticketActivityTabEdit']),
    ticketActivityTabDelete: _convertTobool(parsedJson['ticketActivityTabDelete']),
  );
}
class UsersVM with ChangeNotifier, SecureStoreMixin {
  List<User> _userData = [];
  List<User> tc;

  List<User> get userData {
    return [..._userData]; //gets a copy of the items
  }

  Future validateUser(int uID, String un, String pwd, String pn) async {
    Xml2Json xml2json = new Xml2Json();

    final String appName = "towing";
    final int userId = uID;
    final String username = un;
    final String password = pwd;
    final String pinNumber = pn;


    var envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope "
        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body>"
        "<validateUser  xmlns=\"http://cktsystems.com/\">"
        "<appName>${appName}</appName>"
        "<userId>${userId}</userId>"
        "<userName>${username}</userName>"
        "<password>${password}</password>"
        "<pinNumber>${pinNumber}</pinNumber>"
        "</validateUser>"
        "</soap:Body>"
        "</soap:Envelope>";

    final response = await http.post(
        'http://cktsystems.com/vtscloud/WebServices/userTable.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://cktsystems.com/validateUser",
          "Host": "cktsystems.com"
          //"Accept": "text/xml"
        },
        body: envelope);

    final resBody = xml2json.parse(response.body);
    final jsondata = xml2json.toParker();
    //final data = json.decode(jsondata);
    final data = JsonDecoder().convert(jsondata);

    final extractedData = await data["soap:Envelope"]["soap:Body"]
    ["validateUserResponse"]["validateUserResult"];

    final List<User> dd = [];

    dd.add(new User.fromJson(extractedData));
    final storage = new FlutterSecureStorage();
    _userData = dd;

  //  SecureStoreMixin secureStoreMixin = new SecureStoreMixin();
    setSecureStore("pinNumber",  extractedData["pinNumber"]);
    setSecureStore("timeZoneName",  extractedData["timeZoneName"]);

// Store password
//    await storage.write(key: "username", value: extractedData["userName"]);
//    await storage.write(key: "password", value:extractedData["password"]);
//    await storage.write(key: "customerPIN", value: extractedData["userName"]);

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




//validations
//String zipCode = ko.observable("").extend({
//  required: true,
//  pattern: {
//    message: 'Invalid Zip Code',
//    params: '^[0-9]{5}(-[0-9]{4})?$'
//  }
//});
//String mainPhone = ko.observable("").extend({
//  required: true,
//  pattern: {
//    message: 'Invalid Phone',
//    params: '^\\D?(\\d{3})\\D?\\D?(\\d{3})\\D?(\\d{4})$'
//  }
//});
//String mobilePhone = ko.observable("").extend({
//  pattern: {
//    message: 'Invalid Phone',
//    params: '^\\D?(\\d{3})\\D?\\D?(\\d{3})\\D?(\\d{4})$'
//  }
//});