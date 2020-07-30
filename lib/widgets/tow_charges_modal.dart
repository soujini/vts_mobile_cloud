import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:vts_mobile_cloud/providers/relationTowCharges_provider.dart';

class TowChargesModal extends StatelessWidget {

  final Function setTowCharge;
  TowChargesModal({Key key, this.setTowCharge}) : super(key: key);

  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('SELECT VEHICLE CHARGE', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),

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
                      await Provider.of<TowChargesVM>(context, listen:false).listMini(pattern);
                      return Provider.of<TowChargesVM>(context, listen:false).towCharges;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          leading: Icon(Icons.monetization_on, size: 20, color:Colors.grey),
                          title: Column(
                              crossAxisAlignment:  CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(bottom: 15, top: 13),
                                    child: Text(suggestion.towChargesName,  style:TextStyle(fontSize:14, fontWeight: FontWeight.w400))),
                                Divider(color: Colors.black38),
                              ] )
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController1.text = suggestion.towChargesName;
                      setTowCharge(suggestion.id, suggestion.towChargesName);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )));
  }
}
