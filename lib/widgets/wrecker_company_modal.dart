import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:vts_mobile_cloud/providers/relationWreckerCompany_provider.dart';

class WreckerCompanyModal extends StatelessWidget {

  final Function setCompany;
  WreckerCompanyModal({Key key, this.setCompany}) : super(key: key);

  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('SELECT WRECKER COMPANY', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),

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
                      await Provider.of<WreckerCompaniesVM>(context, listen:false).listMini(pattern);
                      return Provider.of<WreckerCompaniesVM>(context, listen:false).wreckerCompanies;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          leading: Icon(Icons.build, size: 20, color:Colors.grey),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 13),
                                  child: Text(suggestion.wreckerCompanyName, style:TextStyle(fontSize:14, fontWeight: FontWeight.w400))),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 5, top: 5),
                                  child: Row(children: <Widget>[
                                    Text("State License : ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                    Text(suggestion.stateLicense,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14))
                                  ]
                                  )),
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
                              Divider(color: Colors.black38),
                            ],
                          )
//                      subtitle: Text('\$${suggestion['id']}'),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController1.text = suggestion.wreckerCompanyName;
                      setCompany(suggestion.wreckerCompany, suggestion.wreckerCompanyName);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )));
  }
}
