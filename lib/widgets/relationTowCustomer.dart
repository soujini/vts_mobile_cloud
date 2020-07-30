import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:vts_mobile_cloud/providers/relationTowCustomer_provider.dart';


class RelationTowCustomer extends StatefulWidget {
  @override
  _RelationTowCustomerState createState() => new _RelationTowCustomerState();
}

class _RelationTowCustomerState extends State<RelationTowCustomer> {
//  GlobalKey<AutoCompleteTextFieldState<Players>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TowCustomer>> key = new GlobalKey();

  AutoCompleteTextField searchTextField;

  TextEditingController controller = new TextEditingController();

  _RelationTowCustomerState();

  void _loadData() async {
    // await PlayersViewModel.loadPlayers();
    // await TCViewModel.loadPlayers();
    await Provider.of<TowCustomersVM>(context, listen:false).list();
//    print(PlayersViewModel.players);
//     print(Provider.of<Playerss>(context).towC);
//    print("blah "+Provider.of<Playerss>(context).towC[0].name.toString());
  }

//  @override
//  void initState() {
//    print("in init state");
//
//    super.initState();
//
//  }


  @override
  Widget build(BuildContext context) {

    _loadData();
    return Center(
            child: new Column(children: <Widget>[
              new Column(children: <Widget>[
                searchTextField = AutoCompleteTextField<TowCustomer>(
                    style: new TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: new InputDecoration(
                        suffixIcon: Container(
                          width: 85.0,
                          height: 60.0,
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        filled: true,
                        hintText: 'Search Customer',
                        hintStyle: TextStyle(color: Colors.black)),
                    itemSubmitted: (item) {
                      setState(() => searchTextField.textField.controller.text =
                          item.towCustomerName);
                    },
                    clearOnSubmit: false,
                    key: key,
//                    suggestions: PlayersViewModel.players,
                    suggestions: Provider.of<TowCustomersVM>(context, listen:false).tc,
                    itemBuilder: (context, item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(item.towCustomerName,
                            style: TextStyle(
                                fontSize: 16.0
                            ),),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                          ),
                          Text(item.towCustomerName,
                          )
                        ],
                      );
                    },
                    itemSorter: (a, b) {
                      return a.towCustomerName.compareTo(b.towCustomerName);
                    },
                    itemFilter: (item, query) {
                      return item.towCustomerName
                          .toLowerCase()
                          .startsWith(query.toLowerCase());
                    }),
              ]),
            ]));
  }
}