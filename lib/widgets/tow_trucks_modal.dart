import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:vts_mobile_cloud/providers/relationTowTruck_provider.dart';

class TowTrucksModal extends StatelessWidget {

  final Function setTruck;
  TowTrucksModal({Key key, this.setTruck}) : super(key: key);

  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<TowTrucksVM>(context, listen:false).list();
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('Select Wrecker Truck'),
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
                      return Provider.of<TowTrucksVM>(context, listen:false).towTrucks;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          leading: Icon(Icons.directions_transit),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10, top: 15),
                                  child: Text(suggestion.towTruckName)),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 5, top: 5),
                                  child: Row(children: <Widget>[
                                    Text("License Plate : ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                    Text(suggestion.licensePlate,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14))
                                  ])),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10, top: 5),
                                  child:  Row(children: <Widget>[
                                    Text(
                                        "VIN : ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                    Text(
                                        suggestion.VIN,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14))
                                  ])),


                              Divider(height: 5.0, color: Colors.black38),
                            ],
                          )
//                      subtitle: Text('\$${suggestion['id']}'),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController1.text = suggestion.towTruckName;
                      setTruck(suggestion.towTruck, suggestion.towTruckName);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )));
  }
}
