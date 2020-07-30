import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:vts_mobile_cloud/providers/relationTowAuthorization_provider.dart';

class TowAuthorizationModal extends StatelessWidget {

  final Function setAuthorization;
  TowAuthorizationModal({Key key, this.setAuthorization}) : super(key: key);

  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('SELECT TOW AUTHORIZATION', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
        ),
        body: Container(
            padding: EdgeInsets.all(15),
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
                      await Provider.of<TowAuthorizationsVM>(context, listen:false).listMini(pattern);
                      return Provider.of<TowAuthorizationsVM>(context, listen:false).towAuthorizations;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          leading: Icon(Icons.check_circle_outline, size: 20, color:Colors.grey),
                          title: Column(
                              crossAxisAlignment:  CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(bottom: 15, top: 13),
                                    child: Text(suggestion.towAuthorizationName, style:TextStyle(fontSize:14, fontWeight: FontWeight.w400))
                                ),

                                Divider(color: Colors.black38)])
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController1.text = suggestion.towAuthorizationName;
                      setAuthorization(suggestion.towAuthorization, suggestion.towAuthorizationName);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )));
  }
}
