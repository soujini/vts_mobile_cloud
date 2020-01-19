import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/widgets/tow_charges_modal.dart';
import '../providers/calls_provider.dart';

class ChargesAdd extends StatefulWidget {
//  UpdateStatus(this.id, this.dispatchStatusName, this.dispatchInstructions_string);

  @override
  State<StatefulWidget> createState() {
    return _ChargesAddState();
  }
}

class _ChargesAddState extends State<ChargesAdd> {
  final _formKey = GlobalKey<FormState>();

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
      child:Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),

              ),
              new ListTile(
                title: new TextFormField(
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
                              builder: (context) =>
                              new TowChargesModal(
                                  setTowCharge: setTowCharge)));
                    }),
              ),
              new ListTile(

                title: new TextFormField(
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
                  keyboardType: TextInputType.number,
                  // controller: _vinController,
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
                  // controller: _vinController,
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

  setTowCharge() {
  }
}
