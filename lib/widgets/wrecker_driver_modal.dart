import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:vts_mobile_cloud/providers/relationWreckerDriver_provider.dart';

class WreckerDriverModal extends StatelessWidget {

  final Function setDriver;
  WreckerDriverModal({Key key, this.setDriver}) : super(key: key);

  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('SELECT WRECKER DRIVER', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),

        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontStyle: FontStyle.italic),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          border: UnderlineInputBorder()),
                      controller: this._typeAheadController1,
                    ),
                    suggestionsCallback: (pattern) async {
                      await Provider.of<WreckerDriversVM>(context, listen:false).listMini(pattern);
                      return Provider.of<WreckerDriversVM>(context, listen:false).wreckerDrivers;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          leading: Icon(Icons.person_pin_circle, size: 20, color:Colors.grey),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 13),
                                  child: Text(suggestion.wreckerDriverName, style:TextStyle(fontSize:14, fontWeight: FontWeight.w400))),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 5, top: 5),
                                  child: Row(children: <Widget>[
                                    Text("State License : ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                    Text(suggestion.stateLicense,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14))
                                  ])),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10, top: 5),
                                  child:  Row(children: <Widget>[
                                    Text(
                                        "City License : ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                    Text(
                                        suggestion.cityLicense,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14))
                                  ])),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10, top: 5),
                                  child:  Row(children: <Widget>[
                                    Text(
                                        "Tow Truck : ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                    Text(
                                        suggestion.towTruckName,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14))
                                  ])),
                              Divider(color: Colors.black38),
                            ],
                          )
//                      subtitle: Text('\$${suggestion['id']}'),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController1.text = suggestion.wreckerDriverName;
                      setDriver(suggestion.wreckerDriver, suggestion.wreckerDriverName);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )));
  }
}
