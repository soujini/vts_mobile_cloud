import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calls_provider.dart';

class NotesAdd extends StatefulWidget {
//  UpdateStatus(this.id, this.dispatchStatusName, this.dispatchInstructions_string);

  @override
  State<StatefulWidget> createState() {
    return _NotesAddState();
  }
}

class _NotesAddState extends State<NotesAdd> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('ADD NOTES',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          new ListTile(
//                leading: Container(
//                  width: 60,
//                  // can be whatever value you want
//                  alignment: Alignment.centerLeft,
//                  child: Text("Notes *"),
//                ),
            title: new TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
              // controller: _vinController,
              decoration: new InputDecoration(
                hintText: "Notes",
//                    suffixIcon: IconButton(
//                      //onPressed: () => _getVIN(), //_controller.clear(),
//                      icon: Icon(Icons.autorenew),
//                    ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Notes';
                }
              },
              // onSaved: (val) => setState(() => _call.VIN = val),
            ),
          ),
          ListTile(
              title: const Text('Owner'),
              trailing: Radio(
                  //value: SingingCharacter.lafayette,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() { _character = value; });
//                                },
                  )),
          ListTile(
              title: const Text('Payment'),
              trailing: Radio(
                  //value: SingingCharacter.lafayette,
//                                groupValue: _character,
//                                onChanged: (SingingCharacter value) {
//                                  setState(() { _character = value; });
//                                },
                  )),
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
    ));
  }
}
