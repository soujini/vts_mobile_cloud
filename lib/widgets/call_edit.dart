import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:vts_mobile_cloud/widgets/charges_add.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';

import 'package:vts_mobile_cloud/models/call.dart';
import 'package:vts_mobile_cloud/providers/calls_provider.dart';
import 'package:vts_mobile_cloud/widgets/authorization_modal.dart';
import 'package:vts_mobile_cloud/widgets/color_modal.dart';
import 'package:vts_mobile_cloud/widgets/license_type_modal.dart';
import 'package:vts_mobile_cloud/widgets/notes_add.dart';
import 'package:vts_mobile_cloud/widgets/system_city_modal.dart';
import 'package:vts_mobile_cloud/widgets/system_priority_modal.dart';
import 'package:vts_mobile_cloud/widgets/system_state_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_customers_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_jurisdiction_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_reason_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_trucks_modal.dart';
import 'package:vts_mobile_cloud/widgets/tow_type_modal.dart';
import 'package:vts_mobile_cloud/widgets/vehicleYearMakeModel_modal.dart';
import 'package:vts_mobile_cloud/widgets/vehicle_make_modal.dart';
import 'package:vts_mobile_cloud/widgets/vehicle_style_modal.dart';
import 'package:vts_mobile_cloud/widgets/wrecker_company_modal.dart';
import 'package:vts_mobile_cloud/widgets/wrecker_driver_modal.dart';
import 'package:vts_mobile_cloud/widgets/towed_vehicle_notes_list.dart';

import 'package:vts_mobile_cloud/widgets/tow_charges_modal.dart';

class CallEdit extends StatefulWidget {
  CallEdit() : super();

  @override
  _CallEditState createState() => _CallEditState();
}

class _CallEditState extends State<CallEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  final _call = Call();
  static const int PAGE_SIZE = 15;

//  Future<List> _refreshCallsList(BuildContext context) async {
//    return await Provider.of<TowedVehicleNotesVM>(context)
//        .listMini(0, PAGE_SIZE, "")
//        .catchError((onError) {
//      showDialog(
//          context: context,
//          builder: ((context) => AlertDialog(
//                title: Text("An error occured!"),
//                content:
//                    Text("Oops something went wrong " + onError.toString()),
//                actions: <Widget>[
//                  FlatButton(
//                    child: Text("OK"),
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                  )
//                ],
//              )));
//    });
//  }

  var _billToController = new TextEditingController();
  var _towedInvoiceController = new TextEditingController();
  var _dispatchMemberController = new TextEditingController();
  var _vinController = new TextEditingController();
  var _modelController = new TextEditingController();
  var _yearController = new TextEditingController();
  var _makeController = new TextEditingController();
  var _styleController = new TextEditingController();
  var _topColorController = new TextEditingController();
  var _secondColorController = new TextEditingController();
  var _licensePlateController = new TextEditingController();
  var _licenseStateController = new TextEditingController();
  var _licenseTypeController = new TextEditingController();
  var _towedTrailerController = new TextEditingController();
  var _towedTruckController = new TextEditingController();
  var _vehicleTitleController = new TextEditingController();
  var _vehicleOdomoeterController = new TextEditingController();
  var _towTypeController = new TextEditingController();
  var _towReasonController = new TextEditingController();
  var _authorizationController = new TextEditingController();
  var _jurisdictionController = new TextEditingController();
  var _towedStateController = new TextEditingController();
  var _companyController = new TextEditingController();
  var _driverController = new TextEditingController();
  var _truckController = new TextEditingController();
  var _towedStreetController = new TextEditingController();
  var _towedCityController = new TextEditingController();
  var _towedToStreetController = new TextEditingController();
  var _towedToCityController = new TextEditingController();
  var _towedToStateController = new TextEditingController();
  var _towedZipCodeController = new TextEditingController();
  var _towedStatusController = new TextEditingController();
  var _towedDateController = new TextEditingController();
  var _towedTimeController = new TextEditingController();
  var _wreckerDriverPaidController = new TextEditingController();
  var _wreckerDriverPaymentController = new TextEditingController();
  var _vehiclePriorityTypeController = new TextEditingController();
  var _towCustomerController = new TextEditingController();
  var _dispatchInstructions_stringController = new TextEditingController();
  var _dispatchContactController = new TextEditingController();
  var _dispatchContactPhoneController = new TextEditingController();
  var _dispatchDateController = new TextEditingController();
  var _dispatchReceivedTimeController = new TextEditingController();
  var _dispatchDispatchTimeController = new TextEditingController();
  var _dispatchRollingTimeController = new TextEditingController();
  var _dispatchArrivedTimeController = new TextEditingController();
  var _dispatchClearedTimeController = new TextEditingController();
  var _dispatchEnrouteTimeController = new TextEditingController();
  var _dispatchOnsiteTimeController = new TextEditingController();
  var _dispatchProviderResponseController = new TextEditingController();
  var _dispatchIDController = new TextEditingController();
  var _responseResponseIDController = new TextEditingController();
  var _dispatchAuthorizationNumberController = new TextEditingController();
  var _dispatchJobIDController = new TextEditingController();
  var _dispatchProviderSelectedResponseNameController =
      new TextEditingController();
  var _dispatchRequestorResponseController = new TextEditingController();
  var _dispatchETAMaximumController = new TextEditingController();
  var _bodyShopController = new TextEditingController();
  var _towedRONumberController = new TextEditingController();
  var _bodyShopAtShopDateController = new TextEditingController();
  var _bodyShopPendingDateController = new TextEditingController();
  var _bodyShopWorkingDateController = new TextEditingController();
  var _bodyShopWorkingDate = new TextEditingController();
  var _bodyShopTotaledDateController = new TextEditingController();
  var _bodyShopMovedDateController = new TextEditingController();
  var _bodyShopDriverTransferDateController = new TextEditingController();
  var _bodyShopDriverTransferAmountController = new TextEditingController();
  var _bodyShopDriverRepairDateController = new TextEditingController();
  var _bodyShopDriverRepairAmountController = new TextEditingController();
  var _bodyShopPaymentDateController = new TextEditingController();
  var _bodyShopPaymentAmountController = new TextEditingController();

  setBillTo(id, name) {
    setState(() {
      _call.billTo = id;
      _call.billToName = name;
      _billToController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setBodyShop(id, name) {
    setState(() {
      _call.bodyShop = id;
      _call.bodyShopName = name;
      _bodyShopController.value =
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

  setYearMakeModelName(yearMakeModelObj) {
    setMake(yearMakeModelObj.vehicleMake, yearMakeModelObj.vehicleMakeName);
    setVehicleYear(yearMakeModelObj.vehicleYear);
    setModel(yearMakeModelObj.id, yearMakeModelObj.vehicleModelName);
  }

  setLicenseStyle(id, name) {}

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

  setTowedToCity(id, name) {
    setState(() {
      _call.towedToCity = id;
      _call.towedToCityName = name;
      _towedToCityController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  setTowedToState(id, name) {
    setState(() {
      _call.towedToState = id;
      _call.towedToStateName = name;
      _towedToStateController.value =
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

  setVehiclePriority(id, name) {
    setState(() {
      _call.dispatchPriorityLevel = id;
      _call.dispatchPriorityLevelName = name;
      _vehiclePriorityTypeController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var id = Provider.of<Calls>(context).id;
    // TODO: implement build
    return DefaultTabController(
        length: 7,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.green,
                labelColor: Colors.white,
//              unselectedLabelColor: Colors.blueGrey,
                tabs: [
                  Tab(
                    icon: Icon(Icons.monetization_on),
                    text: "BILLING",
                  ),
                  Tab(
                    icon: Icon(Icons.directions_car),
                    text: "VEHICLE",
                  ),
                  Tab(
                    icon: Icon(Icons.departure_board),
                    text: "TOW",
                  ),
                  Tab(
                    icon: Icon(Icons.call_received),
                    text: "CALL",
                  ),
                  Tab(
                    icon: Icon(Icons.build),
                    text: "SHOP",
                  ),
                  Tab(
                    icon: Icon(Icons.note_add),
                    text: "Notes",
                  ),
                  Tab(
                    icon: Icon(Icons.attach_money),
                    text: "Charges",
                  ),
                ],
              ),
              // automaticallyImplyLeading: true,
              title: Text('Edit Call'),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.update),
                  tooltip: 'Update Status',
                  //onPressed: () => save(),
                ),
                new IconButton(
                  icon: new Icon(Icons.check),
                  tooltip: 'Save',
                  //onPressed: () => save(),
                ),
                new IconButton(
                  icon: new Icon(Icons.attach_money),
                  tooltip: 'Add Charges',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChargesAdd();
                        });
                    // showDialogUpdateStatus(context);
                  },
                ),
                new IconButton(
                  icon: new Icon(Icons.note_add),
                  tooltip: 'Add Notes',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NotesAdd();
                        });
                    // showDialogUpdateStatus(context);
                  },
                  //onPressed: () => save(),
                ),
                new IconButton(
                  icon: new Icon(Icons.camera_alt),
                  tooltip: 'Add Photo',
                  //onPressed: () => save(),
                ),
                new IconButton(
                  icon: new Icon(Icons.more_vert),
                  tooltip: 'More',
                  //onPressed: () => save(),
                ),
              ],
            ),
            body: Padding(
                padding: EdgeInsets.all(10.0),
                child: Form(
                    key: this._formKey,
                    child: TabBarView(children: [
                      SingleChildScrollView(
                          child: Column(
                        children: <Widget>[
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("charge ****"),
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
                                          builder: (context) =>
                                          new TowChargesModal(
                                              setTowCharge: setBillTo)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                          builder: (context) =>
                                              new TowCustomersModal(
                                                  setTowCustomer: setBillTo)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                              onSaved: (val) =>
                                  setState(() => _call.towedInvoice = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                              onSaved: (val) =>
                                  setState(() => _call.towedPONumber = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Member #"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchMemberController,
                              decoration: new InputDecoration(
                                hintText: "Member #",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Member #';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val) => setState(
                                  () => _call.dispatchMemberNumber = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Limit"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                hintText: "Limit",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Limit';
                                }
                              },
                              onSaved: (val) => setState(
                                  () => _call.dispatchLimitAmount = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Limit Miles"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                hintText: "Limit Miles",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Limit Miles';
                                }
                              },
                              onSaved: (val) => setState(
                                  () => _call.dispatchLimitMiles = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Discount Rate"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                hintText: "Discount Rate",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Discount Rate';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _call.towedDiscountRate = val),
                            ),
                          ),
                          ListTile(
                            title: const Text('No Charge'),
                            trailing: Radio(
                                //value: SingingCharacter.lafayette,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() { _character = value; });
//                                },
                                ),
                          ),
                        ],
                      )),
                      SingleChildScrollView(
                          child: Column(
                        children: <Widget>[
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("VIN *"),
                            ),
                            title: new TextFormField(
                              controller: _vinController,
                              decoration: new InputDecoration(
                                hintText: "VIN",
                                suffixIcon: IconButton(
                                  //onPressed: () => _getVIN(), //_controller.clear(),
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
                              width: 100,
                              // can be whatever value you want
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
                              width: 100,
                              // can be whatever value you want
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
                              width: 100,
                              // can be whatever value you want
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
                                              new VehicleMakeModal(
                                                  setMake: setMake)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                              new VehicleStyleModal(
                                                  setStyle: setStyle)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                          builder: (context) => new ColorModal(
                                              setColor: setTopColor)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                          builder: (context) => new ColorModal(
                                              setColor: setSecondColor)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                              width: 100,
                              // can be whatever value you want
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
                                          builder: (context) =>
                                              new SystemStateModal(
                                                  setSystemState:
                                                      setLicenseState)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("License Style"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                                controller: this._licenseTypeController,
                                decoration: new InputDecoration(
                                  hintText: "License Type",
                                  suffixIcon: Icon(Icons.arrow_forward_ios),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please select License Type';
                                  }
                                },
                                onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new LicenseTypeModal(
                                                  setLicenseStyle:
                                                      setLicenseStyle)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Expiration"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                                controller: this._yearController,
                                decoration: new InputDecoration(
                                  hintText: "Expiration",
                                  suffixIcon: Icon(Icons.arrow_forward_ios),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Expiration Year';
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
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Trailer #"),
                            ),
                            title: new TextFormField(
                              controller: _towedTrailerController,
                              decoration: new InputDecoration(
                                hintText: "Trailer #",
                                suffixIcon: IconButton(
                                  //onPressed: () => _getVIN(), //_controller.clear(),
                                  icon: Icon(Icons.autorenew),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Trailer #';
                                }
                              },
                              onSaved: (val) => setState(
                                  () => _call.towedTrailerNumber = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Truck #"),
                            ),
                            title: new TextFormField(
                              controller: _towedTrailerController,
                              decoration: new InputDecoration(
                                hintText: "Truck #",
                                suffixIcon: IconButton(
                                  //onPressed: () => _getVIN(), //_controller.clear(),
                                  icon: Icon(Icons.autorenew),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Truck #';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _call.towedTruckNumber = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Title"),
                            ),
                            title: new TextFormField(
                              controller: _vehicleTitleController,
                              decoration: new InputDecoration(
                                hintText: "Title",
                                suffixIcon: IconButton(
                                  //onPressed: () => _getVIN(), //_controller.clear(),
                                  icon: Icon(Icons.autorenew),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Title';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _call.vehicleTitle = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Odomoeter"),
                            ),
                            title: new TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _vehicleTitleController,
                              decoration: new InputDecoration(
                                hintText: "Odometer",
                                suffixIcon: IconButton(
                                  //onPressed: () => _getVIN(), //_controller.clear(),
                                  icon: Icon(Icons.autorenew),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Title';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _call.vehicleOdometer = val),
                            ),
                          ),
                        ],
                      )),
                      SingleChildScrollView(
                          child: Column(
                        children: <Widget>[
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                              new TowTypeModal(
                                                  setTowType: setTowType)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                          builder: (context) =>
                                              new TowReasonModal(
                                                  setTowReason: setTowReason)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                          builder: (context) =>
                                              new TowAuthorizationModal(
                                                  setAuthorization:
                                                      setAuthorization)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                          builder: (context) =>
                                              new TowJurisdictionModal(
                                                  setJurisdiction:
                                                      setJurisdiction)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                              onSaved: (val) =>
                                  setState(() => _call.towedDate = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                              onSaved: (val) =>
                                  setState(() => _call.towedTime = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                              onSaved: (val) =>
                                  setState(() => _call.towedStreet = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Street"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _towedStreetController,
                              decoration: new InputDecoration(
                                hintText: "Location",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter StreetTwo';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _call.towedStreet = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                              new SystemCityModal(
                                                  setCity: setCity)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                          builder: (context) =>
                                              new SystemStateModal(
                                                  setSystemState:
                                                      setTowedState)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Zip Code"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _towedZipCodeController,
                              decoration: new InputDecoration(
                                hintText: "Zip Code",
                              ),
                              onSaved: (val) =>
                                  setState(() => _call.towedToZipCode = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Destination"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _towedToStreetController,
                              decoration: new InputDecoration(
                                hintText: "Destination",
                              ),
                              onSaved: (val) =>
                                  setState(() => _call.towedToStreet = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Street"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _towedStreetController,
                              decoration: new InputDecoration(
                                hintText: "Location",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter StreetTwo';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _call.towedToStreetTwo = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("City"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                                controller: this._towedToCityController,
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
                                              new SystemCityModal(
                                                  setCity: setTowedToCity)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("State"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                                controller: this._towedToStateController,
                                decoration: new InputDecoration(
                                  hintText: "State",
                                  suffixIcon: Icon(Icons.arrow_forward_ios),
                                ),
                                onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new SystemStateModal(
                                                  setSystemState:
                                                      setTowedToState)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Zip Code"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _towedZipCodeController,
                              decoration: new InputDecoration(
                                hintText: "Zip Code",
                              ),
                              onSaved: (val) =>
                                  setState(() => _call.towedZipCode = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                          builder: (context) =>
                                              new WreckerCompanyModal(
                                                  setCompany: setCompany)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                              width: 100,
                              // can be whatever value you want
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
                                          builder: (context) =>
                                              new WreckerDriverModal(
                                                  setDriver: setDriver)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
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
                                              new TowTrucksModal(
                                                  setTruck: setTruck)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Driver Paid"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _wreckerDriverPaidController,
                              decoration: new InputDecoration(
                                hintText: "Driver Paid",
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
                              onSaved: (val) =>
                                  setState(() => _call.wreckerDriverPaid = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Driver Payment"),
                            ),
                            title: new TextFormField(
                              controller: _wreckerDriverPaymentController,
                              decoration: new InputDecoration(
                                hintText: "Driver Payment",
                                suffixIcon: IconButton(
                                  //onPressed: () => _getVIN(), //_controller.clear(),
                                  icon: Icon(Icons.autorenew),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter VIN';
                                }
                              },
                              onSaved: (val) => setState(
                                  () => _call.wreckerDriverPayment = val),
                            ),
                          ),
                          ListTile(
                            title: const Text('Bonus'),
                            trailing: Radio(
                                //value: SingingCharacter.lafayette,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() { _character = value; });
//                                },
                                ),
                          ),
                          ListTile(
                            title: const Text('No Commission'),
                            trailing: Radio(
                                //value: SingingCharacter.lafayette,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() { _character = value; });
//                                },
                                ),
                          ),
                        ],
                      )),
                      SingleChildScrollView(
                          child: Column(
                        children: <Widget>[
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Customer"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _towCustomerController,
                              decoration: new InputDecoration(
                                hintText: "Customer",
                              ),
                              onSaved: (val) =>
                                  setState(() => _call.towCustomerName = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Instructions"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller:
                                  _dispatchInstructions_stringController,
                              decoration: new InputDecoration(
                                hintText: "Instructions",
                              ),
                              onSaved: (val) => setState(() =>
                                  _call.dispatchInstructions_string = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Contact"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchContactController,
                              decoration: new InputDecoration(
                                hintText: "Instructions",
                              ),
                              onSaved: (val) =>
                                  setState(() => _call.dispatchContact = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Contact Phone"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchContactPhoneController,
                              decoration: new InputDecoration(
                                hintText: "Contact Phone",
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchContactPhone = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Priority"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                                controller: this._vehiclePriorityTypeController,
                                decoration: new InputDecoration(
                                  hintText: "Priority",
                                  suffixIcon: Icon(Icons.arrow_forward_ios),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please select Vehicle Priority';
                                  }
                                },
                                onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new SystemPriorityModal(
                                                  setVehiclePriority:
                                                      setVehiclePriority)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("ETA"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchContactController,
                              decoration: new InputDecoration(
                                hintText: "ETA",
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchETAMinutes = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Towed Date"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchDateController,
                              decoration: new InputDecoration(
                                hintText: "Call Date",
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
                                      _dispatchDateController.text =
                                          formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.date_range),
                                ),
                              ),
                              onSaved: (val) =>
                                  setState(() => _call.dispatchDate = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Received"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchReceivedTimeController,
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
                                      _dispatchReceivedTimeController.text =
                                          formattedTime;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.access_time),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchReceivedTime = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Dispatch"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchDispatchTimeController,
                              decoration: new InputDecoration(
                                hintText: "Dispatch",
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
                                      _dispatchDispatchTimeController.text =
                                          formattedTime;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.access_time),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchDispatchTime = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Enroute"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchEnrouteTimeController,
                              decoration: new InputDecoration(
                                hintText: "Enroute",
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
                                      _dispatchEnrouteTimeController.text =
                                          formattedTime;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.access_time),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchEnrouteTime = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Onsite"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchOnsiteTimeController,
                              decoration: new InputDecoration(
                                hintText: "Onsite",
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
                                      _dispatchOnsiteTimeController.text =
                                          formattedTime;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.access_time),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchOnsiteTime = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Rolling"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchRollingTimeController,
                              decoration: new InputDecoration(
                                hintText: "Rolling",
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
                                      _dispatchRollingTimeController.text =
                                          formattedTime;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.access_time),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchRollingTime = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Arrived"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchArrivedTimeController,
                              decoration: new InputDecoration(
                                hintText: "Arrived",
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
                                      _dispatchArrivedTimeController.text =
                                          formattedTime;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.access_time),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchArrivedTime = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Cleared"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchClearedTimeController,
                              decoration: new InputDecoration(
                                hintText: "Cleared",
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
                                      _dispatchClearedTimeController.text =
                                          formattedTime;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.access_time),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchClearedTime = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Dispatch Id"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchIDController,
                              decoration: new InputDecoration(
                                hintText: "Dispatch Id",
                              ),
                              onSaved: (val) =>
                                  setState(() => _call.dispatchID = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Response Id"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _responseResponseIDController,
                              decoration: new InputDecoration(
                                hintText: "Response Id",
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchResponseID = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Authorization #"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller:
                                  _dispatchAuthorizationNumberController,
                              decoration: new InputDecoration(
                                hintText: "Authorization #",
                              ),
                              onSaved: (val) => setState(() =>
                                  _call.dispatchAuthorizationNumber = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Job Id"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchJobIDController,
                              decoration: new InputDecoration(
                                hintText: "Job Id",
                              ),
                              onSaved: (val) =>
                                  setState(() => _call.dispatchJobID = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Response Type"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchProviderResponseController,
                              decoration: new InputDecoration(
                                hintText: "Response Type",
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchProviderResponse = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Response Reason"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller:
                                  _dispatchProviderSelectedResponseNameController,
                              decoration: new InputDecoration(
                                hintText: "Response Reason",
                              ),
                              onSaved: (val) => setState(() => _call
                                  .dispatchProviderSelectedResponseName = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Requestor Response"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchRequestorResponseController,
                              decoration: new InputDecoration(
                                hintText: "Requestor Response",
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchRequestorResponse = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("ETA Maximum"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _dispatchETAMaximumController,
                              decoration: new InputDecoration(
                                hintText: "ETA Maximum",
                              ),
                              onSaved: (val) => setState(
                                  () => _call.dispatchETAMaximum = val),
                            ),
                          ),
                          ListTile(
                            title: const Text('Confirm'),
                            trailing: Radio(
                                //value: SingingCharacter.lafayette,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() { dispatchAlarmConfirm = value; });
//                                },
                                ),
                          ),
                          ListTile(
                            title: const Text('Cancel'),
                            trailing: Radio(
                                //value: SingingCharacter.lafayette,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() { dispatchCancel = value; });
//                                },
                                ),
                          ),
                        ],
                      )),
                      SingleChildScrollView(
                          child: Column(
                        children: <Widget>[
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Body Shop"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                                controller: this._bodyShopController,
                                decoration: new InputDecoration(
                                  hintText: "Body Shop",
                                  suffixIcon: Icon(Icons.arrow_forward_ios),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please select Body Shop';
                                  }
                                },
                                onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              new TowCustomersModal(
                                                  setTowCustomer:
                                                      setBodyShop)));
                                }),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("RO #"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _towedRONumberController,
                              decoration: new InputDecoration(
                                hintText: "RO #",
                              ),
                              onSaved: (val) =>
                                  setState(() => _call.towedRONumber = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("At Shop"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _bodyShopAtShopDateController,
                              decoration: new InputDecoration(
                                hintText: "At Shop",
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
                                      _bodyShopAtShopDateController.text =
                                          formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.date_range),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.bodyShopAtShopDate = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Pending"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _bodyShopPendingDateController,
                              decoration: new InputDecoration(
                                hintText: "Pending",
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
                                      _bodyShopPendingDateController.text =
                                          formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.date_range),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.bodyShopPendingDate = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Working"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _bodyShopWorkingDate,
                              decoration: new InputDecoration(
                                hintText: "Working",
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
                                      _bodyShopWorkingDateController.text =
                                          formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.date_range),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.bodyShopWorkingDate = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Totaled"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _bodyShopTotaledDateController,
                              decoration: new InputDecoration(
                                hintText: "Totaled",
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
                                      _bodyShopTotaledDateController.text =
                                          formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.date_range),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.bodyShopTotaledDate = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Moved"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _bodyShopMovedDateController,
                              decoration: new InputDecoration(
                                hintText: "Moved",
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
                                      _bodyShopMovedDateController.text =
                                          formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.date_range),
                                ),
                              ),
                              onSaved: (val) =>
                                  setState(() => _call.bodyShopMovedDate = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Transfer Date"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _bodyShopDriverTransferDateController,
                              decoration: new InputDecoration(
                                hintText: "Transfer Date",
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
                                      _bodyShopDriverTransferDateController
                                          .text = formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.date_range),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.bodyShopDriverTransferDate = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Transfer Amount"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              keyboardType: TextInputType.number,
                              controller:
                                  _bodyShopDriverTransferAmountController,
                              decoration: new InputDecoration(
                                hintText: "Transfer Amount",
                              ),
                              onSaved: (val) => setState(() =>
                                  _call.bodyShopDriverTransferAmount = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Repair Date"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _bodyShopDriverRepairDateController,
                              decoration: new InputDecoration(
                                hintText: "Repair Date",
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
                                      _bodyShopDriverRepairDateController.text =
                                          formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.date_range),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.bodyShopDriverRepairDate = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Repair Amount"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _bodyShopDriverRepairAmountController,
                              decoration: new InputDecoration(
                                hintText: "Repair Amount",
                              ),
                              onSaved: (val) => setState(
                                  () => _call.bodyShopDriverRepairAmount = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Payment Date"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              controller: _bodyShopPaymentDateController,
                              decoration: new InputDecoration(
                                hintText: "Payment Date",
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
                                      _bodyShopPaymentDateController.text =
                                          formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  }, //_controller.clear(),
                                  icon: Icon(Icons.date_range),
                                ),
                              ),
                              onSaved: (val) => setState(
                                  () => _call.bodyShopPaymentDate = val),
                            ),
                          ),
                          new ListTile(
                            leading: Container(
                              width: 100,
                              // can be whatever value you want
                              alignment: Alignment.centerLeft,
                              child: Text("Payment Amount"),
                            ),
                            //trailing: Icon(Icons.shopping_cart),
                            title: new TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _bodyShopPaymentAmountController,
                              decoration: new InputDecoration(
                                hintText: "Payment Amount",
                              ),
                              onSaved: (val) => setState(
                                  () => _call.bodyShopPaymentAmount = val),
                            ),
                          ),
                          ListTile(
                            title: const Text('Junk'),
                            trailing: Radio(//junk
                                //value: SingingCharacter.lafayette,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() { _character = value; });
//                                },
                                ),
                          ),
                          ListTile(
                            title: const Text('Repairable'),
                            trailing: Radio(//repairable
                                //value: SingingCharacter.lafayette,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() { _character = value; });
//                                },
                                ),
                          ),
                        ],
                      )),
                      SingleChildScrollView(
                           child:Column(children: <Widget>[
                             Container(
                                child:TowedVehicleNotesList()),
                      ])),
                      SingleChildScrollView(
                          child: Column(children: <Widget>[])),
                    ])))));
  }


}
