import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/widgets/tow_charges_modal.dart';
import '../providers/towedVehicleCharges_provider.dart';

class ChargesEdit extends StatefulWidget {
//  UpdateStatus(this.id, this.dispatchStatusName, this.dispatchInstructions_string);

  @override
  State<StatefulWidget> createState() {
    return _ChargesEditState();
  }
}

class _ChargesEditState extends State<ChargesEdit> {
  final _formKey = GlobalKey<FormState>();

  var _towChargesNameController = new TextEditingController();
  var _chargesQuantityController = new TextEditingController();
  var _discountQuantityController = new TextEditingController();
  var _chargesRateController = new TextEditingController();
  var _discountRateController = new TextEditingController();
  var _discountApplyController = new TextEditingController();
  var _chargesTaxableController = new TextEditingController();
  var _totalChargesController = new TextEditingController();

  getValues() {
    var selectedCharge =
        Provider.of<TowedVehicleChargesVM>(context, listen:false).selectedCharge;
    setState(() {
//      _call.billTo = id;
//      _call.billToName = name;
      _towChargesNameController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: selectedCharge.towChargesName))
          .value;
      _chargesQuantityController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: selectedCharge.chargesQuantity))
          .value;
      _discountQuantityController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: selectedCharge.discountQuantity))
          .value;
      _chargesRateController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: selectedCharge.chargesRate))
          .value;
      _discountRateController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: selectedCharge.discountRate))
          .value;
      _totalChargesController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: selectedCharge.totalCharges))
          .value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedCharge =
        Provider.of<TowedVehicleChargesVM>(context, listen:false).selectedCharge;
    getValues();
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('Edit Charge'),
        ),
        body: Container(
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
                    controller: this._towChargesNameController,
                    //  controller: this._modelController,
                    decoration: new InputDecoration(
                      labelText: 'Charge',
                      suffixIcon: Icon(Icons.arrow_forward_ios),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select VehicleCharge';
                      }
                    },
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new TowChargesModal(
                                  setTowCharge: setTowCharge)));
                    }),
              ),
              new ListTile(
                title: new TextFormField(
                  controller: this._chargesQuantityController,
                  keyboardType: TextInputType.number,
                  // controller: _vinController,
                  decoration: new InputDecoration(
                    labelText: 'Quantity',
//                    suffixIcon: IconButton(
//                      //onPressed: () => _getVIN(), //_controller.clear(),
//                      icon: Icon(Icons.autorenew),
//                    ),
                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter Charges';
//                    }
                  //  },
                  // onSaved: (val) => setState(() => _call.VIN = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  controller: this._discountQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: 'Discount Quantity',
//                    suffixIcon: IconButton(
//                      //onPressed: () => _getVIN(), //_controller.clear(),
//                      icon: Icon(Icons.autorenew),
//                    ),
                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter Charges';
//                    }
                  //  },
                  // onSaved: (val) => setState(() => _call.VIN = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _chargesRateController,
                  decoration: new InputDecoration(
                    labelText: 'Rate',
//                    suffixIcon: IconButton(
//                      //onPressed: () => _getVIN(), //_controller.clear(),
//                      icon: Icon(Icons.autorenew),
//                    ),
                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter Charges';
//                    }
                  //  },
                  // onSaved: (val) => setState(() => _call.VIN = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
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
                  // onSaved: (val) => setState(() => _call.VIN = val),
                ),
              ),
              new ListTile(
                leading: Text('Apply',
                    style: new TextStyle(color: Colors.black54, fontSize: 16)),
                trailing: Checkbox(
                  //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
                  value: selectedCharge.discountApply,
                  onChanged: (bool val) {
                    //noCharge
                  },
                ),
              ),
              new ListTile(
                leading: Text('Taxable',
                    style: new TextStyle(color: Colors.black54, fontSize: 16)),
                trailing: Checkbox(
                  //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
                  value: selectedCharge.chargesTaxable,
                  onChanged: (bool val) {
                    //noCharge
                  },
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _totalChargesController,
                  decoration: new InputDecoration(
                    labelText: 'Total Charges',
//                    suffixIcon: IconButton(
//                      //onPressed: () => _getVIN(), //_controller.clear(),
//                      icon: Icon(Icons.autorenew),
//                    ),
                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter Charges';
//                    }
                  //  },
                  // onSaved: (val) => setState(() => _call.VIN = val),
                ),
              ),
              RaisedButton(
                  onPressed: () async {},
//                      final form = _formKey.currentState;
//                      if (form.validate()) {
//                        form.save();
//                        await Provider.of<ProcessTowedVehiclesVM>(context)
//                            .checkForDuplicateTickets(_call);
//                        if (Provider.of<ProcessTowedVehiclesVM>(context)
//                                .duplicateData["errorStatus"] ==
//                            "true") {
//                          showDialog(
//                              context: context,
//                              builder: (BuildContext context) {
//                                return DuplicateCall();
//                              });
//
//                          //Add Yes or No Button and Rock it
//                        }
//                        else{
//                          //Call Save here
//                          Provider.of<Calls>(context).create(_call);
//                        }
//                        _showDialog(context);
//                      }
//                    },
                  child: Text('SAVE')),
            ],
          ),
        ))));
  }

  setTowCharge() {}
}
