import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/providers/calls_provider.dart';
import 'package:vts_mobile_cloud/providers/processTowedVehicle_provider.dart';
import '../providers/towedVehicleCharges_provider.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';

class ChargesEdit extends StatefulWidget {
  final Function notifyParent;
  ChargesEdit({Key key, this.notifyParent});

  @override
  State<StatefulWidget> createState() {
    return _ChargesEditState();
  }
}

class _ChargesEditState extends State<ChargesEdit> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = true;
  bool isLoading = false;
  var _charge = TowedVehicleCharge();
  var _enableDiscountApply = false;
  bool isChargesQuantitySelected=false;

  var _towChargesController = new TextEditingController();
  var _chargesQuantityController = new TextEditingController();
  var _discountQuantityController = new TextEditingController();
  var _chargesRateController = new TextEditingController();
  var _discountRateController = new TextEditingController();
  var _totalChargesController = new TextEditingController();

  void initState() {
    _chargesQuantityController.addListener(() {
      final text = _chargesQuantityController.text;
      _chargesQuantityController.value = _chargesQuantityController.value.copyWith(
        text: text,
        // selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        // composing: TextRange.empty,
      );
    });

    _chargesRateController.addListener(() {
      final text = _chargesRateController.text;
      _chargesRateController.value = _chargesRateController.value.copyWith(
        text: text,
        // selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        // composing: TextRange.empty,
      );
    });
     _charge = Provider.of<TowedVehicleChargesVM>(context, listen: false).selectedCharge;
    getValues();

    super.initState();
  }

  getValues() {
    isLoading=true;
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
    enableDisableDiscount();
    isLoading=false;
  }

  enableDisableDiscount() async {
    var _selectedCall = await Provider.of<Calls>(context, listen: false).callDetails;
    var storageStatus = _selectedCall[0].storageStatus;
    var towedStatus = _selectedCall[0].towedStatus;
    if (storageStatus != 2 && towedStatus != 'X') {
      _enableDiscountApply = true;
    } else {
      _enableDiscountApply = false;
    }
  }

  _showErrorMessage(BuildContext context, errorMessage) {
    Scaffold.of(context).showSnackBar(
        new SnackBar(
            backgroundColor: Colors.lightGreen,
            content: Text(errorMessage,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500
                ))));
  }

  save() async {
    final form = _formKey.currentState;
    var selectedCall = Provider
        .of<Calls>(context, listen: false)
        .selectedCall;
    _charge.towedVehicle = selectedCall.id;

    if (form.validate()) {
      form.save();
        isLoading = true;
      await Provider.of<TowedVehicleChargesVM>(context, listen: false).update(
          _charge);
      var chargesUpdateResponse = Provider
          .of<TowedVehicleChargesVM>(context, listen: false)
          .chargesUpdateResponse;

      if (chargesUpdateResponse["errorStatus"] == "false") {
          isLoading = false;
        _showErrorMessage(context, chargesUpdateResponse["errorMessage"]);
      }
      else {
        //call process change charge
        await Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
            .processChangeCharges(_charge.towedVehicle, _charge.towCharges);
        var processChangeChargeResponse = Provider
            .of<ProcessTowedVehiclesVM>(context, listen: false)
            .processChangeChargeResponse;
        if (processChangeChargeResponse["errorStatus"] == "false") {
            isLoading = false;
          _showErrorMessage(
              context, processChangeChargeResponse["errorMessage"]);
        }
        else {
            isLoading = false;
          Navigator.pop(context);
          widget.notifyParent();
          // Navigator.push(context,
          //     new MaterialPageRoute(
          //         builder: (context) => new AddEditCallScreen(5)));
        }
      }
    }
    else{
      print("Invalid fields");
    }
  }
  calculateTotalChargesOnQuantityChange(val){
    // setState(() => _charge.chargesQuantity = val);
    _charge.chargesQuantity = val;

    double total = double.parse(val).floor() * double.parse(_charge.chargesRate);
    String totalCharges =  total.toStringAsFixed(2);

    _charge.totalCharges=totalCharges;
     _totalChargesController.value = new TextEditingController.fromValue(
        new TextEditingValue(
            text: totalCharges,
        ))
        .value;
  }
  calculateTotalChargesOnRateChange(val){
    // setState(() => _charge.chargesRate = val);
    _charge.chargesRate = val;
    double total = double.parse(val) * double.parse(_charge.chargesQuantity);
    String totalCharges =  total.toStringAsFixed(2);

    _charge.totalCharges=totalCharges;
    _totalChargesController.value = new TextEditingController.fromValue(
        new TextEditingValue(text: totalCharges))
        .value;

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('EDIT CHARGES', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
        ),
        body: isLoading == true? Center(child:Loader()):Container(
            child: SingleChildScrollView(
                // child: AlertDialog(
                //content:
                child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
              ),
              new ListTile(
                title: new TextFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  enabled: false,
                  controller: this._towChargesController,
                  decoration: new InputDecoration(
                    labelText: 'Charge *',
                  ),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  readOnly: _charge.accruedCharge == true,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  controller: this._chargesQuantityController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: new InputDecoration(
                    labelText: 'Quantity',
                  ),
                 validator: (value) {
                   if (value.isEmpty) {
                     return 'Please enter Quantity';
                   }
                   else{
                     return null;
                   }
                   },
                  onTap: () => {_chargesQuantityController.selection = TextSelection(baseOffset: 0, extentOffset: _chargesQuantityController.value.text.length)},
                  onChanged: (val) => calculateTotalChargesOnQuantityChange(val),
                  onSaved: (val) =>
                      setState(() => _charge.chargesQuantity = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  controller: this._discountQuantityController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: new InputDecoration(
                    labelText: 'Discount Quantity',
                  ),
                  onTap: () => {_discountQuantityController.selection = TextSelection(baseOffset: 0, extentOffset: _discountQuantityController.value.text.length)},
                  onSaved: (val) =>
                      setState(() => _charge.discountQuantity = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _chargesRateController,
                  decoration: new InputDecoration(
                    labelText: 'Rate *',
                  ),
                 validator: (value) {
                   if (value.isEmpty) {
                     return 'Please enter Rate';
                   }
                   else{
                     return null;
                   }
                   },
                  onTap: () => {_chargesRateController.selection = TextSelection(baseOffset: 0, extentOffset: _chargesRateController.value.text.length)},
                  onChanged: (val) => calculateTotalChargesOnRateChange(val),
                  onSaved: (val) => setState(() => _charge.chargesRate = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  enabled: false,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _discountRateController,
                  decoration: new InputDecoration(
                    labelText: 'Discount',
                  ),
                  onTap: () => {_chargesRateController.selection = TextSelection(baseOffset: 0, extentOffset: _chargesRateController.value.text.length)},
                  onSaved: (val) => setState(() => _charge.discountRate = val),
                ),
              ),
              new ListTile(
                leading: Text('Apply',
                    style: new TextStyle(color: Colors.black54, fontSize: 16)),
                trailing: Checkbox(
                  //To set the default value of a checkbox, just set `value` to `true` if u want it checked by default or `false` if unchecked by default
                  value: _charge.discountApply,
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
                  //value: _charge.chargesTaxable,
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
                  readOnly: true,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  // readOnly: true,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
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
