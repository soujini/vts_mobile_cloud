import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vin_decoder/vin_decoder.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
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

import '../models/call.dart';

class CallAdd extends StatefulWidget {
  CallAdd() : super();

  @override
  _CallAddState createState() => _CallAddState();
}

class _CallAddState extends State<CallAdd> {
  @override
//  void initState() {
//    print("IN INIT STATE");
//
////    _getThingsOnStartup().then((value){
////      print('Async done');
////    });
//    super.initState();
//  }
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  final _call = Call();

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
  var _towedDateController = new TextEditingController();
  var _towedTimeController = new TextEditingController();
  var _towedInvoiceController = new TextEditingController();

  void _reset() {
    setState(() {
      _formKey.currentState.reset();
    });

//    for (FormFieldState<dynamic> field in _formKey)
//      field.reset();
  }

  void _setInitalDefaults() async {
    setStyle(1, "Other");
    setLicenseState(43, "TX");
    setTowedStatus(1, "Call");
    _towedDateController.text = DateFormat('MM-dd-yyyy').format(_date);
    _towedTimeController.text = DateFormat('kk:mm').format(_date);

//    print("KIRTI   " +
//        Provider.of<StorageCompaniesVM>(context).sc["towedInvoice"]);
    // print("oli  "+Provider.of<StorageCompaniesVM>(context).storageCompanyData.toString());
  }

  _getTowCustomerDefaults(id) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM-dd-yyyy').format(now);
    String formattedTime = DateFormat('kk.mm').format(now);
    String formattedTime2 = DateFormat('kk^mm').format(now);
    String currentYear = now.year.toString();

    await Provider.of<TowCustomersVM>(context).getDefaults(id);
    var dd = Provider.of<TowCustomersVM>(context).defaultsData;
    var ud = Provider.of<UsersVM>(context).userData;

    setState(() {
      _call.dispatchInstructions =
          dd[0].instructions != null ? dd[0].instructions : '';
      _call.dispatchInstructions_string =
          dd[0].instructions_string != null ? dd[0].instructions_string : '';
      _call.dispatchContact = dd[0].contact != null ? dd[0].contact : '';
      _call.dispatchContactPhone =
          dd[0].billingMainPhone != null ? dd[0].billingMainPhone : '';

      _call.towAuthorization =
          dd[0].towAuthorization != "0" ? dd[0].towAuthorization : '0';
      _call.towAuthorizationName =
          dd[0].towAuthorizationName != null ? dd[0].towAuthorizationName : '';
      _authorizationController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _call.towAuthorizationName))
          .value;

      _call.towType = dd[0].towType != "0" ? dd[0].towType : '0';
      _call.towTypeName = dd[0].towTypeName != null ? dd[0].towTypeName : '';
      _towTypeController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _call.towTypeName))
          .value;

      _call.towJurisdiction =
          dd[0].towJurisdiction != '0' ? dd[0].towJurisdiction : '0';
      _call.towJurisdictionName =
          dd[0].towJurisdictionName != null ? dd[0].towJurisdictionName : '';
      _jurisdictionController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _call.towJurisdictionName))
          .value;

      _call.towReason = dd[0].towReason != '0' ? dd[0].towReason : '0';
      _call.towReasonName =
          dd[0].towReasonName != null ? dd[0].towReasonName : '';
      _towReasonController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _call.towReasonName))
          .value;

      _call.storageMunicipal =
          dd[0].storageMunicipal != '0' ? dd[0].storageMunicipal : '0';
      _call.storageMunicipalName =
          dd[0].storageMunicipalName != null ? dd[0].storageMunicipalName : '';
      _call.PORequired = dd[0].PORequired != null ? dd[0].PORequired : '';
      _call.invoiceRequired =
          dd[0].invoiceRequired != null ? dd[0].invoiceRequired : '';

      _call.towedCity =
          ud[0].storageCompanyCity != '0' ? ud[0].storageCompanyCity : '0';
      _call.towedCityName = ud[0].storageCompanyCityName != null
          ? ud[0].storageCompanyCityName
          : '';
      _call.towedState =
          ud[0].storageCompanyState != '0' ? ud[0].storageCompanyState : '0';
      _call.towedStateName = ud[0].storageCompanyStateName != null
          ? ud[0].storageCompanyStateName
          : '';

      if (dd[0].storageCompany != '0') {
        _call.storageCompany = dd[0].storageCompany;
        _call.storageCompanyName = dd[0].storageCompanyName;
      } else {
        _call.storageCompany = ud[0].storageCompany;
        _call.storageCompanyName = ud[0].companyName;
      }
      _call.towedDiscountRate =
          dd[0].discountPercent != null ? dd[0].discountPercent : '';
      _call.towedDiscountAmount =
          dd[0].discountRate != null ? dd[0].discountRate : '';

      _call.vehicleMake = dd[0].vehicleMake != '0' ? dd[0].vehicleMake : '0';
      _call.vehicleMakeName =
          dd[0].vehicleMakeName != null ? dd[0].vehicleMakeName : '';
      _makeController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _call.vehicleMakeName))
          .value;

      _call.vehicleYearMakeModel =dd[0].vehicleYearMakeModel != '0' ? dd[0].vehicleYearMakeModel : '0';
      _call.vehicleYearMakeModelName = dd[0].vehicleYearMakeModelName != null ? dd[0].vehicleYearMakeModelName: '';
      _modelController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _call.vehicleYearMakeModelName))
          .value;

      _call.vehicleYear = dd[0].vehicleYear == "0" ? int.parse(currentYear): int.parse(dd[0].vehicleYear);
      _yearController.value = new TextEditingController.fromValue(new TextEditingValue(text: _call.vehicleYear.toString())).value;

      if (dd[0].vehicleColor != '0') {
        _call.topColor = dd[0].vehicleColor;
        _call.topColorName = dd[0].vehicleColorName;
        _topColorController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.topColorName))
            .value;

        _call.secondColor = dd[0].vehicleColor == '0' ? dd[0].vehicleColor : '0';
        _call.secondColorName = dd[0].vehicleColorName == null ? dd[0].vehicleColorName : '';
        _secondColorController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.secondColorName))
            .value;
      }
      if (_convertTobool(dd[0].defaultFromAddress) == true){
        _call.towedStreet = dd[0].businessStreet;
        _towedStreetController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towedStreet))
            .value;

        _call.towedStreetTwo = dd[0].businessStreetTwo;
        _call.towedCity = dd[0].businessCity;
        _call.towedState = dd[0].businessState;

        _call.towedZipCode = dd[0].businessZipCode;
        _towedZipCodeController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towedZipCode))
            .value;

        _call.towedCityName = dd[0].businessCityName;
        _towedCityController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towedCityName))
            .value;
        _call.towedStateName = dd[0].businessStateName;
        _towedStateController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towedStateName))
            .value;
      }

      if (dd[0].defaultToAddress == true) {
        _call.towedToStreet = dd[0].businessStreet;
        _towedToStreetController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towedToStreet))
            .value;

        _call.towedToStreetTwo = Provider.of<TowCustomersVM>(context)
            .defaultsData[0]
            .businessStreetTwo;
        _call.towedToCity = dd[0].businessCity;
        _call.towedToState = dd[0].businessState;
        _call.towedToZipCode = dd[0].businessZipCode;
        _call.towedToCityName =  dd[0].businessCityName;
        _towedToCityController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towedToCityName))
            .value;
        _call.towedToStateName = dd[0].businessStateName;
        _towedToStateController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towedToStateName))
            .value;
      }

      if (dd[0].towedToStreet != null) {
        _call.towedToStreet = dd[0].towedToStreet;
        _towedToStreetController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towedToStreet))
            .value;

        _call.towedToStreetTwo = dd[0].towedToStreetTwo;
        _call.towedToCity = dd[0].towedToCity;
        _call.towedToState = dd[0].towedToState;
        _call.towedToZipCode = dd[0].towedToZipCode;
        _call.towedToCityName = dd[0].towedToCityName;
        _towedToCityController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towedToCityName))
            .value;
        _call.towedToStateName = dd[0].towedToStateName;
        _towedToStateController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towedToStateName))
            .value;
      }

      if (dd[0].towBillTo != 0) {
        _call.towBillTo = dd[0].towBillTo;
        _call.towBillToName = dd[0].towBillToName;

        _billToController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.towBillToName))
            .value;
      }
      if (_convertTobool(dd[0].defaultVIN) == true){
        _call.VIN = 'NOVIN';
        _vinController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.VIN))
            .value;
      }

      if (_convertTobool(dd[0].defaultPlate) == true)
        {
        _call.licensePlate = 'TXPLATE';
        _licensePlateController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: _call.licensePlate))
            .value;
      }
    });
    _formKey.currentState.validate();
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

  setTowCustomer(id, name) {
    setState(() {
      _call.towCustomer = id;
      _call.towCustomerName = name;
      _towCustomerController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
    _getTowCustomerDefaults(id);
    _setInitalDefaults();
  }

  setTowedStatus(id, name) {
    setState(() {
      _call.towedStatus = id;
      _call.towedStatusName = name;
      _towedStatusController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setModel(id, name) {
    setState(() {
      _call.vehicleYearMakeModel = id;
      _call.vehicleYearMakeModelName = name;
      _modelController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setVehicleYear(year) {
    setState(() {
      _call.vehicleYear = year;
      _yearController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: year.toString()))
          .value;
    });
  }

  setMake(id, name) {
    setState(() {
      _call.vehicleMake = id;
      _call.vehicleMakeName = name;
      _makeController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setStyle(id, name) {
    setState(() {
      _call.vehicleStyle = id;
      _call.vehicleStyleName = name;
      _styleController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setTopColor(id, name) {
    setState(() {
      _call.topColor = id;
      _call.topColorName = name;
      _topColorController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setSecondColor(id, name) {
    setState(() {
      _call.secondColor = id;
      _call.secondColorName = name;
      _secondColorController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setLicenseState(id, name) {
    setState(() {
      _call.vehicleLicenseState = id;
      _call.vehicleLicenseStateName = name;
      _licenseStateController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setTowType(id, name) {
    setState(() {
      _call.towType = id;
      _call.towTypeName = name;
      _towTypeController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
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
  }

  setCity(id, name) {
    setState(() {
      _call.towedCity = id;
      _call.towedCityName = name;
      _towedCityController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setTowedState(id, name) {
    setState(() {
      _call.towedState = id;
      _call.towedStateName = name;
      _towedStateController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setCompany(id, name) {
    setState(() {
      _call.wreckerCompany = id;
      _call.wreckerCompanyName = name;
      _companyController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
    setTowedInvoice();
  }

  setDriver(id, name) {
    setState(() {
      _call.wreckerDriver = id;
      _call.wreckerDriverName = name;
      _driverController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setTruck(id, name) {
    setState(() {
      _call.towTruck = id;
      _call.towTruckName = name;
      _truckController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setBillTo(id, name) {
    setState(() {
      _call.billTo = id;
      _call.billToName = name;
      _billToController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setYearMakeModelName(yearMakeModelObj) {
    setMake(yearMakeModelObj.vehicleMake, yearMakeModelObj.vehicleMakeName);
    setVehicleYear(yearMakeModelObj.vehicleYear);
    setModel(yearMakeModelObj.id, yearMakeModelObj.vehicleModelName);
  }

  setTowedInvoice() async {
    await Provider.of<StorageCompaniesVM>(context)
        .get(_call.storageCompany.toString());
    setState(() {
      var towedInvoice = _call.towedInvoice =
          Provider.of<StorageCompaniesVM>(context).sc["towedInvoice"];
      var newTowedInvoice = int.parse(towedInvoice) + 1;
      _towedInvoiceController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: newTowedInvoice.toString()))
          .value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('Add Call'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.save),
              tooltip: 'Save',
              onPressed: () => save(),
            ),
          ],
        ),
        body: Form(
            child: SingleChildScrollView(
          key: this._formKey,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    top: 25,
                    right: 15,
                    bottom: 0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    // Align however you like (i.e .centerRight, centerLeft)
                    child: Row(children: <Widget>[
                      new Text("Vehicle Details",
                          style: new TextStyle(
                              color: Colors.black,
                              letterSpacing: 1.0,
                              fontSize: 20.0)),
                    ]),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 10,
                      right: 15,
                      bottom: 25,
                    ),
                    child: new Divider(
                      color: Colors.black54,
                    )),

                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Customer *"),
                  ),
                  title: new TextFormField(
                      controller: this._towCustomerController,
                      decoration: new InputDecoration(
                        hintText: "Customer",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
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
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("VIN *"),
                  ),
//                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                    controller: _vinController,
                    decoration: new InputDecoration(
                      hintText: "VIN",
                      suffixIcon: IconButton(
                        onPressed: () => _getVIN(), //_controller.clear(),
                        icon: Icon(Icons.autorenew),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter VIN';
                      }
                    },
                    onSaved: (val) => setState(() => _call.VIN = val),
                  ),
                ),

                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Model *"),
                  ),
//                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._modelController,
                      decoration: new InputDecoration(
                        hintText: "Model",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
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
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Year *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._yearController,
                      decoration: new InputDecoration(
                        hintText: "Year",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Year';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                //    builder: (context) =>
                                //  new TowCustomersModal(setYear: setYear))
                                ));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Make *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._makeController,
                      decoration: new InputDecoration(
                        hintText: "Make",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
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
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Style *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._styleController,
                      decoration: new InputDecoration(
                        hintText: "Style",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
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
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Top Color *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._topColorController,
                      decoration: new InputDecoration(
                        hintText: "Top Color",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Top Color';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new ColorModal(setColor: setTopColor)));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Bottom Color *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._secondColorController,
                      decoration: new InputDecoration(
                        hintText: "Bottom Color",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Bottom Color';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new ColorModal(setColor: setSecondColor)));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("License Plate *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                    controller: _licensePlateController,
                    decoration: new InputDecoration(
                      hintText: "License Plate",
                      suffixIcon: Icon(Icons.clear),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter License Plate';
                      }
                    },
                  ),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("License State *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._licenseStateController,
                      decoration: new InputDecoration(
                        hintText: "License State",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select License State';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new SystemStateModal(
                                    setSystemState: setLicenseState)));
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    top: 35,
                    right: 15,
                    bottom: 0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    // Align however you like (i.e .centerRight, centerLeft)
                    child: Row(children: <Widget>[
                      new Text("Tow Details",
                          style: new TextStyle(
                              color: Colors.black,
                              letterSpacing: 1.0,
                              fontSize: 20.0)),
                    ]),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 10,
                      right: 15,
                      bottom: 25,
                    ),
                    child: new Divider(
                      color: Colors.black54,
                    )),


                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Tow Type *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._towTypeController,
                      decoration: new InputDecoration(
                        hintText: "Tow Type",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Tow Type';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new TowTypeModal(setTowType: setTowType)));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Tow Reason"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._towReasonController,
                      decoration: new InputDecoration(
                        hintText: "Tow Reason",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new TowReasonModal(
                                    setTowReason: setTowReason)));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Authorization"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._authorizationController,
                      decoration: new InputDecoration(
                        hintText: "Authorization",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new TowAuthorizationModal(
                                    setAuthorization: setAuthorization)));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Jurisdiction *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._jurisdictionController,
                      decoration: new InputDecoration(
                        hintText: "Jurisdiction",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Jurisdiction';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new TowJurisdictionModal(
                                    setJurisdiction: setJurisdiction)));
                      }),
                ),

                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Towed Date"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                    controller: _towedDateController,
                    decoration: new InputDecoration(
                      hintText: "Towed Date",
                      suffixIcon: IconButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              //  minTime: DateTime(2018, 3, 5),
                              //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                              //   print('change $date');
                              // },
                              onConfirm: (date) {
                            String formattedDate =
                                DateFormat('MM-dd-yyyy').format(date);
                            _towedDateController.text = formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        }, //_controller.clear(),
                        icon: Icon(Icons.date_range),
                      ),
                    ),
                    onSaved: (val) => setState(() => _call.towedDate = val),
                  ),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Towed Time"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                    controller: _towedTimeController,
                    decoration: new InputDecoration(
                      hintText: "Towed Time",
                      suffixIcon: IconButton(
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              showTitleActions: true,
                              //  minTime: DateTime(2018, 3, 5),
                              //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                              //   print('change $date');
                              // },
                              onConfirm: (time) {
                            String formattedTime =
                                DateFormat('HH:mm').format(time);
                            _towedTimeController.text = formattedTime;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        }, //_controller.clear(),
                        icon: Icon(Icons.access_time),
                      ),
                    ),
                    onSaved: (val) => setState(() => _call.towedTime = val),
                  ),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Location *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                    controller: _towedStreetController,
                    decoration: new InputDecoration(
                      hintText: "Location",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter location';
                      }
                    },
                    onSaved: (val) => setState(() => _call.towedStreet = val),
                  ),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("City"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._towedCityController,
                      decoration: new InputDecoration(
                        hintText: "City",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new SystemCityModal(setCity: setCity)));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("State"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._towedStateController,
                      decoration: new InputDecoration(
                        hintText: "State",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new SystemStateModal(
                                    setSystemState: setTowedState)));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Zip Code"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                    controller: _towedZipCodeController,
                    decoration: new InputDecoration(
                      hintText: "Zip Code",
                    ),
                    onSaved: (val) => setState(() => _call.towedZipCode = val),
                  ),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Destination"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                    controller: _towedToStreetController,
                    decoration: new InputDecoration(
                      hintText: "Destination",
                    ),
                    onSaved: (val) => setState(() => _call.towedToStreet = val),
                  ),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Company *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._companyController,
                      decoration: new InputDecoration(
                        hintText: "Company",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Company';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new WreckerCompanyModal(
                                    setCompany: setCompany)));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Towed Status"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                    controller: _towedStatusController,
                    decoration: new InputDecoration(
                      hintText: "Towed Status",
                    ),
                  ),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Driver"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._driverController,
                      decoration: new InputDecoration(
                        hintText: "Driver",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new WreckerDriverModal(
                                    setDriver: setDriver)));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Truck"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._truckController,
                      decoration: new InputDecoration(
                        hintText: "Truck",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new TowTrucksModal(setTruck: setTruck)));
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    top: 35,
                    right: 15,
                    bottom: 0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    // Align however you like (i.e .centerRight, centerLeft)
                    child: Row(children: <Widget>[
                      new Text("Billing Details",
                          style: new TextStyle(
                              color: Colors.black,
                              letterSpacing: 1.0,
                              fontSize: 20.0)),
                    ]),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 10,
                      right: 15,
                      bottom: 25,
                    ),
                    child: new Divider(
                      color: Colors.black54,
                    )),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Bill To"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                      controller: this._billToController,
                      decoration: new InputDecoration(
                        hintText: "Bill To",
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Bill To Customer';
                        }
                      },
                      onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new TowCustomersModal(
                                    setTowCustomer: setBillTo)));
                      }),
                ),
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("Invoice # *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                    controller: _towedInvoiceController,
                    decoration: new InputDecoration(
                      hintText: "Invoice #",
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
                new ListTile(
                  leading: Container(
                    width: 100, // can be whatever value you want
                    alignment: Alignment.centerLeft,
                    child: Text("PO # *"),
                  ),
                  //trailing: Icon(Icons.shopping_cart),
                  title: new TextFormField(
                    decoration: new InputDecoration(
                      hintText: "PO #",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter PO #';
                      }
                    },
                    onSaved: (val) => setState(() => _call.towedPONumber = val),
                  ),
                ),
//            Padding(
//                padding: EdgeInsets.only( left: 15,
//                  top: 25,
//                  right: 15,
//                  bottom:25,),
//            child:Row(
//                children: <Widget>[
//            Expanded(
//                  child:RaisedButton(onPressed: () {
////                    final form = _formKey.currentState;
//                    _formKey.currentState.reset();
//
//                  }, child: Text('Clear')),
//                ) ,
//                  Spacer(),
//                Expanded(
//                child:RaisedButton(
//                    onPressed: () async {},
////                      final form = _formKey.currentState;
////                      if (form.validate()) {
////                        form.save();
////                        await Provider.of<ProcessTowedVehiclesVM>(context)
////                            .checkForDuplicateTickets(_call);
////                        if (Provider.of<ProcessTowedVehiclesVM>(context)
////                                .duplicateData["errorStatus"] ==
////                            "true") {
////                          showDialog(
////                              context: context,
////                              builder: (BuildContext context) {
////                                return DuplicateCall();
////                              });
////
////                          //Add Yes or No Button and Rock it
////                        }
////                        else{
////                          //Call Save here
////                          Provider.of<Calls>(context).create(_call);
////                        }
////                        _showDialog(context);
////                      }
////                    },
//                    child: Text('Save'))),
//            ]))
              ],
            ),
          ),
        )));
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Checking for Duplicates')));
  }

  save() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      await Provider.of<ProcessTowedVehiclesVM>(context)
          .checkForDuplicateTickets(_call);
      if (Provider.of<ProcessTowedVehiclesVM>(context)
              .duplicateData["errorStatus"] ==
          "true") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DuplicateCall();
            });

        //Add Yes or No Button and Rock it
      } else {
        //Call Save here
        Provider.of<Calls>(context).create(_call);
        print("souji " + _call.toString());
      }
      _showDialog(context);
    }
  }
}
