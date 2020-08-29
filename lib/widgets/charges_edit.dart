import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/providers/calls_provider.dart';
import 'package:vts_mobile_cloud/providers/processTowedVehicle_provider.dart';
import 'package:vts_mobile_cloud/screens/add_edit_call.dart';
import 'package:vts_mobile_cloud/widgets/tow_charges_modal.dart';
import '../providers/towedVehicleCharges_provider.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';

class ChargesEdit extends StatefulWidget {
  bool isLoading =false;

  @override
  State<StatefulWidget> createState() {
    return _ChargesEditState();
  }
}

class _ChargesEditState extends State<ChargesEdit> {
  final _formKey = GlobalKey<FormState>();
  var _charge = TowedVehicleCharge();
  var _enableDiscountApply = false;

  var _towChargesController = new TextEditingController();
  var _chargesQuantityController = new TextEditingController();
  var _discountQuantityController = new TextEditingController();
  var _chargesRateController = new TextEditingController();
  var _discountRateController = new TextEditingController();
  var _totalChargesController = new TextEditingController();

  getValues() {
    enableDisableDiscount();
    _charge = Provider.of<TowedVehicleChargesVM>(context, listen: false)
        .selectedCharge;

    setState(() {
      _towChargesController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _charge.towChargesName))
          .value;
      _chargesQuantityController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _charge.chargesQuantity))
          .value;
      _discountQuantityController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _charge.discountQuantity))
          .value;
      _chargesRateController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _charge.chargesRate))
          .value;
      _discountRateController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _charge.discountRate))
          .value;
      _totalChargesController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: _charge.totalCharges))
          .value;
    });
  }

  enableDisableDiscount() {
    var _selectedCall = Provider.of<Calls>(context, listen: false).callDetails;
    var storageStatus = _selectedCall[0].storageStatus;
    var towedStatus = _selectedCall[0].towedStatus;
    if (storageStatus != 2 && towedStatus != 'X') {
      _enableDiscountApply = true;
    } else {
      _enableDiscountApply = false;
    }
  }

//  setTowCharge(id, name) {
//    getAndSetDefaultCharges(id);
//    setState(() {
//      _charge.towCharges = id;
//      _towChargesController.value =
//          new TextEditingController.fromValue(new TextEditingValue(text: name))
//              .value;
//    });
//    _formKey.currentState.validate();
//  }

  getAndSetDefaultCharges(towCharges) async {
    var selectedCall = Provider.of<Calls>(context, listen: false).callDetails;
    var towCustomer = selectedCall[0].towCustomer;
    var towType = selectedCall[0].towType;

    enableDisableDiscount();

    await Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
        .getDefaultCharges(towCharges, towCustomer, towType);
    var defaultCharges =
        Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
            .defaultCharges[0];
    setState(() {
      _charge.chargesQuantity = defaultCharges.chargesQuantity;
      _charge.discountQuantity = defaultCharges.discountQuantity;
      _charge.chargesRate = defaultCharges.chargesRate;

      _chargesQuantityController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: defaultCharges.chargesQuantity))
          .value;
      _discountQuantityController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: defaultCharges.discountQuantity))
          .value;
      _chargesRateController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: defaultCharges.chargesRate))
          .value;
    });
  }

  save() async {
    this.setState(() {
      widget.isLoading=true;
    });
    final form = _formKey.currentState;
    var selectedCall = Provider.of<Calls>(context, listen: false).selectedCall;
    _charge.towedVehicle = selectedCall.id;

    form.save();
    await Provider.of<TowedVehicleChargesVM>(context, listen: false)
        .update(_charge)
        .then((res) {
      this.setState(() {
        widget.isLoading=false;
      });
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new AddEditCallScreen(5)));
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedCharge =
        Provider.of<TowedVehicleChargesVM>(context, listen: false)
            .selectedCharge;
    getValues();
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('EDIT CHARGES', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
        ),
        body: widget.isLoading == true? Center(child:Loader()):Container(
            child: SingleChildScrollView(
                // child: AlertDialog(
                //content:
                child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
              ),
              new ListTile(
                title: new TextFormField(
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  enabled: false,
                  controller: this._towChargesController,
                  decoration: new InputDecoration(
                    labelText: 'Charge',
                  ),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  controller: this._chargesQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: 'Quantity',
                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter Charges';
//                    }
                  //  },
                  onSaved: (val) =>
                      setState(() => _charge.chargesQuantity = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  controller: this._discountQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: 'Discount Quantity',
                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter Charges';
//                    }
                  //  },
                  onSaved: (val) =>
                      setState(() => _charge.discountQuantity = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.number,
                  controller: _chargesRateController,
                  decoration: new InputDecoration(
                    labelText: 'Rate',
                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter Charges';
//                    }
                  //  },
                  onSaved: (val) => setState(() => _charge.chargesRate = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  enabled: false,
                  keyboardType: TextInputType.number,
                  controller: _discountRateController,
                  decoration: new InputDecoration(
                    labelText: 'Discount',
                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter Charges';
//                    }
                  //  },
                  onSaved: (val) => setState(() => _charge.discountRate = val),
                ),
              ),
              new ListTile(
                leading: Text('Apply',
                    style: new TextStyle(color: Colors.black54, fontSize: 16)),
                trailing: Checkbox(
                  //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
                  value: selectedCharge.discountApply,
                  onChanged: _enableDiscountApply
                      ? (val) {
                          setState(() {
                            _charge.discountApply = val;
                          });
                        }
                      : null,
                ),
              ),
              new ListTile(
                leading: Text('Taxable',
                    style: new TextStyle(color: Colors.black54, fontSize: 16)),
                trailing: Checkbox(
                  //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
                  //value: selectedCharge.chargesTaxable,
                  value: false,
                  onChanged: (bool val) {
                    setState(() {
                      _charge.chargesTaxable = val;
                    });
                  },
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  enabled: false,
                  keyboardType: TextInputType.number,
                  controller: _totalChargesController,
                  decoration: new InputDecoration(
                    labelText: 'Total Charges',
                  ),
//                   onSaved: (val) => setState(() => _charge.totalCharges = val),
                ),
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Color(0xff1c3764))
                  ),
                  color: Color(0xff1c3764),
                  textColor: Colors.white,
                  onPressed: () => save(),
                  child: Text('SAVE')),
            ],
          ),
        ))));
  }
}
