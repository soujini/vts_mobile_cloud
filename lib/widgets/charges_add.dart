import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/providers/towedVehicleCharges_provider.dart';
import 'package:vts_mobile_cloud/providers/processTowedVehicle_provider.dart';
import 'package:vts_mobile_cloud/widgets/tow_charges_modal.dart';
import '../providers/calls_provider.dart';
import 'package:vts_mobile_cloud/screens/add_edit_call.dart';

class ChargesAdd extends StatefulWidget {
//  UpdateStatus(this.id, this.dispatchStatusName, this.dispatchInstructions_string);

  @override
  State<StatefulWidget> createState() {
    return _ChargesAddState();
  }
}

class _ChargesAddState extends State<ChargesAdd> {
  final _formKey = GlobalKey<FormState>();
  final _charge = TowedVehicleCharge();

  var _towChargesController = new TextEditingController();
  var _chargesQuantityController = new TextEditingController();
  var _discountQuantityController = new TextEditingController();
  var _chargesRateController = new TextEditingController();

  setTowCharge(id, name) {
    getAndSetDefaultCharges(id);
    setState(() {
      _charge.towCharges = id;
      _towChargesController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
    _formKey.currentState.validate();
  }

  getAndSetDefaultCharges(towCharges) async {
    var selectedCall = Provider.of<Calls>(context, listen: false).callDetails;
    var towCustomer = selectedCall[0].towCustomer;
    var towType = selectedCall[0].towType;
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
    var selectedCall = Provider.of<Calls>(context, listen: false).selectedCall;
    _charge.towedVehicle = selectedCall.id;
    _charge.discountRate = "0.00";
    _charge.discountApply = false;
    _charge.totalCharges = "0.00";

    form.save();
    await Provider.of<TowedVehicleChargesVM>(context, listen: false).create(_charge);
    var response = Provider.of<TowedVehicleChargesVM>(context, listen: false).createResponse;
    if (response["errorStatus"] == "false") {
      _showErrorMessage(context, response["errorMessage"]);
    }
    else{
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new AddEditCallScreen(5)));
    }
//        .then((res) {
//      Navigator.push(context,
//          new MaterialPageRoute(builder: (context) => new AddEditCallScreen(5)));
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('Add Charges'),
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: this._towChargesController,
                    decoration: new InputDecoration(
                      labelText: 'Charge',
                      suffixIcon: Icon(Icons.arrow_forward_ios),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select Vehicle Charge';
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.number,
                  controller: _chargesQuantityController,
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
                  onSaved: (val) =>
                      setState(() => _charge.chargesQuantity = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.number,
                  controller: _discountQuantityController,
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
                  onSaved: (val) => setState(() => _charge.chargesRate = val),
                ),
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Colors.green)
                  ),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () => save(),
                  child: Text('SAVE')),
            ],
          ),
        ))));
  }
}
