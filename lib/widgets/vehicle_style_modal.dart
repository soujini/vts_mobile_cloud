import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calls_provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:vts_mobile_cloud/providers/vehicleStyle_provider.dart';

class VehicleStyleModal extends StatelessWidget {

  final Function setStyle;
  VehicleStyleModal({Key key, this.setStyle}) : super(key: key);

  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<VehicleStylesVM>(context, listen:false).list();
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('Select Vehicle Style'),
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
                      return Provider.of<VehicleStylesVM>(context, listen:false).vehicleStyles;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          leading: Icon(Icons.style),
                          title: Column(
                              crossAxisAlignment:  CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(bottom: 10, top: 15),
                                    child: Text(suggestion.name)),
                                Divider(height: 5.0, color: Colors.black38),
                              ] )
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController1.text = suggestion.name;
                      setStyle(suggestion.id, suggestion.name);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )));
  }
}
