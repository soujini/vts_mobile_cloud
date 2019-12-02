import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calls_provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:vts_mobile_cloud/providers/relationTowCustomer_provider.dart';

class TowCustomersModal extends StatelessWidget {
//  int id=0;
//  String dispatchStatusName="";
//  String dispatchInstructions_string="";
//  TowCustomersModal();

//  @override
//  State<StatefulWidget> createState() {
//    return _TowCustomersModalState();
//  }
//}
//
//class _TowCustomersModalState extends State<TowCustomersModal> {
  final Function setTowCustomer;

  TowCustomersModal({Key key, this.setTowCustomer}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  bool pressAttention = false;
  String selected_status = "";

  final TextEditingController _typeAheadController1 = TextEditingController();

  initState() {}

//  void _loadData() async {
//    await Provider.of<TowCustomersVM>(context).list();
//  }

  @override
  Widget build(BuildContext context) {
    // _loadData();
    Provider.of<TowCustomersVM>(context).list();
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('Select Tow Customer'),
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
                      return Provider.of<TowCustomersVM>(context).tc;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          leading:
                               Icon(Icons.perm_identity),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10, top: 15),
                                  child: Text(suggestion.towCustomerName)),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 5, top: 5),
                                  child: Text(suggestion.businessStreet,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14))),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10, top: 5),
                                  child: Text(
                                      suggestion.businessCityStateZipName,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14))),
                              Divider(height: 5.0, color: Colors.black38),
                            ],
                          )
//                      subtitle: Text('\$${suggestion['id']}'),
                          );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController1.text =
                          suggestion.towCustomerName;
                      setTowCustomer(
                          suggestion.towCustomer, suggestion.towCustomerName);
                      Navigator.of(context).pop();
                    },
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please select a city';
//                    }
//                  },
                  ),
                ],
              ),
            )));
  }
}
