import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vin_decoder/vin_decoder.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:vts_mobile_cloud/screens/calls_overview_screen.dart';
import 'package:vts_mobile_cloud/screens/success_screen.dart';
import 'package:vts_mobile_cloud/widgets/tow_customers_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_trucks_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_type_modal.dart';
import 'package:vts_mobile_cloud/widgets/vehicleYearMakeModel_modal.dart';
import 'package:vts_mobile_cloud/widgets/vehicle_make_modal.dart';
import 'package:vts_mobile_cloud/widgets/vehicle_style_modal.dart';
import 'package:vts_mobile_cloud/widgets/color_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_reason_modal.dart';
import 'package:vts_mobile_cloud/widgets/authorization_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_jurisdiction_modal.dart';
import 'package:vts_mobile_cloud/providers/relationTowCustomer_provider.dart';
import 'package:vts_mobile_cloud/widgets/wrecker_company_modal.dart';
import 'package:vts_mobile_cloud/widgets/wrecker_driver_modal.dart';
import 'package:vts_mobile_cloud/widgets/system_city_modal.dart';
import 'package:vts_mobile_cloud/widgets/system_state_modal.dart';
import 'package:vts_mobile_cloud/providers/calls_provider.dart';
import 'package:vts_mobile_cloud/providers/user_provider.dart';
import 'package:vts_mobile_cloud/providers/processTowedVehicle_provider.dart';
import 'package:vts_mobile_cloud/providers/storage_company_provider.dart';
import 'package:vts_mobile_cloud/widgets/duplicate_call.dart';
import 'dart:async';
import '../models/call.dart';

class CallAdd extends StatefulWidget {
  CallAdd() : super();
//  method()=>createState().save2();

  @override
  CallAddState createState() => CallAddState();
}

class CallAddState extends State<CallAdd> {
//  final _formKey = GlobalKey<FormState>();
  List<GlobalKey<FormState>> _formKey = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = true;
  bool enableCity1 = false;

  DateTime _date = DateTime.now();
  final _call = Call();

  var _index = 0;
  var _towCustomerController = new TextEditingController();
  var _modelController = new TextEditingController();
  var _yearController = new TextEditingController();
  var _makeController = new TextEditingController();
  var _styleController = new TextEditingController();
  var _topColorController = new TextEditingController();
  var _secondColorController = new TextEditingController();
  var _licenseStateController = new TextEditingController();
  var _towTypeController = new TextEditingController();
  var _towReasonController = new TextEditingController();
  var _authorizationController = new TextEditingController();
  var _jurisdictionController = new TextEditingController();
  var _towedStateController = new TextEditingController();
  var _companyController = new TextEditingController();
  var _driverController = new TextEditingController();
  var _truckController = new TextEditingController();
  var _billToController = new TextEditingController();
  var _vinController = new TextEditingController();
  var _towedStreetController = new TextEditingController();
  var _towedCityController = new TextEditingController();
  var _towedToStreetController = new TextEditingController();
  var _towedToCityController = new TextEditingController();
  var _towedToStateController = new TextEditingController();
  var _licensePlateController = new TextEditingController();
  var _towedZipCodeController = new TextEditingController();
  var _towedStatusController = new TextEditingController();
  var _dispatchDateController = new TextEditingController();
  var _dispatchReceivedTimeController = new TextEditingController();
  var _towedDateController = new TextEditingController();
  var _towedTimeController = new TextEditingController();
  var _towedInvoiceController = new TextEditingController();

//  void _reset() {
//    setState(() {
//      _formKey.currentState.reset();
//    });
//  }

  _getTowCustomerDefaults(id) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM-dd-yyyy').format(now);
    String formattedTime = DateFormat('kk.mm').format(now);
    String formattedTime2 = DateFormat('kk^mm').format(now);
    String currentYear = now.year.toString();

    //Initial Defaults
    setStyle(1, "Other");
    setLicenseState(43, "TX", "TX");

    _dispatchDateController.text = DateFormat('MM-dd-yyyy').format(_date);
    _dispatchReceivedTimeController.text = DateFormat('kk:mm').format(_date);
    _towedDateController.text = DateFormat('MM-dd-yyyy').format(_date);
    _towedTimeController.text = DateFormat('kk:mm').format(_date);

    await Provider.of<TowCustomersVM>(context, listen:false).getDefaults(id);
    var dd = Provider.of<TowCustomersVM>(context, listen:false).defaultsData;
    var ud = Provider.of<UsersVM>(context, listen:false).userData;
    setTowedInvoice(ud[0].storageCompany);

    setState(() {
      _call.dispatchDate = _dispatchDateController.text;
      _call.dispatchReceivedTime = _dispatchReceivedTimeController.text;
      _call.towedDate = _towedDateController.text;
      _call.towedTime = _towedTimeController.text;
      _call.towBillTo = dd[0].towCustomer;
      _call.towBillToName = dd[0].towCustomerName;
      _billToController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.towBillToName)).value;
      _call.dispatchInstructions =  dd[0].instructions != null ? dd[0].instructions : '';
      _call.dispatchInstructions_string = dd[0].instructions_string != null ? dd[0].instructions_string : '';
      _call.dispatchContact = dd[0].contact != null ? dd[0].contact : '';
      _call.dispatchContactPhone = dd[0].billingMainPhone != null ? dd[0].billingMainPhone : '';
      _call.towAuthorization = dd[0].towAuthorization != 0 ? dd[0].towAuthorization : 0;
      _call.towAuthorizationName =dd[0].towAuthorizationName != null ? dd[0].towAuthorizationName : '';
      _authorizationController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.towAuthorizationName)).value;
      _call.towType = dd[0].towType != 0 ? dd[0].towType : 0;
      _call.towTypeName = dd[0].towTypeName != null ? dd[0].towTypeName : '';
      _towTypeController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.towTypeName)).value;
      _call.towJurisdiction = dd[0].towJurisdiction != 0 ? dd[0].towJurisdiction : 0;
      _call.towJurisdictionName =dd[0].towJurisdictionName != null ? dd[0].towJurisdictionName : '';
      _jurisdictionController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.towJurisdictionName)).value;
      _call.towReason = dd[0].towReason != 0 ? dd[0].towReason : 0;
      _call.towReasonName = dd[0].towReasonName != null ? dd[0].towReasonName : '';
      _towReasonController.value = new TextEditingController.fromValue( new TextEditingValue(text: _call.towReasonName)).value;
      _call.storageMunicipal = dd[0].storageMunicipal != 0 ? dd[0].storageMunicipal : 0;
      _call.storageMunicipalName = dd[0].storageMunicipalName != null ? dd[0].storageMunicipalName : '';
      _call.PORequired = dd[0].PORequired != null ? dd[0].PORequired : '';
      _call.invoiceRequired = dd[0].invoiceRequired != null ? dd[0].invoiceRequired : '';
      _call.towedCity = ud[0].storageCompanyCity != 0 ? ud[0].storageCompanyCity : 0;
      _call.towedCityName = ud[0].storageCompanyCityName != null ? ud[0].storageCompanyCityName : '';
      _call.towedState = ud[0].storageCompanyState != 0 ? ud[0].storageCompanyState : 0;
      _call.towedStateName = ud[0].storageCompanyStateName != null ? ud[0].storageCompanyStateName: '';
      _call.storageCompany = dd[0].storageCompany != 0 ? dd[0].storageCompany : 0;
      _call.storageCompanyName = dd[0].storageCompanyName != null ? dd[0].storageCompanyName : '';
      _call.towedDiscountRate = dd[0].discountPercent != null ? dd[0].discountPercent : '';
      _call.towedDiscountAmount = dd[0].discountRate != null ? dd[0].discountRate : '';
      _call.vehicleMake = dd[0].vehicleMake != 0 ? dd[0].vehicleMake : 0;
      _call.vehicleMakeName = dd[0].vehicleMakeName != null ? dd[0].vehicleMakeName : '';
      _makeController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.vehicleMakeName)).value;
      _call.vehicleYearMakeModel =dd[0].vehicleYearMakeModel != 0 ? dd[0].vehicleYearMakeModel : 0;
      _call.vehicleYearMakeModelName = dd[0].vehicleYearMakeModelName != null ? dd[0].vehicleYearMakeModelName: '';
      _modelController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.vehicleYearMakeModelName)).value;
      _call.vehicleYear = dd[0].vehicleYear != "0" ? dd[0].vehicleYear : int.parse(currentYear);
      _yearController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.vehicleYear.toString())).value;

      if (dd[0].vehicleColor != 0) {
        _call.topColor = dd[0].vehicleColor;
        _call.topColorName = dd[0].vehicleColorName;
        _topColorController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.topColorName)).value;
        _call.secondColor = dd[0].vehicleColor;
        _call.secondColorName = dd[0].vehicleColorName;
        _secondColorController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.secondColorName)).value;
      }
      if (_convertTobool(dd[0].defaultFromAddress) == true){
        _call.towedStreet = dd[0].businessStreet;
        _towedStreetController.value = new TextEditingController.fromValue( new TextEditingValue(text: _call.towedStreet)).value;
        _call.towedStreetTwo = dd[0].businessStreetTwo;
        _call.towedCity = dd[0].businessCity;
        _call.towedState = dd[0].businessState;
        _call.towedZipCode = dd[0].businessZipCode;
        _towedZipCodeController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.towedZipCode)).value;
        _call.towedCityName = dd[0].businessCityName;
        _towedCityController.value = new TextEditingController.fromValue( new TextEditingValue(text: _call.towedCityName)).value;
        _call.towedStateName = dd[0].businessStateName;
        _towedStateController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.towedStateName)).value;
      }

      if (dd[0].defaultToAddress == true) {
        _call.towedToStreet = dd[0].businessStreet;
        _towedToStreetController.value = new TextEditingController.fromValue( new TextEditingValue(text: _call.towedToStreet)).value;

        _call.towedToStreetTwo = Provider.of<TowCustomersVM>(context, listen:false).defaultsData[0].businessStreetTwo;
        _call.towedToCity = dd[0].businessCity;
        _call.towedToState = dd[0].businessState;
        _call.towedToZipCode = dd[0].businessZipCode;
        _call.towedToCityName =  dd[0].businessCityName;
        _towedToCityController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.towedToCityName)).value;
        _call.towedToStateName = dd[0].businessStateName;
        _towedToStateController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.towedToStateName)).value;
      }

      if (dd[0].towedToStreet != null) {
        _call.towedToStreet = dd[0].towedToStreet;
        _towedToStreetController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.towedToStreet)).value;
        _call.towedToStreetTwo = dd[0].towedToStreetTwo;
        _call.towedToCity = dd[0].towedToCity;
        _call.towedToState = dd[0].towedToState;
        _call.towedToZipCode = dd[0].towedToZipCode;
        _call.towedToCityName = dd[0].towedToCityName;
        _towedToCityController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.towedToCityName)).value;
        _call.towedToStateName = dd[0].towedToStateName;
        _towedToStateController.value = new TextEditingController.fromValue( new TextEditingValue(text: _call.towedToStateName)).value;
      }


      if (_convertTobool(dd[0].defaultVIN) == true){
        _call.VIN = 'NOVIN';
        _vinController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.VIN)).value;
      }

      if (_convertTobool(dd[0].defaultPlate) == true){
        _call.licensePlate = 'TXPLATE';
        _licensePlateController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.licensePlate)).value;

      }
    });
    _formKey[0].currentState.validate();

    //_formKey.currentState.validate();
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

  _getVIN() async {
//
//    Drew’s 2016 Ford Explorer Vin# 1FM5K8HT6GGB61575, Plate# KPV2891
//
//    Drew’s 2012 Ford F150 FX4 Vin# 1FTFX1E7CFC83006, Plate# VTS
//
//    Nigel’s 2013 Porsche Boxster S Vin# WP0CB2A84DS132907 Plate# NJP01
    var vin = VIN(number: 'JS1VX51L7X2175460');

    print('WMI: ${vin.wmi}');
    print('VDS: ${vin.vds}');
    print('VIS: ${vin.vis}');

    print("Model year is " + vin.modelYear());
    print("Serial number is " + vin.serialNumber());
    print("Assembly plant is " + vin.assemblyPlant());
    //   print("Manufacturer is " + vin.getManufacturer());
    print("Year is " + vin.getYear().toString());
    print("Region is " + vin.getRegion());
    print("VIN string is " + vin.toString());

    var make = await vin.getMakeAsync();
    print("Make is ${make}");

    var model = await vin.getModelAsync();
    print("Model is ${model}");

    var type = await vin.getVehicleTypeAsync();
    print("Type is ${type}");
  }
  setDispatchDateAndTime(date, time){

  }
  setTowedDateAndTime(date, time){

  }
  setTowCustomer(id, name) {
    setState(() {
      _call.towCustomer = id;
      _call.towCustomerName = name;
      _towCustomerController.value =new TextEditingController.fromValue(new TextEditingValue(text: name)).value;
    });
    _getTowCustomerDefaults(id);
  }

//  setTowedStatus(id, name) {
//    setState(() {
//      _call.towedStatus = id;
//      _call.towedStatusName = name;
//      _towedStatusController.value =
//          new TextEditingController.fromValue(new TextEditingValue(text: name))
//              .value;
//    });
//   //_formKey.currentState.validate();
//  }

  setModel(id, name) {
    setState(() {
      _call.vehicleYearMakeModel = id;
      _call.vehicleYearMakeModelName = name;
      _modelController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name)).value;

    });
    _formKey[0].currentState.validate();
  }

  setVehicleYear(year) {
    setState(() {
      _call.vehicleYear = year;
      _yearController.value = new TextEditingController.fromValue(new TextEditingValue(text: year.toString())).value;
    });
    _formKey[0].currentState.validate();
  }

  setMake(id, name) {
    setState(() {
      _call.vehicleMake = id;
      _call.vehicleMakeName = name;
      _makeController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name)).value;

    });
    _formKey[0].currentState.validate();
  }

  setStyle(id, name) {
    setState(() {
      _call.vehicleStyle = id;
      _call.vehicleStyleName = name;
      _styleController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name)).value;

    });
    _formKey[0].currentState.validate();
  }

  setTopColor(id, name) {
    setState(() {
      _call.topColor = id;
      _call.topColorName = name;
      _topColorController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
    _formKey[0].currentState.validate();
    setSecondColor(id, name);
  }

  setSecondColor(id, name) {
    setState(() {
      _call.secondColor = id;
      _call.secondColorName = name;
      _secondColorController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
    _formKey[0].currentState.validate();
  }

  setLicenseState(id, name, shortName) {
    setState(() {
      _call.vehicleLicenseState = id;
      _call.vehicleLicenseStateName = name;
      _licenseStateController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
    _formKey[0].currentState.validate();
  }

  setTowType(suggestion) {
    //Default
    setState(() {
      _call.towType = suggestion.towType != null && suggestion.towType != 'null' ? suggestion.towType : 0;
      _call.towTypeName = suggestion.towTypeName != null && suggestion.towTypeName != 'null' ? suggestion.towTypeName : '';
      _call.towAuthorization = suggestion.towAuthorization != null && suggestion.towAuthorization != 'null' ? suggestion.towAuthorization : 0;
      _call.towAuthorizationName = suggestion.towAuthorizationName != null && suggestion.towAuthorizationName != 'null' ? suggestion.towAuthorizationName : '';
      _call.towJurisdiction = suggestion.towJurisdiction != null && suggestion.towJurisdiction.toString() != 'null' ? suggestion.towJurisdiction : 0;
      _call.towJurisdictionName = suggestion.towJurisdictionName != null && suggestion.towJurisdictionName.toString() != 'null' ? suggestion.towJurisdictionName : '';
      _call.towReason = suggestion.towReason != null && suggestion.towReason.toString() != 'null' ? suggestion.towReason : 0;
      _call.towReasonName = suggestion.towReasonName != null && suggestion.towReasonName.toString() != 'null' ? suggestion.towReasonName : '';
      _towTypeController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: suggestion.towTypeName))
              .value;

      _authorizationController.value =
          new TextEditingController.fromValue(new TextEditingValue(text:suggestion.towAuthorizationName))
              .value;

      _jurisdictionController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: suggestion.towJurisdictionName))
              .value;
      _towReasonController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: suggestion.towReasonName))
              .value;
    });
    _formKey[1].currentState.validate();
  }

  setTowReason(id, name) {
    setState(() {
      _call.towReason = id;
      _call.towReasonName = name;
      _towReasonController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setAuthorization(id, name) {
    setState(() {
      _call.towAuthorization = id;
      _call.towAuthorizationName = name;
      _authorizationController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setJurisdiction(id, name) {
    setState(() {
      _call.towJurisdiction = id;
      _call.towJurisdictionName = name;
      _jurisdictionController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
    _formKey[1].currentState.validate();
  }

  enableCity(){
    var a = _call.towedState.toString();
    print(a);
    if(_call.towedState.toString() == 'null' || _call.towedState.toString() == '')
      return false;
          else
    return true;
  }

  setCity(id, name) {
    setState(() {
      _call.towedCity = id;
      _call.towedCityName = name;
      _towedCityController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
   //_formKey.currentState.validate();
  }

  setTowedState(id, name, shortName) {
    setState(() {
      _call.towedState = id;
      _call.towedStateName = name;
      _towedStateController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: shortName))
              .value;
    });
   //_formKey.currentState.validate();
  }

  setCompany(id, name) {
    setState(() {
      _call.wreckerCompany = id;
      _call.wreckerCompanyName = name;
      _companyController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
    _formKey[1].currentState.validate();
  }

  setDriver(suggestion) {
    setState(() {
      _call.wreckerDriver = suggestion.wreckerDriver;
      _call.wreckerDriverName = suggestion.wreckerDriverName;
      _driverController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: suggestion.wreckerDriverName))
              .value;
      setTruck(suggestion.towTruck, suggestion.towTruckName);
    });
   //_formKey.currentState.validate();
  }

  setTruck(id, name) {
    setState(() {
      _call.towTruck = id;
      _call.towTruckName = name;
      _truckController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
   //_formKey.currentState.validate();
  }

  setBillTo(id, name) {
    setState(() {
      _call.billTo = id;
      _call.billToName = name;
      _billToController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
   //_formKey.currentState.validate();
  }

  setYearMakeModelName(yearMakeModelObj) {
    setMake(yearMakeModelObj.vehicleMake, yearMakeModelObj.vehicleMakeName);
    setVehicleYear(yearMakeModelObj.vehicleYear);
    setModel(yearMakeModelObj.id, yearMakeModelObj.vehicleModelName);
  }

  setTowedInvoice(storageCompanyId) async {
    await Provider.of<StorageCompaniesVM>(context, listen:false).get(storageCompanyId);

    setState(() {
      var towedInvoice = _call.towedInvoice =Provider.of<StorageCompaniesVM>(context, listen:false).sc["towedInvoice"];
      var newTowedInvoice = int.parse(towedInvoice) + 1;
      _towedInvoiceController.value = new TextEditingController.fromValue( new TextEditingValue(text: newTowedInvoice.toString())).value;
    });
   //_formKey.currentState.validate();
  }
  _navigate(context){
//    Navigator.push(context, TestWidget());
   Navigator.of(context).push(MaterialPageRoute(builder:(context) =>CallAdd() ));
  }
  _showDialog(BuildContext context) {
    Scaffold.of(context).showSnackBar(
    new SnackBar(
        backgroundColor: Colors.lightGreen,
        content: Text('Checking for Duplicates',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500
            ))));
  }

  _showErrorMessage(BuildContext context, errorMessage) {
    Scaffold.of(context).showSnackBar(
        new SnackBar(
    backgroundColor: Colors.lightGreen,
    content: Text(errorMessage,
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500
    ))));
  }

  save2() async{
    await Provider.of<Calls>(context, listen: false).create(_call);
    var response = Provider
        .of<Calls>(context, listen: false)
        .createResponse;
    if (response["errorStatus"] == "false") {
      _showErrorMessage(context, response["errorMessage"]);
    }
    else {
//      Navigator.pop(context);
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new SuccessScreen("Call Successfully Added!")
          ));

      Timer(Duration(milliseconds: 3000), () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                new CallsScreen()));
      });
    }
  }

  save() async {
    _showDialog(context);
    await Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
        .checkForDuplicateTickets(_call);

    if (Provider
        .of<ProcessTowedVehiclesVM>(context, listen: false)
        .duplicateData["errorStatus"] == "true") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DuplicateCall(save2: save2);
          });
      //Add Yes or No Button and Rock it
    }
    else {
      await Provider.of<Calls>(context, listen: false).create(_call);
      var response = Provider
          .of<Calls>(context, listen: false)
          .createResponse;
      if (response["errorStatus"] == "false") {
        _showErrorMessage(context, response["errorMessage"]);
      }
      else {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                new SuccessScreen("Call Successfully Added!")));

        Timer(Duration(milliseconds: 3000), () {
          Navigator.pop(context);
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new CallsScreen()));
        });
      }
    }
  }

//  save() async {
//    _formKey[0].currentState.save();
//    _formKey[1].currentState.save();
//    _formKey[2].currentState.save();
////    final form_Step1 = _formKey[0].currentState;
////    final form_Step2 = _formKey[1].currentState;
////    final form_Step3 = _formKey[2].currentState;
//    if (_formKey[2].currentState.validate()) {
////      form_Step1.save();
////      form_Step2.save();
////      form_Step3.save();
//      _showDialog(context);
//      await Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
//          .checkForDuplicateTickets(_call);
//      if (Provider
//          .of<ProcessTowedVehiclesVM>(context, listen: false)
//          .duplicateData["errorStatus"] == "true") {
//        showDialog(
//            context: context,
//            builder: (BuildContext context) {
//              return DuplicateCall();
//            });
//        //Add Yes or No Button and Rock it
//      }
//      else {
//        await Provider.of<Calls>(context, listen: false).create(_call);
//        var response = Provider
//            .of<Calls>(context, listen: false)
//            .createResponse;
//        if (response["errorStatus"] == "false") {
//          _showErrorMessage(context, response["errorMessage"]);
//        }
//        else {
//          Navigator.push(
//              context,
//              new MaterialPageRoute(
//                  builder: (context) =>
//                  new SuccessScreen()));
//
//         Timer(Duration(milliseconds: 3000), () {
//            Navigator.pop(context);
//            Navigator.push(
//                context,
//                new MaterialPageRoute(
//                    builder: (context) =>
//                    new CallsScreen()));
//          });
//        }
//      }
//    }
//  }

  String validateVIN(String value){
    Pattern pattern = "^[^iIoOqQ'-]{10,17}\$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value != "NOVIN")
      return 'Please enter a valid VIN';
    else
      return null;
  }

  String validateLocation(String value){
    if (value.isEmpty)
      return 'Please enter a Location';
    else
      return null;
  }
  String validateYear(String value){
    if (value.isEmpty)
      return 'Please enter Year';
    else
      return null;
  }
  String validateInvoice(String value){
    if (value.isEmpty)
      return 'Please enter Invoice';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD CALL', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.save),
            tooltip: 'Save',
            onPressed: () => {FocusScope.of(context).requestFocus(new FocusNode()),save()}
          ),
        ],
      ),
      body: Container(
      child:SingleChildScrollView(
        child: Column(
          children: <Widget>[
           Container(
      constraints: BoxConstraints.expand(height: 700),
      child: Theme(
        data: ThemeData(
            canvasColor: Color(0xff1C3764),
            primaryColor: Color(0xff1C3764)
        ),
        child:
      Stepper(
        type: StepperType.horizontal,
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          _index == 1 || _index == 2 ?
              FlatButton(
                  color: Color(0xff1C3764),
                  textColor: Colors.white,
                onPressed: onStepCancel,
                child:const Text('PREVIOUS')
              ) : const Text(''),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: onStepContinue,
                child: _index == 0 || _index == 1 ? const Text('NEXT') : const Text('SAVE'),
              ),

            ],
          );
        },
        steps: [
          Step(
            title: Text("VEHICLE", style:TextStyle(color: _index == 0 ? Colors.green: Color(0xffffffff))),
            content: Form(
                key: _formKey[0],
                autovalidate: _autoValidate,
              child:Column(
              children: <Widget>[
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  title: new TextFormField(
                    readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._towCustomerController,
                      decoration: new InputDecoration(
                        labelText: "Customer *",
                        labelStyle: TextStyle(fontSize:14, fontWeight:FontWeight.w500),
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Customer';
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          _call.towCustomerName = val;
                        });
                        // setState(() =>
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new TowCustomersModal(
                                    setTowCustomer: setTowCustomer)));
                      }),
                ),

                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  title: new TextFormField(
                      textCapitalization: TextCapitalization.characters,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: _vinController,
                    decoration: new InputDecoration(
                      labelText: "VIN *",
                      suffixIcon: IconButton(
                        onPressed: () => _getVIN(), //_controller.clear(),
                        icon: Icon(Icons.autorenew, size:14),
                      ),
                    ),
                  validator: validateVIN,
                    onSaved: (val) => setState(() => _call.VIN = val),
                  ),
                ),

                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._modelController,
                      decoration: new InputDecoration(
                        labelText: "Model *",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Model';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new VehicleYearMakeModelModal(
                                    setYearMakeModelName:
                                    setYearMakeModelName)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._yearController,
                      decoration: new InputDecoration(
                        labelText: "Year *",
                        // suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: validateYear,
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       new MaterialPageRoute(
                      //         //    builder: (context) =>
                      //         //  new TowCustomersModal(setYear: setYear))
                      //       ));
                      // }
                      ),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._makeController,
                      decoration: new InputDecoration(
                        labelText: "Make *",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Make';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new VehicleMakeModal(setMake: setMake)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._styleController,
                      decoration: new InputDecoration(
                        labelText: "Style *",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Style';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new VehicleStyleModal(setStyle: setStyle)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._topColorController,
                      decoration: new InputDecoration(
                        labelText: "Top Color *",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Top Color';
                        }
                      },
                      onTap: () {

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new ColorModal(setColor: setTopColor)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._secondColorController,
                      decoration: new InputDecoration(
                        labelText: "Bottom Color *",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Bottom Color';
                        }
                      },
                      onTap: () {

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new ColorModal(setColor: setSecondColor)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: _licensePlateController,
                    decoration: new InputDecoration(
                      labelText: "License Plate *",
                      suffixIcon: Icon(Icons.clear, size:14),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter License Plate';
                      }
                    },
                    onSaved: (val) => {
                      setState(() => _call.licensePlate = val),
                      },
                  ),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._licenseStateController,
                      decoration: new InputDecoration(
                        labelText: "License State *",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select License State';
                        }
                      },
                      onTap: () {

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new SystemStateModal(
                                    setSystemState: setLicenseState)));
                      }),
                ),
              ])
            ),
          ),
          Step(
              title: Text("TOW", style:TextStyle(color: _index == 1 ? Colors.green: Color(0xffffffff))),
            content: Form(
                key: _formKey[1],
                autovalidate: _autoValidate,
              child:Column(
              children: <Widget>[
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._towTypeController,
                      decoration: new InputDecoration(
                        labelText: "Tow Type *",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Tow Type';
                        }
                      },
                      onTap: () {

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new TowTypeModal(setTowType: setTowType)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._towReasonController,
                      decoration: new InputDecoration(
                        labelText: "Tow Reason",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      onTap: () {

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new TowReasonModal(
                                    setTowReason: setTowReason)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._authorizationController,
                      decoration: new InputDecoration(
                        labelText: "Authorization",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      onTap: () {

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new TowAuthorizationModal(
                                    setAuthorization: setAuthorization)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._jurisdictionController,
                      decoration: new InputDecoration(
                        labelText: "Jurisdiction *",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Jurisdiction';
                        }
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new TowJurisdictionModal(
                                    setJurisdiction: setJurisdiction)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: _dispatchDateController,
                    decoration: new InputDecoration(
                      labelText: "Call Date",
                      suffixIcon: IconButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              //  minTime: DateTime(2018, 3, 5),
                              //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                              //   print('change $date');
                              // },
                              onConfirm: (date) {
                                String formattedDate =DateFormat('MM-dd-yyyy').format(date);
                                _dispatchDateController.text = formattedDate;
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        }, //_controller.clear(),
                        icon: Icon(Icons.date_range, size:14),
                      ),
                    ),
                    onSaved: (val) => setState(() => _call.dispatchDate = val),
                  ),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: _dispatchReceivedTimeController,
                    decoration: new InputDecoration(
                      labelText: "Received",
                      suffixIcon: IconButton(
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              showSecondsColumn: false,
                              showTitleActions: true,
                              onConfirm: (time) {
                                String formattedTime =
                                DateFormat('HH:mm').format(time);
                                _dispatchReceivedTimeController.text = formattedTime;
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        }, //_controller.clear(),
                        icon: Icon(Icons.access_time, size:14),
                      ),
                    ),
                    onSaved: (val) => setState(() => _call.dispatchReceivedTime = val),
                  ),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: _towedDateController,
                    decoration: new InputDecoration(
                      labelText: "Towed Date",
                      suffixIcon: IconButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,

                              onConfirm: (date) {
                                String formattedDate =
                                DateFormat('MM-dd-yyyy').format(date);
                                _towedDateController.text = formattedDate;
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        }, //_controller.clear(),
                        icon: Icon(Icons.date_range, size:14),
                      ),
                    ),
                    onSaved: (val) => setState(() => _call.towedDate = val),
                  ),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: _towedTimeController,
                    decoration: new InputDecoration(
                      labelText: "Towed Time",
                      suffixIcon: IconButton(
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              showSecondsColumn: false,
                              showTitleActions: true,
                              onConfirm: (time) {
                                String formattedTime =
                                DateFormat('HH:mm').format(time);
                                _towedTimeController.text = formattedTime;
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        }, //_controller.clear(),
                        icon: Icon(Icons.access_time, size:14),
                      ),
                    ),
                    onSaved: (val) => setState(() => _call.towedTime = val),
                  ),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: _towedStreetController,
                    decoration: new InputDecoration(
                      labelText: "Location *",
                    ),
                    validator: validateLocation,
                    onSaved: (val) => setState(() => _call.towedStreet = val),
                  ),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._towedStateController,
                      decoration: new InputDecoration(
                        labelText: "State",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new SystemStateModal(
                                    setSystemState: setTowedState)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      enabled:  _call.towedState.toString() == 'null' || _call.towedState.toString() == '' || _call.towedState.toString() == '0'  ? false : true ,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._towedCityController,
                      decoration: new InputDecoration(
                        labelText: "City",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new SystemCityModal(setCity: setCity, stateId:_call.towedState.toString())));
                      }),
                ),

                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: _towedZipCodeController,
                    decoration: new InputDecoration(
                      labelText: "Zip Code",
                    ),
                    onSaved: (val) => setState(() => _call.towedZipCode = val),
                  ),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: _towedToStreetController,
                    decoration: new InputDecoration(
                      labelText: "Destination",
                    ),
                    onSaved: (val) => setState(() => _call.towedToStreet = val),
                  ),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._companyController,
                      decoration: new InputDecoration(
                        labelText: "Company *",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Company';
                        }
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new WreckerCompanyModal(
                                    setCompany: setCompany)));
                      }),
                ),
//                new ListTile(
//                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
//                  dense:true,
//                  title: new TextFormField(
//                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                    controller: _towedStatusController,
//                    decoration: new InputDecoration(
//                      labelText: "Towed Status",
//                    ),
//                  ),
//                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                      readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._driverController,
                      decoration: new InputDecoration(
                        labelText: "Driver",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      onTap: () {

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new WreckerDriverModal(
                                    setDriver: setDriver)));
                      }),
                ),
                new ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                  dense:true,
                  title: new TextFormField(
                          readOnly:true,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: this._truckController,
                      decoration: new InputDecoration(
                        labelText: "Truck",
                        suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                      ),
                      onTap: () {

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new TowTrucksModal(setTruck: setTruck)));
                      }),
                ),
              ])
            )
          ),
          Step(
              title: Text("BILLING", style:TextStyle(color: _index == 2 ? Colors.green: Color(0xffffffff))),
            content: Form(
                key: _formKey[2],
                autovalidate: _autoValidate,
                child:Column(
                    children: <Widget>[
                  new ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                    dense:true,
                    title: new TextFormField(
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        controller: this._billToController,
                        decoration: new InputDecoration(
                          labelText: "Bill To *",
                          suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please select Bill To Customer';
                          }
                        },
                        onTap: () {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new TowCustomersModal(
                                      setTowCustomer: setBillTo)));
                        }),
                  ),
                  new ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
                    dense:true,
//                  leading: Container(
//                    width: 100, // can be whatever value you want
//                    alignment: Alignment.centerLeft,
//                    child: Text("Invoice # *"),
//                  ),
                    //trailing: Icon(Icons.shopping_cart),
                    title: new TextFormField(
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      controller: _towedInvoiceController,
                      decoration: new InputDecoration(
                        labelText: "Invoice # *",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Invoice #';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) => setState(() => _call.towedInvoice = val),
                    ),
                  ),
//                  new ListTile(
//                    contentPadding: EdgeInsets.symmetric(horizontal:  0.0),
//                    dense:true,
//                    title: new TextFormField(
//                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                      decoration: new InputDecoration(
//                        labelText: "PO # *",
//                      ),
//                      validator: (value) {
//                        if (value.isEmpty) {
//                          return 'Please enter PO #';
//                        }
//                      },
//                      onSaved: (val) => setState(() => _call.towedPONumber = val),
//                    ),
//                  ),
                ]))
          ),
        ],
        currentStep: _index,
        onStepTapped: (index) {
          setState(() {
            _index = index;
          });
        },
        onStepCancel: () {
          FocusScope.of(context).requestFocus(new FocusNode());
    if(_index != 0) {
      setState(() {
        _index = _index - 1;
      });
    }
        },
        onStepContinue: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          if(_index != 2){
              setState(() {
                if(_formKey[_index].currentState.validate()) {
                  _formKey[_index].currentState.save();
                _index = _index +1;
                }
                else{
                  _index = _index;
                }
              });
        }
          else{
    if(_formKey[_index].currentState.validate()) {
      _formKey[_index].currentState.save();
      save();
    }
          }
          },
      ),
    )),
//            SizedBox(height: 100)
          ],
        ),
      )),
    );
  }
}
