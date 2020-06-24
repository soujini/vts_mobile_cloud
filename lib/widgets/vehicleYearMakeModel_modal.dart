import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:vts_mobile_cloud/providers/vehicleYearMakeModel_provider.dart';

class VehicleYearMakeModelModal extends StatelessWidget {

  final Function setYearMakeModelName;
  VehicleYearMakeModelModal({Key key, this.setYearMakeModelName}) : super(key: key);

  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<VehicleYearMakeModelsVM>(context, listen:false).listMini();
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('Select Vehicle'),
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
                      return Provider.of<VehicleYearMakeModelsVM>(context, listen:false).vehicleYearMakeModels;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Column(
                            crossAxisAlignment:  CrossAxisAlignment.start,
                            children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 15),
                              child: Text(suggestion.vehicleYearMakeModelName)),
                              Divider(height: 5.0, color: Colors.black38),
                            ] )
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController1.text = suggestion.vehicleYearMakeModelName;
                      setYearMakeModelName(suggestion);
                     // setMake(suggestion.id, suggestion.name);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )));
  }
}
