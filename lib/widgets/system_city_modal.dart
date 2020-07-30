import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:vts_mobile_cloud/providers/systemCity_provider.dart';

class SystemCityModal extends StatelessWidget {

  final Function setCity;
  SystemCityModal({Key key, this.setCity}) : super(key: key);

  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('SELECT CITY', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),

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
                      await Provider.of<SystemCitiesVM>(context, listen:false).listMini(pattern);
                      return Provider.of<SystemCitiesVM>(context, listen:false).systemCities;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          leading: Icon(Icons.location_city, size: 20, color:Colors.grey),
                          title: Column(
                              crossAxisAlignment:  CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(bottom: 15, top: 13),
                                    child: Text(suggestion.name, style:TextStyle(fontSize:14, fontWeight: FontWeight.w400))),
                                Divider(color: Colors.black38, ),
                              ] )
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController1.text = suggestion.name;
                      setCity(suggestion.id, suggestion.name);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )));
  }
}
