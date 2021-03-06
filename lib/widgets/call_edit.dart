import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:vts_mobile_cloud/providers/processTowedVehicle_provider.dart';
import 'package:vts_mobile_cloud/widgets/charges_add.dart';
import 'package:vts_mobile_cloud/widgets/photos_list.dart';
import 'package:vts_mobile_cloud/widgets/tow_jurisdiction_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_reason_modal.dart';
import '../providers/secureStoreMixin_provider.dart';
import 'package:vts_mobile_cloud/screens/success_screen.dart';
import 'package:vts_mobile_cloud/models/call.dart';
import 'package:vts_mobile_cloud/providers/calls_provider.dart';
import 'package:vts_mobile_cloud/widgets/authorization_modal.dart';
import 'package:vts_mobile_cloud/widgets/color_modal.dart';
import 'package:vts_mobile_cloud/widgets/notes_add.dart';
import 'package:vts_mobile_cloud/widgets/photos_add.dart';
import 'package:vts_mobile_cloud/widgets/system_city_modal.dart';
import 'package:vts_mobile_cloud/widgets/system_priority_modal.dart';
import 'package:vts_mobile_cloud/widgets/system_state_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_customers_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_trucks_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_type_modal.dart';
import 'package:vts_mobile_cloud/widgets/towed_vehicle_charges_list.dart';
import 'package:vts_mobile_cloud/widgets/vehicleYearMakeModel_modal.dart';
import 'package:vts_mobile_cloud/widgets/vehicle_make_modal.dart';
import 'package:vts_mobile_cloud/widgets/wrecker_company_modal.dart';
import 'package:vts_mobile_cloud/widgets/wrecker_driver_modal.dart';
import 'package:vts_mobile_cloud/widgets/towed_vehicle_notes_list.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CallEdit extends StatefulWidget {
  var initialIndex;
  int selectedTabIndex;

  CallEdit(this.initialIndex, this.selectedTabIndex) : super();

  @override
  _CallEditState createState() => _CallEditState();
}

class _CallEditState extends State<CallEdit> with SecureStoreMixin, AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autoValidate = true;
  bool _isFormReadOnly = false;
  bool wantKeepAlive = true;
  DateTime _date = DateTime.now();
  final _call = Call();
  String userRole;
  String userId;
  var dispatchPaging;
  bool isLoading = false;
  int tabIndex = 0;
  var x;
  var _billToController = new TextEditingController();
  var _towedInvoiceController = new TextEditingController();
  var _dispatchMemberController = new TextEditingController();
  var _vinController = new TextEditingController();
  var _modelController = new TextEditingController();
  var _yearController = new TextEditingController();
  var _makeController = new TextEditingController();

//  var _styleController = new TextEditingController();
  var _topColorController = new TextEditingController();
  var _secondColorController = new TextEditingController();
  var _licensePlateController = new TextEditingController();
  var _licenseStateController = new TextEditingController();

//  var _licenseTypeController = new TextEditingController();
//  var _towedTrailerController = new TextEditingController();
//  var _towedTruckController = new TextEditingController();
//  var _vehicleTitleController = new TextEditingController();
  var _vehicleOdometerController = new TextEditingController();
  var _towTypeController = new TextEditingController();
  var _towReasonController = new TextEditingController();
  var _authorizationController = new TextEditingController();
  var _jurisdictionController = new TextEditingController();
  var _companyController = new TextEditingController();
  var _driverController = new TextEditingController();
  var _truckController = new TextEditingController();
  var _towedStreetController = new TextEditingController();
  var _towedStreetTwoController = new TextEditingController();
  var _towedCityController = new TextEditingController();
  var _towedStateController = new TextEditingController();

//  var _towedZipCodeController = new TextEditingController();
  var _towedToStreetController = new TextEditingController();
  var _towedToStreetTwoController = new TextEditingController();
  var _towedToCityController = new TextEditingController();
  var _towedToStateController = new TextEditingController();

//  var _towedToZipCodeController = new TextEditingController();
//  var _towedStatusController = new TextEditingController();
  var _towedDateController = new TextEditingController();
  var _towedTimeController = new TextEditingController();

//  var _wreckerDriverPaidController = new TextEditingController();
//  var _wreckerDriverPaymentController = new TextEditingController();
  var _vehiclePriorityTypeController = new TextEditingController();
  var _towCustomerController = new TextEditingController();
  var _dispatchInstructions_stringController = new TextEditingController();
  var _dispatchContactController = new TextEditingController();
  var _dispatchContactPhoneController =
      new MaskedTextController(mask: '(000)000-0000');
  var _dispatchDateController = new TextEditingController();

//  var _dispatchReceivedTimeController = new TextEditingController();
//  var _dispatchDispatchTimeController = new TextEditingController();
//  var _dispatchRollingTimeController = new TextEditingController();
//  var _dispatchArrivedTimeController = new TextEditingController();
//  var _dispatchClearedTimeController = new TextEditingController();
//  var _dispatchEnrouteTimeController = new TextEditingController();
//  var _dispatchOnsiteTimeController = new TextEditingController();
  var _dispatchProviderResponseController = new TextEditingController();

//  var _dispatchIDController = new TextEditingController();
  var _dispatchResponseIDController = new TextEditingController();
  var _dispatchAuthorizationNumberController = new TextEditingController();

//  var _dispatchJobIDController = new TextEditingController();
//  var _dispatchProviderSelectedResponseNameController = new TextEditingController();
//  var _dispatchRequestorResponseController = new TextEditingController();
//  var _dispatchETAMaximumController = new TextEditingController();
//  var _bodyShopController = new TextEditingController();
//  var _towedRONumberController = new TextEditingController();
//  var _bodyShopAtShopDateController = new TextEditingController();
//  var _bodyShopPendingDateController = new TextEditingController();
//  var _bodyShopWorkingDateController = new TextEditingController();
//  var _bodyShopWorkingDate = new TextEditingController();
//  var _bodyShopTotaledDateController = new TextEditingController();
//  var _bodyShopMovedDateController = new TextEditingController();
//  var _bodyShopDriverTransferDateController = new TextEditingController();
//  var _bodyShopDriverTransferAmountController = new TextEditingController();
//  var _bodyShopDriverRepairDateController = new TextEditingController();
//  var _bodyShopDriverRepairAmountController = new TextEditingController();
//  var _bodyShopPaymentDateController = new TextEditingController();
//  var _bodyShopPaymentAmountController = new TextEditingController();
  var _towedPONumberController = new TextEditingController();
  var _dispatchLimitAmountController = new TextEditingController();
  var _dispatchLimitMilesController = new TextEditingController();

  var _towedDiscountRateController = new TextEditingController();
  var _towedDiscountAmountController = new TextEditingController();

//  var _vehicleLicenseYearController = new TextEditingController();
  var _dispatchETAMinutesController = new TextEditingController();

  getRole() async {
    await getSecureStore('userRole', (token) {
      // setState(() {
        userRole = token;
      // });
    });
    if (userRole == "3") {
      _isFormReadOnly = true;
    }
  }

  getUserId() async {
    await getSecureStore('userId', (token) {
      // setState(() {
        userId = token;
      // });
    });
  }

  getDispatchPaging() async {
    await getSecureStore('dispatchPaging', (token) {
      // setState(() {
        dispatchPaging = token;
      // });
    });
  }

  setBillTo(id, name) {
    // setState(() {
    _call.towBillTo = id != null ? id : 0;
    _call.towBillToName = name != null ? name : '';
    _billToController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towBillToName))
        .value;
    // });
  }

  setTowCustomer(id, name) {
    // setState(() {
    _call.towCustomer = id != null ? id : 0;
    _call.towCustomerName = name != null ? name : '';
    _towCustomerController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towCustomerName))
        .value;
    // });
  }

//  setBodyShop(id, name) {
//    setState(() {
//      _call.bodyShop = id;
//      _call.bodyShopName = name;
//      _bodyShopController.value =
//          new TextEditingController.fromValue(new TextEditingValue(text: name))
//              .value;
//    });
//  }

  setModel(id, name) {
    // setState(() {
    _call.vehicleYearMakeModel = id != null ? id : 0;
    _call.vehicleYearMakeModelName = name != null ? name : '';
    _modelController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.vehicleYearMakeModelName))
        .value;
    // });
  }

  setVehicleYear(year) {
    // setState(() {
    _call.vehicleYear = year != null ? year : '';
    _yearController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.vehicleYear.toString()))
        .value;
    // });
  }

  setMake(id, name) {
    // setState(() {
    _call.vehicleMake = id != null ? id : 0;
    _call.vehicleMakeName = name != null ? name : '';
    _makeController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.vehicleMakeName))
        .value;
    // });
  }

  setTowReason(id, name) {
    // setState(() {
    _call.towReason = id != null ? id : 0;
    _call.towReasonName = name != null ? name : '';
    _towReasonController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towReasonName))
        .value;
    // });
  }

//  setStyle(id, name) {
//    setState(() {
//      _call.vehicleStyle = id;
//      _call.vehicleStyleName = name;
//      _styleController.value =
//          new TextEditingController.fromValue(new TextEditingValue(text: name))
//              .value;
//    });
//  }

  setTopColor(id, name) {
    // setState(() {
    _call.topColor = id != null ? id : 0;
    _call.topColorName = name != null ? name : '';
    _topColorController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.topColorName))
        .value;
    // });

    setSecondColor(id, name);
  }

  setSecondColor(id, name) {
    // setState(() {
    _call.secondColor = id != null ? id : 0;
    _call.secondColorName = name != null ? name : '';
    _secondColorController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.secondColorName))
        .value;
    // });
  }

  setLicenseState(suggestion) {
    // setState(() {
    _call.vehicleLicenseState = suggestion.vehicleLicenseState != null
        ? suggestion.vehicleLicenseState
        : 0;
    _call.vehicleLicenseStateName = suggestion.vehicleLicenseStateName != null
        ? suggestion.vehicleLicenseStateName
        : '';
    _licenseStateController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.vehicleLicenseStateName))
        .value;
    // });
  }
  setLicenseState2(obj) {
    _call.vehicleLicenseState = obj.id != null ? obj.id : 0;
    _call.vehicleLicenseStateName = obj.name != null ? obj.name : '';
    _licenseStateController.value = new TextEditingController.fromValue(
        new TextEditingValue(text: obj.shortName != null ? obj.shortName : ''))
        .value;
  }

  setYearMakeModelName(yearMakeModelObj) {
    setMake(yearMakeModelObj.vehicleMake, yearMakeModelObj.vehicleMakeName);
    setVehicleYear(yearMakeModelObj.vehicleYear);
    setModel(yearMakeModelObj.id, yearMakeModelObj.vehicleModelName);
  }

//  setLicenseStyle(id, name) {
//    setState(() {
//      _call.towType = id;
//      _call.towTypeName = name;
//      _licenseTypeController.value =
//          new TextEditingController.fromValue(new TextEditingValue(text: name))
//              .value;
//    });
//
//  }

  setTowType(suggestion) {
    // setState(() {
    _call.towType = suggestion.towType != null && suggestion.towType != 'null'
        ? suggestion.towType
        : 0;
    _call.towTypeName =
        suggestion.towTypeName != null && suggestion.towTypeName != 'null'
            ? suggestion.towTypeName
            : '';
    _call.towAuthorization = suggestion.towAuthorization != null &&
            suggestion.towAuthorization != 'null'
        ? suggestion.towAuthorization
        : 0;
    _call.towAuthorizationName = suggestion.towAuthorizationName != null &&
            suggestion.towAuthorizationName != 'null'
        ? suggestion.towAuthorizationName
        : '';
    _call.towJurisdiction = suggestion.towJurisdiction != null &&
            suggestion.towJurisdiction.toString() != 'null'
        ? suggestion.towJurisdiction
        : 0;
    _call.towJurisdictionName = suggestion.towJurisdictionName != null &&
            suggestion.towJurisdictionName.toString() != 'null'
        ? suggestion.towJurisdictionName
        : '';
    _call.towReason = suggestion.towReason != null &&
            suggestion.towReason.toString() != 'null'
        ? suggestion.towReason
        : 0;
    _call.towReasonName = suggestion.towReasonName != null &&
            suggestion.towReasonName.toString() != 'null'
        ? suggestion.towReasonName
        : '';
    _towTypeController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towTypeName))
        .value;

    _authorizationController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: suggestion.towAuthorizationName))
        .value;

    _jurisdictionController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towJurisdictionName))
        .value;
    _towReasonController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towReasonName))
        .value;
    // });
  }

//  setTowReason(id, name) {
//    setState(() {
//      _call.towReason = id;
//      _call.towReasonName = name;
//      _towReasonController.value =
//          new TextEditingController.fromValue(new TextEditingValue(text: name))
//              .value;
//    });
//  }

  setAuthorization(id, name) {
    // setState(() {
    _call.towAuthorization = id != null ? id : 0;
    _call.towAuthorizationName = name != null ? name : '';
    _authorizationController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towAuthorizationName))
        .value;
    // });
  }

  setJurisdiction(id, name) {
    // setState(() {
    _call.towJurisdiction = id != null ? id : 0;
    _call.towJurisdictionName = name != null ? name : '';
    _jurisdictionController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towJurisdictionName))
        .value;
    // });
  }

  setCity(id, name) {
    // setState(() {
    _call.towedCity = id != null ? id : 0;
    _call.towedCityName = name != null ? name : '';
    _towedCityController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towedCityName))
        .value;
    // });
  }

  setTowedState(obj) {
    // setState(() {
    _call.towedState = obj.id != null ? obj.id : 0;
    _call.towedStateName = obj.name != null ? obj.name : '';
    _towedStateController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: obj.shortName != null ? obj.shortName : ''))
        .value;

    //Empty City
    _call.towedCity = 0;
    _call.towedCityName = "";
    _towedCityController.value =
        new TextEditingController.fromValue(new TextEditingValue(text: ''))
            .value;
    // });
  }

  setTowedToCity(id, name) {
    // setState(() {
    _call.towedToCity = id != null ? id : 0;
    _call.towedToCityName = name != null ? name : '';
    _towedToCityController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towedToCityName))
        .value;
    // });
  }

  setTowedToState(obj) {
    // setState(() {
    _call.towedToState = obj.id != null ? obj.id : 0;
    _call.towedToStateName = obj.name != null ? obj.name : '';
    _towedToStateController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: obj.shortName != null ? obj.shortName : ''))
        .value;

    //Empty City
    _call.towedToCity = 0;
    _call.towedToCityName = "";
    _towedToCityController.value =
        new TextEditingController.fromValue(new TextEditingValue(text: ''))
            .value;
    // });
  }

  setCompany(id, name) {
    // setState(() {
    _call.wreckerCompany = id != null ? id : 0;
    _call.wreckerCompanyName = name != null ? name : '';
    _companyController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.wreckerCompanyName))
        .value;
    // });
  }

  setDriver(driverObj) {
    // setState(() {
    _call.wreckerDriver =
        driverObj.wreckerDriver != null ? driverObj.wreckerDriver : 0;
    _call.wreckerDriverName =
        driverObj.wreckerDriverName != null ? driverObj.wreckerDriverName : '';
    _driverController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.wreckerDriverName))
        .value;
    // });
  }

  setDriverOnEdit(suggestion) {
    // setState(() {
    _call.wreckerDriver = suggestion.wreckerDriver;
    _call.wreckerDriverName = suggestion.wreckerDriverName;
    _driverController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: suggestion.wreckerDriverName))
        .value;
    if (suggestion.towTruck != 0) {
      setTruck(suggestion.towTruck, suggestion.towTruckName);
    }
    // });
    //_formKey.currentState.validate();
  }

  setTruck(id, name) {
    // setState(() {
    _call.towTruck = id != null ? id : 0;
    _call.towTruckName = name != null ? name : '';
    _truckController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towTruckName))
        .value;
    // });
  }

  setVehiclePriority(id, name) {
    // setState(() {
    _call.dispatchPriorityLevel = id != null ? id : 0;
    _call.dispatchPriorityLevelName = name != null ? name : '';
    _vehiclePriorityTypeController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.dispatchPriorityLevelName))
        .value;
    // });
  }

// @override
//   void didChangeDependencies() {
//     bla();
//     super.didChangeDependencies();
//   }

  bla() async {
    isLoading = true;
    var selectedCall = Provider.of<Calls>(context, listen: false).selectedCall;
    await Provider.of<Calls>(context, listen: false).get(selectedCall.id);
     x = await Provider.of<Calls>(context, listen: false).callDetails;

    setState(() {
      //Bill To and BillToName
      _call.id = x[0].id;
      _call.towBillTo = x[0].towBillTo;
      _call.towBillToName = x[0].towBillToName;
      _billToController.value = new TextEditingController.fromValue(
              new TextEditingValue(
                  text: x[0].towBillToName != null ? x[0].towBillToName : ''))
          .value;

      //Invoice
      _call.towedInvoice = x[0].towedInvoice;
      _towedInvoiceController.value = new TextEditingController.fromValue(
              new TextEditingValue(
                  text: x[0].towedInvoice != null ? x[0].towedInvoice : ''))
          .value;

      //TowedPONumber
      _call.towedPONumber =
          x[0].towedPONumber != null ? x[0].towedPONumber : '';
      _towedPONumberController.value = new TextEditingController.fromValue(
              new TextEditingValue(
                  text:
                      x[0].towedPONumber != null && x[0].towedPONumber != 'null'
                          ? x[0].towedPONumber
                          : ''))
          .value;

      //Member Number
      _call.dispatchMemberNumber = x[0].dispatchMemberNumber;
      _dispatchMemberController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: x[0].dispatchMemberNumber))
          .value;

      //LimitAmount
      _call.dispatchLimitAmount = x[0].dispatchLimitAmount;
      _dispatchLimitAmountController.value =
          new TextEditingController.fromValue(
                  new TextEditingValue(text: x[0].dispatchLimitAmount))
              .value;

      //LimitMiles
      _call.dispatchLimitMiles = x[0].dispatchLimitMiles;
      _dispatchLimitMilesController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: x[0].dispatchLimitMiles))
          .value;

      //Towed Sub Total
      _call.towedSubTotal = x[0].towedSubTotal;
      //Discount Rate
      _call.towedDiscountRate = x[0].towedDiscountRate;
      _towedDiscountRateController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: x[0].towedDiscountRate.toString()))
          .value;

      //Discount Amount
      _call.towedDiscountAmount = x[0].towedDiscountAmount;
      _towedDiscountAmountController
          .value = new TextEditingController.fromValue(
              new TextEditingValue(text: x[0].towedDiscountAmount.toString()))
          .value;

      //VIN
      _call.VIN = x[0].VIN != null ? x[0].VIN : '';
      _vinController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: x[0].VIN))
          .value;

      //Model
      setModel(x[0].vehicleYearMakeModel, x[0].vehicleYearMakeModelName);

      //Year
      setVehicleYear(x[0].vehicleYear);

      //Make
      setMake(x[0].vehicleMake, x[0].vehicleMakeName);

      //Style
//      setStyle(x[0].vehicleStyle, x[0].vehicleStyleName);

      //Top COlor
      setTopColor(x[0].topColor, x[0].topColorName);

      //Bottom COlor
      setSecondColor(x[0].secondColor, x[0].secondColorName);

      //License Plate
      _call.licensePlate =
          x[0].licensePlate != null && x[0].licensePlate != 'null'
              ? x[0].licensePlate
              : '';
      _licensePlateController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: x[0].licensePlate))
          .value;

      //License State
      setLicenseState(x[0]);

      //License Type
//      setLicenseStyle(x[0].vehicleLicenseType, x[0].vehicleLicenseTypeName);

      //Expiration
//      _call.vehicleLicenseYear = x[0].vehicleLicenseYear;
//      _vehicleLicenseYearController.value =
//          new TextEditingController.fromValue(new TextEditingValue(text: x[0].vehicleLicenseYear))
//              .value;

      //TowedTrailerNumber
//      _call.towedTrailerNumber = x[0].towedTrailerNumber;
//      _towedTrailerController.value =
//          new TextEditingController.fromValue(new TextEditingValue(text: x[0].towedTrailerNumber))
//              .value;

      //TowedTruckNumber
//      _call.towedTruckNumber = x[0].towedTruckNumber;
//      _towedTruckController.value =
//          new TextEditingController.fromValue(new TextEditingValue(text: x[0].towedTruckNumber))
//              .value;

      //Vehicle Title
//      _call.vehicleTitle = x[0].vehicleTitle;
//      _vehicleTitleController.value =
//          new TextEditingController.fromValue(new TextEditingValue(text: x[0].vehicleTitle))
//              .value;

      //Vehicle Odometer
      _call.vehicleOdometer = x[0].vehicleOdometer;
      _vehicleOdometerController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: x[0].vehicleOdometer))
          .value;
      isLoading = false;
    });

    //Tow Type
    setTowType(x[0]);

    //Tow Reason
    //setTowReason(x[0].towReason, x[0].towReasonName);

    //Authorization
    setAuthorization(x[0].towAuthorization, x[0].towAuthorizationName);

    //Jurisdiction
    //setJurisdiction(x[0].towJurisdiction, x[0].towJurisdictionName);

    //Towed Date
    _call.towedDate = x[0].towedDate;
    _towedDateController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].towedDate))
        .value;

    //Towed Time
    _call.towedTime = x[0].towedTime;
    _towedTimeController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].towedTime))
        .value;

    //Towed Street
    if (x[0].towedStreet != null && x[0].towedStreet != 'null') {
      _call.towedStreet = x[0].towedStreet.replaceAll("\\", "");
    } else {
      _call.towedStreet = "";
    }
    _towedStreetController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towedStreet))
        .value;

    //Towed Street2
    if (x[0].towedStreetTwo != null && x[0].towedStreetTwo != 'null') {
      _call.towedStreetTwo = x[0].towedStreetTwo.replaceAll("\\", "");
    } else {
      _call.towedStreetTwo = "";
    }
    _towedStreetTwoController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: _call.towedStreetTwo))
        .value;

    //TowedCity
    _call.towedCity = x[0].towedCity;
    _call.towedCityName = x[0].towedCityName;
    _towedCityController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].towedCityName))
        .value;

    //TowedState
    _call.towedState = x[0].towedState;
    _call.towedStateName = x[0].towedStateName;
    _towedStateController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].towedStateName))
        .value;

    //TowedZipCode
//    _call.towedZipCode = x[0].towedZipCode;
//    _towedZipCodeController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].towedZipCode))
//            .value;

    //TowedToStreet
    if (x[0].towedToStreet != null && x[0].towedToStreet != 'null') {
      _call.towedToStreet = x[0].towedToStreet.replaceAll("\\", "");
    } else {
      _call.towedToStreet = "";
    }
    _towedToStreetController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].towedToStreet))
        .value;

    //Towed Street2
    if (x[0].towedToStreetTwo != null && x[0].towedToStreetTwo != 'null') {
      _call.towedToStreetTwo = x[0].towedToStreetTwo.replaceAll("\\", "");
    } else {
      _call.towedToStreetTwo = "";
    }
    _towedToStreetTwoController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].towedToStreetTwo))
        .value;

    //TowedToCity
    _call.towedToCity = x[0].towedToCity;
    _call.towedToCityName = x[0].towedToCityName;
    _towedToCityController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].towedToCityName))
        .value;

    //TowedToState
    _call.towedToState = x[0].towedToState;
    _call.towedToStateName = x[0].towedToStateName;
    _towedToStateController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].towedToStateName))
        .value;

    //TowedToZipCode
//    _call.towedToZipCode = x[0].towedToZipCode;
//    _towedToZipCodeController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].towedToZipCode))
//            .value;

    //Company
    setCompany(x[0].wreckerCompany, x[0].wreckerCompanyName);

    //TowedStatus
    _call.towedStatus = x[0].towedStatus;
    _call.towedStatusName = x[0].towedStatusName;
//    _towedStatusController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].towedStatusName))
//            .value;

    //Driver
    setDriver(x[0]);

    //Truck
    setTruck(x[0].towTruck, x[0].towTruckName);

    //WreckerDriverPaid
//    _call.wreckerDriverPaid = x[0].wreckerDriverPaid;
//    _wreckerDriverPaidController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].wreckerDriverPaid))
//            .value;

    //WreckerDriverPayment
//    _call.wreckerDriverPayment = x[0].wreckerDriverPayment;
//    _wreckerDriverPaymentController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].wreckerDriverPayment))
//            .value;

    //Tow Customer
    setTowCustomer(x[0].towCustomer, x[0].towCustomerName);

    //Instructions
    _call.dispatchInstructions_string = x[0].dispatchInstructions_string != null
        ? x[0].dispatchInstructions_string.replaceAll("\\n", "\n")
        : '';
    _dispatchInstructions_stringController.value =
        new TextEditingController.fromValue(new TextEditingValue(
                text: _call.dispatchInstructions_string != null &&
                        _call.dispatchInstructions_string != 'null'
                    ? _call.dispatchInstructions_string
                    : ''))
            .value;

    //Dispatch Contact
    _call.dispatchContact = x[0].dispatchContact;
    _dispatchContactController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].dispatchContact))
        .value;

    //DispatchContactPhone
    _call.dispatchContactPhone = x[0].dispatchContactPhone;
    _dispatchContactPhoneController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].dispatchContactPhone))
        .value;

    //DispatchPriorityLevelName
    setVehiclePriority(
        x[0].dispatchPriorityLevel, x[0].dispatchPriorityLevelName);

    //DispatchETAMinutes
    _call.dispatchETAMinutes = x[0].dispatchETAMinutes;
    _dispatchETAMinutesController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].dispatchETAMinutes))
        .value;

    //Call Date
    _call.dispatchDate = x[0].dispatchDate;
    _dispatchDateController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].dispatchDate))
        .value;

    //ReceivedTime
    _call.dispatchReceivedTime =
        x[0].dispatchReceivedTime != null ? x[0].dispatchReceivedTime : '';
//    _dispatchReceivedTimeController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchReceivedTime))
//            .value;

    //Dispatch
    _call.dispatchDispatchTime =
        x[0].dispatchDispatchTime != null ? x[0].dispatchDispatchTime : '';
//    _dispatchDispatchTimeController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchDispatchTime))
//            .value;

    //Enroute
    _call.dispatchEnrouteTime =
        x[0].dispatchEnrouteTime != null ? x[0].dispatchEnrouteTime : '';
//    _dispatchEnrouteTimeController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchEnrouteTime))
//            .value;

    //Onsite
    _call.dispatchOnsiteTime =
        x[0].dispatchOnsiteTime != null ? x[0].dispatchOnsiteTime : '';
//    _dispatchOnsiteTimeController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchOnsiteTime))
//            .value;

    //Rolling
    _call.dispatchRollingTime =
        x[0].dispatchRollingTime != null ? x[0].dispatchRollingTime : '';
//    _dispatchRollingTimeController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchRollingTime))
//            .value;

    //Arrived
    _call.dispatchArrivedTime =
        x[0].dispatchArrivedTime != null ? x[0].dispatchArrivedTime : '';
//    _dispatchArrivedTimeController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchArrivedTime))
//            .value;

    //Cleared
    _call.dispatchClearedTime =
        x[0].dispatchClearedTime != null ? x[0].dispatchClearedTime : '';
//    _dispatchClearedTimeController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchClearedTime))
//            .value;

    //DispatchId
//    _call.dispatchID = x[0].dispatchID;
//    _dispatchIDController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchID))
//            .value;

    //DispatchResponseId
    _call.dispatchResponseID = x[0].dispatchResponseID;
    _dispatchResponseIDController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: x[0].dispatchResponseID))
        .value;

    //DispatchAuthorizationNumber
    _call.dispatchAuthorizationNumber = x[0].dispatchAuthorizationNumber;
    _dispatchAuthorizationNumberController.value =
        new TextEditingController.fromValue(
                new TextEditingValue(text: x[0].dispatchAuthorizationNumber))
            .value;

    //DispatchJobId
//    _call.dispatchJobID = x[0].dispatchJobID;
//    _dispatchJobIDController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchJobID))
//            .value;

    // dispatchProviderResponse
    _call.dispatchProviderResponse = x[0].dispatchProviderResponse;
    _dispatchProviderResponseController.value =
        new TextEditingController.fromValue(new TextEditingValue(
                text: x[0].dispatchProviderResponse != null
                    ? x[0].dispatchProviderResponse
                    : ''))
            .value;

    //dispatchProviderSelectedResponseName
//    _call.dispatchProviderSelectedResponseName = x[0].dispatchProviderSelectedResponseName;
//    _dispatchProviderSelectedResponseNameController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchProviderSelectedResponseName))
//            .value;

    //dispatchRequestorResponse
//    _call.dispatchRequestorResponse = x[0].dispatchRequestorResponse;
//    _dispatchRequestorResponseController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchRequestorResponse))
//            .value;

    //dispatchETAMaximum
    _call.dispatchETAMaximum =
        x[0].dispatchETAMaximum != null ? x[0].dispatchETAMaximum : '0';
//    _dispatchETAMaximumController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].dispatchETAMaximum))
//            .value;

    //Body Shop
//    setBodyShop(x[0].bodyShop, x[0].bodyShopName);

    //RO#
//    _call.towedRONumber = x[0].towedRONumber;
//    _towedRONumberController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].towedRONumber))
//            .value;

    //At Shop
//    _call.bodyShopAtShopDate = x[0].bodyShopAtShopDate;
//    _bodyShopAtShopDateController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopAtShopDate))
//            .value;

    //Pending
//    _call.bodyShopPendingDate = x[0].bodyShopPendingDate;
//    _bodyShopPendingDateController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopPendingDate))
//            .value;

    //Working
//    _call.bodyShopWorkingDate = x[0].bodyShopWorkingDate;
//    _bodyShopWorkingDateController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopWorkingDate))
//            .value;

    //Totaled
//    _call.bodyShopTotaledDate = x[0].bodyShopTotaledDate;
//    _bodyShopTotaledDateController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopTotaledDate))
//            .value;

    //Moved
//    _call.bodyShopMovedDate = x[0].bodyShopMovedDate;
//    _bodyShopMovedDateController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopMovedDate))
//            .value;

    //Transfer Date
//    _call.bodyShopDriverTransferDate = x[0].bodyShopDriverTransferDate;
//    _bodyShopDriverTransferDateController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopDriverTransferDate))
//            .value;

    //Transfer Amount
//    _call.bodyShopDriverTransferAmount = x[0].bodyShopDriverTransferAmount;
//    _bodyShopDriverTransferAmountController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopDriverTransferAmount))
//            .value;

    //Repair Date
//    _call.bodyShopDriverRepairDate = x[0].bodyShopDriverRepairDate;
//    _bodyShopDriverRepairDateController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopDriverRepairDate))
//            .value;

    //Repair Amount
//    _call.bodyShopDriverRepairAmount = x[0].bodyShopDriverRepairAmount;
//    _bodyShopDriverRepairAmountController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopDriverRepairAmount))
//            .value;

    //Payment Date
//    _call.bodyShopPaymentDate = x[0].bodyShopPaymentDate;
//    _bodyShopPaymentDateController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopPaymentDate))
//            .value;

    //Payment Amount
//    _call.bodyShopPaymentAmount = x[0].bodyShopPaymentAmount;
//    _bodyShopPaymentAmountController.value =
//        new TextEditingController.fromValue(new TextEditingValue(text: x[0].bodyShopPaymentAmount))
//            .value;

    //No Charge
//    _call.noCharge = x[0].noCharge;

    //Bonus
//    _call.towedBonus = x[0].towedBonus;

    //Commissions
//    _call.towedNoCommission = x[0].towedNoCommission;

    //Confirm
//    _call.dispatchAlarmConfirm = x[0].dispatchAlarmConfirm;

    //Cancel
//    _call.dispatchCancel = x[0].dispatchCancel;
  }

  String validateVIN(String value) {
    Pattern pattern = "^[^iIoOqQ'-]{10,17}\$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value != "NOVIN")
      return 'Please enter a valid VIN';
    else
      return null;
  }

  // resetDiscountAmount(){
  //     _call.towedDiscountAmount = "0.00";
  //     _towedDiscountAmountController.value =
  //         new TextEditingController.fromValue(
  //             new TextEditingValue(text: _call.towedDiscountAmount.toString()))
  //             .value;
  // }
  //
  // resetDiscountRate(){
  //     _call.towedDiscountRate = "0.00";
  //     _towedDiscountRateController.value =
  //         new TextEditingController.fromValue(
  //             new TextEditingValue(text: _call.towedDiscountRate.toString()))
  //             .value;
  // }

  String validateDiscountRate(String value) {
    if (value != '') {
      if (double.tryParse(value) != null) {
        //valid num
        if (double.parse(value) >= 0 && double.parse(value) <= 100) {
          return null;
        } else {
          return 'Please enter a valid Discount Rate %';
        }
      }
    }
  }

  String validateDiscountAmount(String value) {
    if (value != '') {
      if (double.tryParse(value) != null) {
        //valid num
        if (double.parse(value) >= 0 &&
            double.parse(value) <= _call.towedSubTotal) {
          return null;
        } else {
          return 'Please enter a valid Discount Amount';
        }
      }
    }
  }

  String validateLocation(String value) {
    if (value.isEmpty)
      return 'Please enter a Location';
    else
      return null;
  }

  String validateYear(String value) {
    if (value.isEmpty)
      return 'Please enter Year';
    else
      return null;
  }

  String validateInvoice(String value) {
    if (value.isEmpty)
      return 'Please enter Invoice';
    else
      return null;
  }

  _showErrorMessage(BuildContext context, errorMessage) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        backgroundColor: Colors.lightGreen,
        content: Text(errorMessage,
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w500))));
  }

  update() async {
    setState(() {
      isLoading = true;
    });

    if (this._formKey.currentState.validate() == true) {
      this._formKey.currentState.save();
      await Provider.of<Calls>(context, listen: false).updateCall(_call);
      var response = Provider.of<Calls>(context, listen: false).updateResponse;
      if (response['errorStatus'] == "true") {
        await Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
            .processChangeCharges(_call.id, 0);
        var processChangeChargeResponse =
            Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
                .processChangeChargeResponse;
        if (processChangeChargeResponse["errorStatus"] == "false") {
          isLoading = false;
          _showErrorMessage(
              context, processChangeChargeResponse["errorMessage"]);
        } else {
          // setState(() {
            isLoading = false;
          // });
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      new SuccessScreen("Call Successfully Updated!")));

          Timer(Duration(milliseconds: 3000), () {
            bla();
            Navigator.pop(context);
          });
        }
      } else {
        isLoading = false;
        _showErrorMessage(context, response['errorMessage']);
      }
    } else {
      isLoading = false;
      _showErrorMessage(context, "Please check your required fields");
    }
    setState(() {
      isLoading = false;
    });
  }

  var selectedCall;
  // bool shouldListenTowedDiscountRateController = false;
  // bool shouldListenTowedDiscountAmountController = false;

  @override
  void initState() {
    getRole();
    getUserId();
    bla();
    selectedCall = Provider.of<Calls>(context, listen: false).selectedCall;
    super.initState();
    // Start listening to changes.
    // _towedDiscountRateController.addListener(resetDiscountAmount);
    // _towedDiscountAmountController.addListener(resetDiscountRate);
  }

  @override
  void dispose() {
    super.dispose();
  }

  refresh() {
     bla();
    setState(() {
      tabIndex = 5;
    });
  }

  refreshNotes() {
    setState(() {
      tabIndex = 4;
    });
  }

  refreshPictures() {
    setState(() {
      tabIndex = 6;
    });
  }

  // refreshPage(){
  //   bla();
  //   setState(() {
  //     tabIndex=0;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // shouldListenTowedDiscountRateController = true;
    // shouldListenTowedDiscountAmountController = true;
    // super.build(context);
    super.build(context);
    // TODO: implement build
    return DefaultTabController(
        key: UniqueKey(),
        length: 7,
        initialIndex: tabIndex,
        child: Scaffold(
            appBar: AppBar(
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back, color: Colors.black),
              //   onPressed: () => back(context)
              // ),
              bottom: TabBar(
                // key:UniqueKey(),
                // controller:_tabController,
                onTap: (index) => {
                   // FocusScope.of(context).requestFocus(new FocusNode()),
                // FocusScope.of(context).unfocus(),
                  // setState(() {
                  tabIndex = index,
                  // });
                },
                isScrollable: true,
                indicatorColor: Colors.green,
                labelColor: Colors.white,
                labelStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                tabs: [
                  Tab(
                    icon: Icon(Icons.monetization_on, size: 18.0),
                    text: "BILLING",
                  ),
                  Tab(
                    icon: Icon(Icons.directions_car, size: 18.0),
                    text: "VEHICLE",
                  ),
                  Tab(
                    icon: Icon(Icons.departure_board, size: 18.0),
                    text: "TOW",
                  ),
                  Tab(
                    icon: Icon(Icons.call_received, size: 18.0),
                    text: "CALL",
                  ),
//                  Tab(
//                    icon: Icon(Icons.build, size: 18.0),
//                    text: "SHOP",
//                  ),
                  Tab(
                    icon: Icon(Icons.note_add, size: 18.0),
                    text: "NOTES",
                  ),
                  Tab(
                    icon: Icon(Icons.attach_money, size: 18.0),
                    text: "CHARGES",
                  ),
                  Tab(
                    icon: Icon(Icons.camera_roll, size: 18.0),
                    text: "PHOTOS",
                  ),
                ],
              ),
              // automaticallyImplyLeading: true,
              title: Text('EDIT CALL',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              actions: <Widget>[
                // new IconButton(
                //   icon: new Icon(Icons.update, size: 20.0),
                //   tooltip: 'Update Status',
                //   onPressed: () {
                //     showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //
                //           return UpdateStatus(
                //               selectedCall:selectedCall,
                //               userRole:userRole,
                //               dispatchPaging: dispatchPaging,
                //               notifyParent: refreshPage,
                //               fromPage: "edit_call",
                //               );
                //         });
                //   },
                // ),
                new IconButton(
                  icon: new Icon(Icons.attach_money, size: 20.0),
                  tooltip: 'Add Charges',
                  onPressed: () {
                    // setState(() {
                    //   widget.initialIndex = 5;
                    // });
                    // Navigator.pop(context);
                    Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new ChargesAdd(
                                    selectedCall: selectedCall.id,
                                    notifyParent: refresh)))
                        .then((value) =>
                       print(""),
                        // setState(() {
                        //       tabIndex = 5;
                        //     })
                    );
                  },
                ),
                new IconButton(
                  icon: new Icon(Icons.note_add, size: 20.0),
                  tooltip: 'Add Notes',
                  onPressed: () {
                    Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new NotesAdd(notifyParent: refreshNotes)))
                        .then((value) =>
                        print("cc")
                        // setState(() {
                        //       tabIndex = 4;
                        //     })
                    );
                  },
                  //onPressed: () => save(),
                ),
                new IconButton(
                  icon: new Icon(Icons.add_a_photo, size: 20.0),
                  tooltip: 'Add Photo',
                  onPressed: () => {
                    Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new PhotosAdd(
                                    notifyParent: refreshPictures)))
                        .then((value) =>
                        print("aa")
                        // setState(() {
                        //       tabIndex = 6;
                        //     })
                    )
                  },
                ),
                new IconButton(
                  icon: new Icon(Icons.check,
                      size: 20.0,
                      color:
                          Colors.white),
                  tooltip: 'Save',
                  onPressed: () => update(),
                ),
//                new IconButton(
//                  icon: new Icon(Icons.more_vert),
//                  tooltip: 'More',
//                  //onPressed: () => save(),
//                ),
              ],
            ),
            body: isLoading == true
                ? Center(child: Loader())
                : Padding(
                    padding: EdgeInsets.all(10.0),
                    child:
                        new Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: TabBarView(
                            key: UniqueKey(),
                            children: [
                          SingleChildScrollView(
                              child: Column(
                            children: <Widget>[
                              new ListTile(
                                title: new TextFormField(
                                    // //autofocus: true,
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._billToController,
                                    decoration: new InputDecoration(
                                      labelText: "Bill To *",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please select Bill To Customer';
//                                  }
//                                },
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => TowCustomersModal(
                                                  setTowCustomer: setBillTo)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  // //autofocus: true,
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _towedInvoiceController,
                                  decoration: new InputDecoration(
                                    labelText: "Invoice # *",
                                  ),
                                  validator: validateInvoice,
                                  onTap: () => {
                                    _towedInvoiceController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _towedInvoiceController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) =>_call.towedInvoice = val,
                                      // setState(() => _call.towedInvoice = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  // //autofocus: true,
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _towedPONumberController,
                                  decoration: new InputDecoration(
                                    labelText: "PO #",
                                  ),
                                  onTap: () => {
                                    _towedPONumberController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _towedPONumberController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) =>_call.towedPONumber = val,
                                      // setState(() => _call.towedPONumber = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  // //autofocus: true,
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _dispatchMemberController,
                                  decoration: new InputDecoration(
                                    labelText: "Member #",
                                  ),
                                  onTap: () => {
                                    _dispatchMemberController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _dispatchMemberController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.dispatchMemberNumber = val,
                                      // setState(
                                      // () => _call.dispatchMemberNumber = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  ////autofocus: true,
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _dispatchLimitAmountController,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9.]"))
                                  ],
                                  decoration: new InputDecoration(
                                    labelText: "Limit \$",
                                  ),
                                  onTap: () => {
                                    _dispatchLimitAmountController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _dispatchLimitAmountController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.dispatchLimitAmount = val,
                                      // setState(
                                      // () => _call.dispatchLimitAmount = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(

                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _dispatchLimitMilesController,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9.]"))
                                  ],
                                  decoration: new InputDecoration(
                                    labelText: "Limit Miles",
                                  ),
                                  onTap: () => {
                                    _dispatchLimitMilesController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _dispatchLimitMilesController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.dispatchLimitMiles = val
                                      // setState(
                                      // () => _call.dispatchLimitMiles = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _towedDiscountRateController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: new InputDecoration(
                                    labelText:
                                        "Discount Rate % (Range 0 - 100)",
                                  ),
                                  validator: validateDiscountRate,
                                  onChanged: (val) => {
                                    // _towedDiscountAmountController.clear(),
                                    _towedDiscountAmountController.value =
                                        new TextEditingController.fromValue(
                                                new TextEditingValue(
                                                    text: "0.00"))
                                            .value
                                  },
                                  onTap: () => {
                                    _towedDiscountRateController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _towedDiscountRateController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.towedDiscountRate = val,
                                      // setState(
                                      // () => _call.towedDiscountRate = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _towedDiscountAmountController,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9.]"))
                                  ],
                                  decoration: new InputDecoration(
                                    labelText: "Discount Amount (Max : \$" +
                                        _call.towedSubTotal.toStringAsFixed(2) +
                                        ")",
                                  ),
                                  validator: validateDiscountAmount,
                                  onChanged: (val) => {
                                    // _towedDiscountRateController.clear()
                                    _towedDiscountRateController.value =
                                        new TextEditingController.fromValue(
                                                new TextEditingValue(
                                                    text: "0.00"))
                                            .value
                                  },
                                  onTap: () => {
                                    _towedDiscountAmountController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _towedDiscountAmountController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.towedDiscountAmount = val,
                                      // setState(
                                      // () => _call.towedDiscountAmount = val),
                                ),
                              ),
//                          ListTile(
//                            leading: Container(
//                              width: 100,
//                              // can be whatever value you want
//                              alignment: Alignment.centerLeft,
//                              child: Text('No Charge', style: new TextStyle(
//                                  color: Colors.black54, fontSize: 16)),
//                            ),
//                            trailing:  Checkbox(
//                              //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
//                              value: _call.noCharge != null ?_call.noCharge : false,
//                              onChanged: (bool val) {
//                                _call.noCharge=val;
//                                //noCharge
//                              },
//                            ),
//                          ),
                            ],
                          )),
                          SingleChildScrollView(
                              child: Column(
                            children: <Widget>[
                              new ListTile(
                                title: new TextFormField(
                                  // onEditingComplete: () {
                                  //   FocusScope.of(context).requestFocus(new FocusNode());
                                  //   FocusScope.of(context).unfocus();
                                  // },

                                  // readOnly: _isFormReadOnly,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _vinController,
                                  decoration: new InputDecoration(
                                    labelText: "VIN *",
                                    suffixIcon: IconButton(
                                      //onPressed: () => _getVIN(), //_controller.clear(),
                                      icon: Icon(Icons.autorenew, size: 14),
                                    ),
                                  ),
                                  validator: validateVIN,
                                  onTap: () => {
                                    _vinController.selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            _vinController.value.text.length)
                                  },
                                  onSaved: (val) =>_call.VIN = val,
                                      // setState(() => _call.VIN = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._modelController,
                                    decoration: new InputDecoration(
                                      labelText: "Model *",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select Model';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () => {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new VehicleYearMakeModelModal(
                                                      setYearMakeModelName:
                                                          setYearMakeModelName)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  keyboardType: TextInputType.number,
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: this._yearController,
                                  decoration: new InputDecoration(
                                    labelText: "Year *",
                                    // suffixIcon: Icon(Icons.arrow_forward_ios,size:14),
                                  ),
                                  validator: validateYear,
                                  onTap: () => {
                                    _yearController.selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            _yearController.value.text.length)
                                  },
                                  onSaved: (val) =>_call.vehicleYear = int.parse(val),
                                      // setState(
                                      // () => _call.vehicleYear = int.parse(val)),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._makeController,
                                    decoration: new InputDecoration(
                                      labelText: "Make *",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select Make';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new VehicleMakeModal(
                                                      setMake: setMake)))
                                    }),
                              ),
//                          new ListTile(
//                            title: new TextFormField(
//                                controller: this._styleController,
//                                decoration: new InputDecoration(
//                                  labelText: "Style",
//                                  suffixIcon: Icon(Icons.arrow_forward_ios),
//                                ),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please select Style';
//                                  }
//                                },
//                                onTap: () {
////                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
//                                  Navigator.push(
//                                      context,
//                                      new MaterialPageRoute(
//                                          builder: (context) =>
//                                              new VehicleStyleModal(
//                                                  setStyle: setStyle)));
//                                }),
//                          ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._topColorController,
                                    decoration: new InputDecoration(
                                      labelText: "Top Color *",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select Top Color';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new ColorModal(
                                                      setColor: setTopColor)));
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._secondColorController,
                                    decoration: new InputDecoration(
                                      labelText: "Bottom Color *",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select Bottom Color';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new ColorModal(
                                                      setColor:
                                                          setSecondColor)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  // onEditingComplete: () {
                                  //   FocusScope.of(context).requestFocus(new FocusNode());
                                  //   // FocusScope.of(context).unfocus();
                                  // },

                                  autocorrect: false,
                                  // readOnly: _isFormReadOnly,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _licensePlateController,
                                  decoration: new InputDecoration(
                                    labelText: "License Plate *",
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter License Plate';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () => {
                                    _licensePlateController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _licensePlateController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) =>_call.licensePlate = val,
                                      // setState(() => _call.licensePlate = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    // enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._licenseStateController,
                                    decoration: new InputDecoration(
                                      labelText: "License State *",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select License State';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new SystemStateModal(
                                                      setSystemState:
                                                          setLicenseState2)))
                                    }),
                              ),
//                          new ListTile(
//                            title: new TextFormField(
//                                controller: this._licenseTypeController,
//                                decoration: new InputDecoration(
//                                  labelText: "License Type",
//                                  suffixIcon: Icon(Icons.arrow_forward_ios),
//                                ),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please select License Type';
//                                  }
//                                },
//                                onTap: () {
////                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
//                                  Navigator.push(
//                                      context,
//                                      new MaterialPageRoute(
//                                          builder: (context) =>
//                                              new LicenseTypeModal(
//                                                  setLicenseStyle:
//                                                      setLicenseStyle)));
//                                }),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                                controller: this._vehicleLicenseYearController,
//                                decoration: new InputDecoration(
//                                  labelText: "Expiration",
//                                  suffixIcon: Icon(Icons.arrow_forward_ios),
//                                ),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter Expiration Year';
//                                  }
//                                },
//                                onTap: () {
////                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
//                                  Navigator.push(
//                                      context,
//                                      new MaterialPageRoute(
//                                          //    builder: (context) =>
//                                          //  new TowCustomersModal(setYear: setYear))
//                                          ));
//                                }),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _towedTrailerController,
//                              decoration: new InputDecoration(
//                                labelText: "Trailer #",
//
//                              ),
//                              validator: (value) {
//                                if (value.isEmpty) {
//                                  return 'Please enter Trailer #';
//                                }
//                              },
//                              onSaved: (val) => setState(
//                                  () => _call.towedTrailerNumber = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _towedTrailerController,
//                              decoration: new InputDecoration(
//                                labelText: "Truck #",
//
//                              ),
//                              validator: (value) {
//                                if (value.isEmpty) {
//                                  return 'Please enter Truck #';
//                                }
//                              },
//                              onSaved: (val) =>
//                                  setState(() => _call.towedTruckNumber = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _vehicleTitleController,
//                              decoration: new InputDecoration(
//                                labelText: "Title",
//                              ),
//                              validator: (value) {
//                                if (value.isEmpty) {
//                                  return 'Please enter Title';
//                                }
//                              },
//                              onSaved: (val) =>
//                                  setState(() => _call.vehicleTitle = val),
//                            ),
//                          ),
                              new ListTile(
                                title: new TextFormField(
                                  // readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: this._vehicleOdometerController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: new InputDecoration(
                                    labelText: "Odometer",
                                  ),
                                  onTap: () => {
                                    _vehicleOdometerController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _vehicleOdometerController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.vehicleOdometer = val,
                                  // setState(
                                  //     () => _call.vehicleOdometer = val),
                                ),
                              ),
                            ],
                          )),
                          SingleChildScrollView(
                              child: Column(
                            children: <Widget>[
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._towTypeController,
                                    decoration: new InputDecoration(
                                      labelText: "Tow Type *",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select Tow Type';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new TowTypeModal(
                                                      setTowType: setTowType)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._towReasonController,
                                    decoration: new InputDecoration(
                                      labelText: "Tow Reason",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new TowReasonModal(
                                                      setTowReason:
                                                          setTowReason)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._authorizationController,
                                    decoration: new InputDecoration(
                                      labelText: "Authorization",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new TowAuthorizationModal(
                                                      setAuthorization:
                                                          setAuthorization)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._jurisdictionController,
                                    decoration: new InputDecoration(
                                      labelText: "Jurisdiction *",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select Jurisdiction';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new TowJurisdictionModal(
                                                      setJurisdiction:
                                                          setJurisdiction)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: true,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _towedDateController,
                                  decoration: new InputDecoration(
                                    labelText: "Towed Date",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _isFormReadOnly == false
                                            ? DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                //  minTime: DateTime(2018, 3, 5),
                                                //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                                                //   //print('change $date');
                                                // },
                                                onConfirm: (date) {
                                                String formattedDate =
                                                    DateFormat('MM-dd-yyyy')
                                                        .format(date);
                                                _towedDateController.text =
                                                    formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                              },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.en)
                                            : null;
                                      }, //_controller.clear(),
                                      icon: Icon(Icons.date_range, size: 14),
                                    ),
                                  ),
                                  onSaved: (val) =>_call.towedDate = val
                                      // setState(() => _call.towedDate = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: true,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _towedTimeController,
                                  decoration: new InputDecoration(
                                    labelText: "Towed Time",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _isFormReadOnly == false
                                            ? DatePicker.showTimePicker(context,
                                                showSecondsColumn: false,
                                                showTitleActions: true,
                                                //  minTime: DateTime(2018, 3, 5),
                                                //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                                                //   //print('change $date');
                                                // },
                                                onConfirm: (time) {
                                                String formattedTime =
                                                    DateFormat('HH:mm')
                                                        .format(time);
                                                _towedTimeController.text =
                                                    formattedTime;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                              },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.en)
                                            : null;
                                      }, //_controller.clear(),
                                      icon: Icon(Icons.access_time, size: 14),
                                    ),
                                  ),
                                  onSaved: (val) =>_call.towedTime = val,
                                      // setState(() => _call.towedTime = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _towedStreetController,
                                  decoration: new InputDecoration(
                                    labelText: "Location *",
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'Please enter location';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () => {
                                    _towedStreetController
                                        .value.text.length > 0 ?
                                    _towedStreetController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset: _towedStreetController
                                                .value.text.length) : ''
                                  },
                                  onSaved: (val) =>_call.towedStreet = val,
                                      // setState(() => _call.towedStreet = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _towedStreetTwoController,
                                  decoration: new InputDecoration(
                                    labelText: "",
                                  ),
                                  onTap: () => {
                                    _towedStreetTwoController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _towedStreetTwoController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.towedStreetTwo = val,
                                  // setState(
                                  //     () => _call.towedStreetTwo = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._towedStateController,
                                    decoration: new InputDecoration(
                                      labelText: "State",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new SystemStateModal(
                                                      setSystemState:
                                                          setTowedState)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._towedCityController,
                                    decoration: new InputDecoration(
                                      labelText: "City",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new SystemCityModal(
                                                      setCity: setCity,
                                                      stateId: _call.towedState
                                                          .toString())))
                                    }),
                              ),

//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _towedZipCodeController,
//                              decoration: new InputDecoration(
//                                labelText: "Zip Code",
//                              ),
//                              onSaved: (val) =>
//                                  setState(() => _call.towedZipCode = val),
//                            ),
//                          ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _towedToStreetController,
                                  decoration: new InputDecoration(
                                    labelText: "Destination",
                                  ),
                                  onTap: () => {
                                    _towedToStreetController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _towedToStreetController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) =>_call.towedToStreet = val,
                                      // setState(() => _call.towedToStreet = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _towedToStreetTwoController,
                                  decoration: new InputDecoration(
                                    labelText: "",
                                  ),
                                  onTap: () => {
                                    _towedToStreetTwoController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _towedToStreetTwoController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.towedToStreetTwo = val,
                                  // setState(
                                  //     () => _call.towedToStreetTwo = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._towedToStateController,
                                    decoration: new InputDecoration(
                                      labelText: "State",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    onTap: () => {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new SystemStateModal(
                                                      setSystemState:
                                                          setTowedToState)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._towedToCityController,
                                    decoration: new InputDecoration(
                                      labelText: "City",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    onTap: () => {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new SystemCityModal(
                                                      setCity: setTowedToCity,
                                                      stateId: _call
                                                          .towedToState
                                                          .toString())))
                                    }),
                              ),

//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _towedToZipCodeController,
//                              decoration: new InputDecoration(
//                                labelText: "Zip Code",
//                              ),
//                              onSaved: (val) =>
//                                  setState(() => _call.towedToZipCode = val),
//                            ),
//                          ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._companyController,
                                    decoration: new InputDecoration(
                                      labelText: "Company *",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select Company';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () => {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new WreckerCompanyModal(
                                                      setCompany: setCompany)))
                                    }),
                              ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _towedStatusController,
//                              decoration: new InputDecoration(
//                                labelText: "Towed Status",
//                              ),
//                            ),
//                          ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._driverController,
                                    decoration: new InputDecoration(
                                      labelText: "Driver",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new WreckerDriverModal(
                                                      setDriver:
                                                          setDriverOnEdit)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._truckController,
                                    decoration: new InputDecoration(
                                      labelText: "Truck",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new TowTrucksModal(
                                                      setTruck: setTruck)))
                                    }),
                              ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _wreckerDriverPaidController,
//                              decoration: new InputDecoration(
//                                labelText: "Driver Paid",
//                                suffixIcon: IconButton(
//                                  onPressed: () {
//                                    DatePicker.showDatePicker(context,
//                                        showTitleActions: true,
//                                        //  minTime: DateTime(2018, 3, 5),
//                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//                                        //   //print('change $date');
//                                        // },
//                                        onConfirm: (date) {
//                                      String formattedDate =
//                                          DateFormat('MM-dd-yyyy').format(date);
//                                      _towedDateController.text = formattedDate;
////                              String formattedTime = DateFormat('kk.mm').format(now);
////                              String formattedTime2 = DateFormat('kk^mm').format(now);
//                                    },
//                                        currentTime: DateTime.now(),
//                                        locale: LocaleType.en);
//                                  }, //_controller.clear(),
//                                  icon: Icon(Icons.date_range),
//                                ),
//                              ),
//                              onSaved: (val) =>
//                                  setState(() => _call.wreckerDriverPaid = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _wreckerDriverPaymentController,
//                              decoration: new InputDecoration(
//                                labelText: "Driver Payment",
//                              ),
//                              validator: (value) {
//                                if (value.isEmpty) {
//                                  return 'Please enter VIN';
//                                }
//                              },
//                              onSaved: (val) => setState(
//                                  () => _call.wreckerDriverPayment = val),
//                            ),
//                          ),
//                          ListTile(
//                            title: Text('Bonus', style: new TextStyle(
//                                color: Colors.black54, fontSize: 16)),
//                            trailing: Checkbox(
//                              //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
//                              value: _call.towedBonus != null ? _call.towedBonus : false,
//                              onChanged: (bool val) {
//                                _call.towedBonus = val;
//                              },
//                            ),
//                          ),
//                          ListTile(
//                            title: Text('No Commission', style: new TextStyle(
//                                color: Colors.black54, fontSize: 16)),
//                            trailing: Checkbox(
//                              //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
//                              value: _call.towedNoCommission != null ? _call.towedNoCommission : false,
//                              onChanged: (bool val) {
//                               _call.towedNoCommission=val;
//                              },
//                            ),
//                          ),
                            ],
                          )),
                          SingleChildScrollView(
                              child: Column(
                            children: <Widget>[
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller: this._towCustomerController,
                                    decoration: new InputDecoration(
                                      labelText: "Customer *",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select Tow Customer';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () => {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new TowCustomersModal(
                                                      setTowCustomer:
                                                          setTowCustomer)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: _isFormReadOnly,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  maxLines: 4,
                                  maxLength: 512,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller:
                                      _dispatchInstructions_stringController,
                                  decoration: new InputDecoration(
                                    labelText: "Instructions",
                                  ),
                                  onTap: () => {
                                    _dispatchInstructions_stringController
                                            .selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _dispatchInstructions_stringController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.dispatchInstructions_string = val,
                                  // setState(() => {
                                  //       _call.dispatchInstructions_string = val
                                  //     }),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _dispatchContactController,
                                  decoration: new InputDecoration(
                                    labelText: "Contact",
                                  ),
                                  onTap: () => {
                                    _dispatchContactController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _dispatchContactController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.dispatchContact = val,
                                  // setState(
                                  //     () => _call.dispatchContact = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  keyboardType: TextInputType.number,
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _dispatchContactPhoneController,
                                  decoration: new InputDecoration(
                                    labelText: "Contact Phone",
                                  ),
                                  validator: (value) {
                                    if (value.length > 1 && value.length < 10) {
                                      return 'Please enter a valid Contact Phone';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () => {
                                    _dispatchContactPhoneController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _dispatchContactPhoneController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.dispatchContactPhone = val,
                                  // setState(
                                  //     () => _call.dispatchContactPhone = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                    readOnly: true,
                                    enabled: !_isFormReadOnly,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    controller:
                                        this._vehiclePriorityTypeController,
                                    decoration: new InputDecoration(
                                      labelText: "Priority",
                                      suffixIcon: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                    onTap: () => {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new SystemPriorityModal(
                                                      setVehiclePriority:
                                                          setVehiclePriority)))
                                    }),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: _isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _dispatchETAMinutesController,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9.]"))
                                  ],
                                  decoration: new InputDecoration(
                                    labelText: "ETA",
                                  ),
                                  onTap: () => {
                                    _dispatchETAMinutesController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _dispatchETAMinutesController
                                                    .value.text.length)
                                  },
                                  onSaved: (val) => _call.dispatchETAMinutes = val,
                                  // setState(
                                  //     () => _call.dispatchETAMinutes = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: true,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _dispatchDateController,
                                  decoration: new InputDecoration(
                                    labelText: "Call Date",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _isFormReadOnly == false
                                            ? DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                //  minTime: DateTime(2018, 3, 5),
                                                //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                                                //   //print('change $date');
                                                // },
                                                onConfirm: (date) {
                                                String formattedDate =
                                                    DateFormat('MM-dd-yyyy')
                                                        .format(date);
                                                _dispatchDateController.text =
                                                    formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                              },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.en)
                                            : null;
                                      }, //_controller.clear(),
                                      icon: Icon(Icons.date_range, size: 14),
                                    ),
                                  ),
                                  onSaved: (val) =>_call.dispatchDate = val,
                                      // setState(() => _call.dispatchDate = val),
                                ),
                              ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchReceivedTimeController,
//                              decoration: new InputDecoration(
//                                labelText: "Received",
//                                suffixIcon: IconButton(
//                                  onPressed: () {
//                                    DatePicker.showTimePicker(context,
                              // showSecondsColumn: false,
//                                        showTitleActions: true,
//                                        //  minTime: DateTime(2018, 3, 5),
//                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//                                        //   //print('change $date');
//                                        // },
//                                        onConfirm: (time) {
//                                      String formattedTime =
//                                          DateFormat('HH:mm').format(time);
//                                      _dispatchReceivedTimeController.text =
//                                          formattedTime;
////                              String formattedTime = DateFormat('kk.mm').format(now);
////                              String formattedTime2 = DateFormat('kk^mm').format(now);
//                                    },
//                                        currentTime: DateTime.now(),
//                                        locale: LocaleType.en);
//                                  }, //_controller.clear(),
//                                  icon: Icon(Icons.access_time),
//                                ),
//                              ),
//                              onSaved: (val) => setState(
//                                  () => _call.dispatchReceivedTime = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchDispatchTimeController,
//                              decoration: new InputDecoration(
//                                labelText: "Dispatch",
//                                suffixIcon: IconButton(
//                                  onPressed: () {
//                                    DatePicker.showTimePicker(context,
                              //  showSecondsColumn: false,
//                                        showTitleActions: true,
//                                        //  minTime: DateTime(2018, 3, 5),
//                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//                                        //   //print('change $date');
//                                        // },
//                                        onConfirm: (time) {
//                                      String formattedTime =
//                                          DateFormat('HH:mm').format(time);
//                                      _dispatchDispatchTimeController.text =
//                                          formattedTime;
////                              String formattedTime = DateFormat('kk.mm').format(now);
////                              String formattedTime2 = DateFormat('kk^mm').format(now);
//                                    },
//                                        currentTime: DateTime.now(),
//                                        locale: LocaleType.en);
//                                  }, //_controller.clear(),
//                                  icon: Icon(Icons.access_time),
//                                ),
//                              ),
//                              onSaved: (val) => setState(
//                                  () => _call.dispatchDispatchTime = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchEnrouteTimeController,
//                              decoration: new InputDecoration(
//                                labelText: "Enroute",
//                                suffixIcon: IconButton(
//                                  onPressed: () {
//                                    DatePicker.showTimePicker(context,
//                           showSecondsColumn: false,
//                                        showTitleActions: true,
//                                        //  minTime: DateTime(2018, 3, 5),
//                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//                                        //   //print('change $date');
//                                        // },
//                                        onConfirm: (time) {
//                                      String formattedTime =
//                                          DateFormat('HH:mm').format(time);
//                                      _dispatchEnrouteTimeController.text =
//                                          formattedTime;
////                              String formattedTime = DateFormat('kk.mm').format(now);
////                              String formattedTime2 = DateFormat('kk^mm').format(now);
//                                    },
//                                        currentTime: DateTime.now(),
//                                        locale: LocaleType.en);
//                                  }, //_controller.clear(),
//                                  icon: Icon(Icons.access_time),
//                                ),
//                              ),
//                              onSaved: (val) => setState(
//                                  () => _call.dispatchEnrouteTime = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchOnsiteTimeController,
//                              decoration: new InputDecoration(
//                                labelText: "Onsite",
//                                suffixIcon: IconButton(
//                                  onPressed: () {
//                                    DatePicker.showTimePicker(context,
//                           showSecondsColumn: false,
//                                        showTitleActions: true,
//                                        //  minTime: DateTime(2018, 3, 5),
//                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//                                        //   //print('change $date');
//                                        // },
//                                        onConfirm: (time) {
//                                      String formattedTime =
//                                          DateFormat('HH:mm').format(time);
//                                      _dispatchOnsiteTimeController.text =
//                                          formattedTime;
////                              String formattedTime = DateFormat('kk.mm').format(now);
////                              String formattedTime2 = DateFormat('kk^mm').format(now);
//                                    },
//                                        currentTime: DateTime.now(),
//                                        locale: LocaleType.en);
//                                  }, //_controller.clear(),
//                                  icon: Icon(Icons.access_time),
//                                ),
//                              ),
//                              onSaved: (val) => setState(
//                                  () => _call.dispatchOnsiteTime = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchRollingTimeController,
//                              decoration: new InputDecoration(
//                                labelText: "Rolling",
//                                suffixIcon: IconButton(
//                                  onPressed: () {
//                                    DatePicker.showTimePicker(context,
//                           showSecondsColumn: false,
//                                        showTitleActions: true,
//                                        //  minTime: DateTime(2018, 3, 5),
//                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//                                        //   //print('change $date');
//                                        // },
//                                        onConfirm: (time) {
//                                      String formattedTime =
//                                          DateFormat('HH:mm').format(time);
//                                      _dispatchRollingTimeController.text =
//                                          formattedTime;
////                              String formattedTime = DateFormat('kk.mm').format(now);
////                              String formattedTime2 = DateFormat('kk^mm').format(now);
//                                    },
//                                        currentTime: DateTime.now(),
//                                        locale: LocaleType.en);
//                                  }, //_controller.clear(),
//                                  icon: Icon(Icons.access_time),
//                                ),
//                              ),
//                              onSaved: (val) => setState(
//                                  () => _call.dispatchRollingTime = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchArrivedTimeController,
//                              decoration: new InputDecoration(
//                                labelText: "Arrived",
//                                suffixIcon: IconButton(
//                                  onPressed: () {
//                                    DatePicker.showTimePicker(context,
//                           showSecondsColumn: false,
//                                        showTitleActions: true,
//                                        //  minTime: DateTime(2018, 3, 5),
//                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//                                        //   //print('change $date');
//                                        // },
//                                        onConfirm: (time) {
//                                      String formattedTime =
//                                          DateFormat('HH:mm').format(time);
//                                      _dispatchArrivedTimeController.text =
//                                          formattedTime;
////                              String formattedTime = DateFormat('kk.mm').format(now);
////                              String formattedTime2 = DateFormat('kk^mm').format(now);
//                                    },
//                                        currentTime: DateTime.now(),
//                                        locale: LocaleType.en);
//                                  }, //_controller.clear(),
//                                  icon: Icon(Icons.access_time),
//                                ),
//                              ),
//                              onSaved: (val) => setState(
//                                  () => _call.dispatchArrivedTime = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchClearedTimeController,
//                              decoration: new InputDecoration(
//                                labelText: "Cleared",
//                                suffixIcon: IconButton(
//                                  onPressed: () {
//                                    DatePicker.showTimePicker(context,
//                           showSecondsColumn: false,
//                                        showTitleActions: true,
//                                        //  minTime: DateTime(2018, 3, 5),
//                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//                                        //   //print('change $date');
//                                        // },
//                                        onConfirm: (time) {
//                                      String formattedTime =
//                                          DateFormat('HH:mm').format(time);
//                                      _dispatchClearedTimeController.text =
//                                          formattedTime;
////                              String formattedTime = DateFormat('kk.mm').format(now);
////                              String formattedTime2 = DateFormat('kk^mm').format(now);
//                                    },
//                                        currentTime: DateTime.now(),
//                                        locale: LocaleType.en);
//                                  }, //_controller.clear(),
//                                  icon: Icon(Icons.access_time),
//                                ),
//                              ),
//                              onSaved: (val) => setState(
//                                  () => _call.dispatchClearedTime = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchIDController,
//                              decoration: new InputDecoration(
//                                labelText: "Dispatch Id",
//                              ),
//                              onSaved: (val) =>
//                                  setState(() => _call.dispatchID = val),
//                            ),
//                          ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: true,
                                  enabled: !_isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller: _dispatchResponseIDController,
                                  decoration: new InputDecoration(
                                    labelText: "Response Id",
                                  ),
                                  onSaved: (val) =>  _call.dispatchResponseID = val,
                                  // setState(
                                  //     () => _call.dispatchResponseID = val),
                                ),
                              ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: true,
                                  enabled: !_isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller:
                                      _dispatchAuthorizationNumberController,
                                  decoration: new InputDecoration(
                                    labelText: "Authorization #",
                                  ),
                                  onSaved: (val) => _call.dispatchAuthorizationNumber = val,
                                  // setState(() =>
                                  //     _call.dispatchAuthorizationNumber = val),
                                ),
                              ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchJobIDController,
//                              decoration: new InputDecoration(
//                                labelText: "Job Id",
//                              ),
//                              onSaved: (val) =>
//                                  setState(() => _call.dispatchJobID = val),
//                            ),
//                          ),
                              new ListTile(
                                title: new TextFormField(
                                  readOnly: true,
                                  enabled: !_isFormReadOnly,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  controller:
                                      _dispatchProviderResponseController,
                                  decoration: new InputDecoration(
                                    labelText: "Response Type",
                                  ),
                                  onSaved: (val) => _call.dispatchProviderResponse = val,
                                  // setState(() =>
                                  //     _call.dispatchProviderResponse = val),
                                ),
                              ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller:
//                                  _dispatchProviderSelectedResponseNameController,
//                              decoration: new InputDecoration(
//                                labelText: "Response Reason",
//                              ),
//                              onSaved: (val) => setState(() => _call
//                                  .dispatchProviderSelectedResponseName = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchRequestorResponseController,
//                              decoration: new InputDecoration(
//                                labelText: "Requestor Response",
//                              ),
//                              onSaved: (val) => setState(
//                                  () => _call.dispatchRequestorResponse = val),
//                            ),
//                          ),
//                          new ListTile(
//                            title: new TextFormField(
//                              controller: _dispatchETAMaximumController,
//                              decoration: new InputDecoration(
//                                labelText: "ETA Maximum",
//                              ),
//                              onSaved: (val) => setState(
//                                  () => _call.dispatchETAMaximum = val),
//                            ),
//                          ),
//                          ListTile(
//                            title:  Text('Confirm', style: new TextStyle(
//                                color: Colors.black54, fontSize: 16)),
//                            trailing:Checkbox(
//                              //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
//                              value: _call.dispatchAlarmConfirm != null ? _call.dispatchAlarmConfirm : false,
//                              onChanged: (bool val) {
//                                _call.dispatchAlarmConfirm = val;
//                                //noCharge
//                              },
//                            ),
//                          ),
//                          ListTile(
//                            title: Text('Cancel', style: new TextStyle(
//                                color: Colors.black54, fontSize: 16)),
//                            trailing:Checkbox(
//                              //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
//                              value: _call.dispatchCancel != null ? _call.dispatchCancel : false,
//                              onChanged: (bool val) {
//                                _call.dispatchCancel = val;
//                              },
//                            ),
//                          ),
                            ],
                          )),
//                      SingleChildScrollView(
//                          child: Column(
//                        children: <Widget>[
////                          new ListTile(
////                            title: new TextFormField(
////                                controller: this._bodyShopController,
////                                decoration: new InputDecoration(
////                                  labelText: "Body Shop",
////                                  suffixIcon: Icon(Icons.arrow_forward_ios),
////                                ),
////                                validator: (value) {
////                                  if (value.isEmpty) {
////                                    return 'Please select Body Shop';
////                                  }
////                                },
////                                onTap: () {
//////                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
////                                  Navigator.push(
////                                      context,
////                                      MaterialPageRoute(
////                                          builder: (context) =>
////                                              new TowCustomersModal(
////                                                  setTowCustomer:
////                                                      setBodyShop)));
////                                }),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              controller: _towedRONumberController,
////                              decoration: new InputDecoration(
////                                labelText: "RO #",
////                              ),
////                              onSaved: (val) =>
////                                  setState(() => _call.towedRONumber = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              controller: _bodyShopAtShopDateController,
////                              decoration: new InputDecoration(
////                                labelText: "At Shop",
////                                suffixIcon: IconButton(
////                                  onPressed: () {
////                                    DatePicker.showDatePicker(context,
////                                        showTitleActions: true,
////                                        //  minTime: DateTime(2018, 3, 5),
////                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
////                                        //   //print('change $date');
////                                        // },
////                                        onConfirm: (date) {
////                                      String formattedDate =
////                                          DateFormat('MM-dd-yyyy').format(date);
////                                      _bodyShopAtShopDateController.text =
////                                          formattedDate;
//////                              String formattedTime = DateFormat('kk.mm').format(now);
//////                              String formattedTime2 = DateFormat('kk^mm').format(now);
////                                    },
////                                        currentTime: DateTime.now(),
////                                        locale: LocaleType.en);
////                                  }, //_controller.clear(),
////                                  icon: Icon(Icons.date_range),
////                                ),
////                              ),
////                              onSaved: (val) => setState(
////                                  () => _call.bodyShopAtShopDate = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              controller: _bodyShopPendingDateController,
////                              decoration: new InputDecoration(
////                                labelText: "Pending",
////                                suffixIcon: IconButton(
////                                  onPressed: () {
////                                    DatePicker.showDatePicker(context,
////                                        showTitleActions: true,
////                                        //  minTime: DateTime(2018, 3, 5),
////                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
////                                        //   //print('change $date');
////                                        // },
////                                        onConfirm: (date) {
////                                      String formattedDate =
////                                          DateFormat('MM-dd-yyyy').format(date);
////                                      _bodyShopPendingDateController.text =
////                                          formattedDate;
//////                              String formattedTime = DateFormat('kk.mm').format(now);
//////                              String formattedTime2 = DateFormat('kk^mm').format(now);
////                                    },
////                                        currentTime: DateTime.now(),
////                                        locale: LocaleType.en);
////                                  }, //_controller.clear(),
////                                  icon: Icon(Icons.date_range),
////                                ),
////                              ),
////                              onSaved: (val) => setState(
////                                  () => _call.bodyShopPendingDate = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              controller: _bodyShopWorkingDate,
////                              decoration: new InputDecoration(
////                                labelText: "Working",
////                                suffixIcon: IconButton(
////                                  onPressed: () {
////                                    DatePicker.showDatePicker(context,
////                                        showTitleActions: true,
////                                        //  minTime: DateTime(2018, 3, 5),
////                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
////                                        //   //print('change $date');
////                                        // },
////                                        onConfirm: (date) {
////                                      String formattedDate =
////                                          DateFormat('MM-dd-yyyy').format(date);
////                                      _bodyShopWorkingDateController.text =
////                                          formattedDate;
//////                              String formattedTime = DateFormat('kk.mm').format(now);
//////                              String formattedTime2 = DateFormat('kk^mm').format(now);
////                                    },
////                                        currentTime: DateTime.now(),
////                                        locale: LocaleType.en);
////                                  }, //_controller.clear(),
////                                  icon: Icon(Icons.date_range),
////                                ),
////                              ),
////                              onSaved: (val) => setState(
////                                  () => _call.bodyShopWorkingDate = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              controller: _bodyShopTotaledDateController,
////                              decoration: new InputDecoration(
////                                labelText: "Totaled",
////                                suffixIcon: IconButton(
////                                  onPressed: () {
////                                    DatePicker.showDatePicker(context,
////                                        showTitleActions: true,
////                                        //  minTime: DateTime(2018, 3, 5),
////                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
////                                        //   //print('change $date');
////                                        // },
////                                        onConfirm: (date) {
////                                      String formattedDate =
////                                          DateFormat('MM-dd-yyyy').format(date);
////                                      _bodyShopTotaledDateController.text =
////                                          formattedDate;
//////                              String formattedTime = DateFormat('kk.mm').format(now);
//////                              String formattedTime2 = DateFormat('kk^mm').format(now);
////                                    },
////                                        currentTime: DateTime.now(),
////                                        locale: LocaleType.en);
////                                  }, //_controller.clear(),
////                                  icon: Icon(Icons.date_range),
////                                ),
////                              ),
////                              onSaved: (val) => setState(
////                                  () => _call.bodyShopTotaledDate = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              controller: _bodyShopMovedDateController,
////                              decoration: new InputDecoration(
////                                labelText: "Moved",
////                                suffixIcon: IconButton(
////                                  onPressed: () {
////                                    DatePicker.showDatePicker(context,
////                                        showTitleActions: true,
////                                        //  minTime: DateTime(2018, 3, 5),
////                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
////                                        //   //print('change $date');
////                                        // },
////                                        onConfirm: (date) {
////                                      String formattedDate =
////                                          DateFormat('MM-dd-yyyy').format(date);
////                                      _bodyShopMovedDateController.text =
////                                          formattedDate;
//////                              String formattedTime = DateFormat('kk.mm').format(now);
//////                              String formattedTime2 = DateFormat('kk^mm').format(now);
////                                    },
////                                        currentTime: DateTime.now(),
////                                        locale: LocaleType.en);
////                                  }, //_controller.clear(),
////                                  icon: Icon(Icons.date_range),
////                                ),
////                              ),
////                              onSaved: (val) =>
////                                  setState(() => _call.bodyShopMovedDate = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              controller: _bodyShopDriverTransferDateController,
////                              decoration: new InputDecoration(
////                                labelText: "Transfer Date",
////                                suffixIcon: IconButton(
////                                  onPressed: () {
////                                    DatePicker.showDatePicker(context,
////                                        showTitleActions: true,
////                                        //  minTime: DateTime(2018, 3, 5),
////                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
////                                        //   //print('change $date');
////                                        // },
////                                        onConfirm: (date) {
////                                      String formattedDate =
////                                          DateFormat('MM-dd-yyyy').format(date);
////                                      _bodyShopDriverTransferDateController
////                                          .text = formattedDate;
//////                              String formattedTime = DateFormat('kk.mm').format(now);
//////                              String formattedTime2 = DateFormat('kk^mm').format(now);
////                                    },
////                                        currentTime: DateTime.now(),
////                                        locale: LocaleType.en);
////                                  }, //_controller.clear(),
////                                  icon: Icon(Icons.date_range),
////                                ),
////                              ),
////                              onSaved: (val) => setState(
////                                  () => _call.bodyShopDriverTransferDate = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              keyboardType: TextInputType.number,
////                              controller:
////                                  _bodyShopDriverTransferAmountController,
////                              decoration: new InputDecoration(
////                                labelText: "Transfer Amount",
////                              ),
////                              onSaved: (val) => setState(() =>
////                                  _call.bodyShopDriverTransferAmount = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              controller: _bodyShopDriverRepairDateController,
////                              decoration: new InputDecoration(
////                                labelText: "Repair Date",
////                                suffixIcon: IconButton(
////                                  onPressed: () {
////                                    DatePicker.showDatePicker(context,
////                                        showTitleActions: true,
////                                        //  minTime: DateTime(2018, 3, 5),
////                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
////                                        //   //print('change $date');
////                                        // },
////                                        onConfirm: (date) {
////                                      String formattedDate =
////                                          DateFormat('MM-dd-yyyy').format(date);
////                                      _bodyShopDriverRepairDateController.text =
////                                          formattedDate;
//////                              String formattedTime = DateFormat('kk.mm').format(now);
//////                              String formattedTime2 = DateFormat('kk^mm').format(now);
////                                    },
////                                        currentTime: DateTime.now(),
////                                        locale: LocaleType.en);
////                                  }, //_controller.clear(),
////                                  icon: Icon(Icons.date_range),
////                                ),
////                              ),
////                              onSaved: (val) => setState(
////                                  () => _call.bodyShopDriverRepairDate = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              keyboardType: TextInputType.number,
////                              controller: _bodyShopDriverRepairAmountController,
////                              decoration: new InputDecoration(
////                                labelText: "Repair Amount",
////                              ),
////                              onSaved: (val) => setState(
////                                  () => _call.bodyShopDriverRepairAmount = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              controller: _bodyShopPaymentDateController,
////                              decoration: new InputDecoration(
////                                labelText: "Payment Date",
////                                suffixIcon: IconButton(
////                                  onPressed: () {
////                                    DatePicker.showDatePicker(context,
////                                        showTitleActions: true,
////                                        //  minTime: DateTime(2018, 3, 5),
////                                        //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
////                                        //   //print('change $date');
////                                        // },
////                                        onConfirm: (date) {
////                                      String formattedDate =
////                                          DateFormat('MM-dd-yyyy').format(date);
////                                      _bodyShopPaymentDateController.text =
////                                          formattedDate;
//////                              String formattedTime = DateFormat('kk.mm').format(now);
//////                              String formattedTime2 = DateFormat('kk^mm').format(now);
////                                    },
////                                        currentTime: DateTime.now(),
////                                        locale: LocaleType.en);
////                                  }, //_controller.clear(),
////                                  icon: Icon(Icons.date_range),
////                                ),
////                              ),
////                              onSaved: (val) => setState(
////                                  () => _call.bodyShopPaymentDate = val),
////                            ),
////                          ),
////                          new ListTile(
////                            title: new TextFormField(
////                              keyboardType: TextInputType.number,
////                              controller: _bodyShopPaymentAmountController,
////                              decoration: new InputDecoration(
////                                labelText: "Payment Amount",
////                              ),
////                              onSaved: (val) => setState(
////                                  () => _call.bodyShopPaymentAmount = val),
////                            ),
////                          ),
////                          ListTile(
////                            title: Text('Junk', style: new TextStyle(
////                                color: Colors.black54, fontSize: 16)),
////                            trailing: Checkbox(
////                              //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
////                              value: _call.junk != null ? _call.junk : false,
////                              onChanged: (bool val) {
////                                _call.junk = val;
////                              },
////                            ),
////                          ),
////                          ListTile(
////                            title: Text('Repairable', style: new TextStyle(
////                                color: Colors.black54, fontSize: 16)),
////                            trailing: Checkbox(
////                              //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
////                              value: _call.repairable != null ? _call.repairable : false,
////                              onChanged: (bool val) {
////                                _call.repairable = val;
////                              },
////                            ),
////                          ),
//                        ],
//                      )),
                          Column(children: <Widget>[
                            Expanded(
                                child: TowedVehicleNotesList(
                                    userRole: userRole,
                                    userId: userId
                                    ))
                          ]),

                          Column(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(5),
                                child:Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Table(
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                            child: Column(
                                              children: <Widget>[
                                                Text("SUB TOTAL",
                                                    style: new TextStyle(
                                                        color: Color(0xff6C89BA), fontSize: 11.0,  fontWeight:FontWeight.w800)),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 15, bottom:15),
                                                  child:
                                                  Text(x[0].towedSubTotal.toStringAsFixed(2)), ),
                                              ],
                                            )),
                                        TableCell(
                                            child: Column(
                                              children: <Widget>[
                                                Text("DISCOUNT",
                                                    style: new TextStyle(
                                                        color: Color(0xff6C89BA), fontSize: 11.0, fontWeight:FontWeight.w800)),
                                                Padding(
                                                    padding: EdgeInsets.only(top: 15),
                                                    child:
                                                    Text(x[0].towedDiscountTotal.toStringAsFixed(2))),
                                              ],
                                            )),
                                        TableCell(
                                            child: Column(
                                              children: <Widget>[
                                                Text("TAX",
                                                    style: new TextStyle(
                                                        color: Color(0xff6C89BA), fontSize: 11.0, fontWeight:FontWeight.w800)),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 15),
                                                  child: Text(x[0].towedTaxAmount.toStringAsFixed(2)),
                                                )
                                              ],
                                            )),
                                        TableCell(
                                            child: Column(
                                              children: <Widget>[
                                                Text("TOTAL",
                                                    style: new TextStyle(
                                                        color: Color(0xff6C89BA), fontSize: 11.0,  fontWeight:FontWeight.w800)),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 15),
                                                  child: Text(x[0].towedTotalAmount.toStringAsFixed(2)),
                                                )
                                              ],
                                            )),
                                        TableCell(
                                            child: Column(
                                              children: <Widget>[
                                                Text("BALANCE",
                                                    style: new TextStyle(
                                                        color:Color(0xff6C89BA), fontSize: 11.0,  fontWeight:FontWeight.w800)),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 15),
                                                  child: Text(x[0].towedBalance.toStringAsFixed(2)),
                                                )
                                              ],
                                            )),
                                      ])
                                    ],
                                  ),
                                )),
                            Expanded(
                                child: TowedVehicleChargesList(
                                    userRole: userRole, selectedCall: x[0], notifyParent:refresh))
                          ]),
                          Column(children: <Widget>[
                            Expanded(
                                child: PhotosList(
                                    userRole: userRole,
                                    userId: userId,
                                    ))
                          ]),
                        ])))));
  }
}
