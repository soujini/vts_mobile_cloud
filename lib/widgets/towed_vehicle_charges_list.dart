import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:vts_mobile_cloud/widgets/charges_edit.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';
import '../providers/calls_provider.dart';
import '../providers/towedVehicleCharges_provider.dart';

class TowedVehicleChargesList extends StatelessWidget {
  static const int PAGE_SIZE = 15;

  Future<List> _refreshCallsList(BuildContext context) async {
    var selectedCall = Provider.of<Calls>(context, listen:false).selectedCall;

    return await Provider.of<TowedVehicleChargesVM>(context, listen:false)
        .listMini(0, PAGE_SIZE, selectedCall.id.toString())
        .catchError((onError) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text("An error occured!"),
                content:
                    Text("Oops something went wrong " + onError.toString()),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedCall = Provider.of<Calls>(context, listen:false).selectedCall;
    return RefreshIndicator(
        onRefresh: () => _refreshCallsList(context),
        child: PagewiseListView(
            shrinkWrap: true,
            errorBuilder: (context, error) {
              return Text(error);
            },
            showRetry: false,
            loadingBuilder: (context) {
              return Loader();
            },
            noItemsFoundBuilder: (context) {
              return Text('No Items Found');
            },
            pageSize: PAGE_SIZE,
            itemBuilder: this._itemBuilder,
            pageFuture: (pageIndex) =>
                Provider.of<TowedVehicleChargesVM>(context, listen:false).listMini(
                    pageIndex, PAGE_SIZE, selectedCall.id.toString())));
  }

  Widget _itemBuilder(context, towedVehicleCharges, _) {
//    return GestureDetector(
//        onTap: () {},
    return Column(children: <Widget>[
      Card(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: [
                  Text(towedVehicleCharges.towChargesName,
                      style: new TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  Spacer(),
                  Text("Total ",
                      style: new TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0)),
                  Text('\$${towedVehicleCharges.totalCharges}',
                      style: new TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0)),
                  IconButton(
                    icon: new Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new ChargesEdit()));
                      Provider.of<TowedVehicleChargesVM>(context, listen:false).selectedCharge.towChargesName = towedVehicleCharges.towChargesName;
                      Provider.of<TowedVehicleChargesVM>(context, listen:false).selectedCharge.chargesQuantity = towedVehicleCharges.chargesQuantity;
                      Provider.of<TowedVehicleChargesVM>(context, listen:false).selectedCharge.discountQuantity = towedVehicleCharges.discountQuantity;
                      Provider.of<TowedVehicleChargesVM>(context, listen:false).selectedCharge.chargesRate = towedVehicleCharges.chargesRate;
                      Provider.of<TowedVehicleChargesVM>(context, listen:false).selectedCharge.discountRate = towedVehicleCharges.discountRate;
                      Provider.of<TowedVehicleChargesVM>(context, listen:false).selectedCharge.discountApply = towedVehicleCharges.discountApply;
                      Provider.of<TowedVehicleChargesVM>(context, listen:false).selectedCharge.chargesTaxable = towedVehicleCharges.chargesTaxable;
                      Provider.of<TowedVehicleChargesVM>(context, listen:false).selectedCharge.totalCharges = towedVehicleCharges.totalCharges;
                    },

                  ),
                  IconButton(
                    icon: new Icon(Icons.delete_outline),
                    tooltip: 'Delete',
//                    onPressed: () {
//                      Navigator.push(
//                          context,
//                          new MaterialPageRoute(
//                              builder: (context) => new ChargesAdd()));
//                    },
                  ),
                ]),
                new Divider(height: 5.0, color: Colors.black38),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 20.0),
                  child: Table(
                    children: [
                      TableRow(children: [
                        TableCell(
                            child: Column(
                          children: <Widget>[
                            Text("QTY.",
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 10.0)),
                            Padding(
                                padding:EdgeInsets.only(top:15),
                                child:Text(towedVehicleCharges.chargesQuantity)),
                          ],
                        )),
                        TableCell(
                            child: Column(
                              children: <Widget>[

                                Text("DISC. QTY.",
                                    style: new TextStyle(
                                        color: Colors.black, fontSize: 10.0)),
                            Padding(
                              padding:EdgeInsets.only(top:15),
                                child:Text(towedVehicleCharges.discountQuantity)),
                              ],
                            )),
                        TableCell(
                            child: Column(
                              children: <Widget>[
                                Text("RATE",
                                    style: new TextStyle(
                                        color: Colors.black, fontSize: 10.0)),
                                Padding(
                                  padding:EdgeInsets.only(top:15),
                                  child:Text(towedVehicleCharges.chargesRate),
                                )
                              ],
                            )),
                        TableCell(
                            child: Column(
                              children: <Widget>[
                                Text("DISC.",
                                    style: new TextStyle(
                                        color: Colors.black, fontSize: 10.0)),
                                Padding(
                                  padding:EdgeInsets.only(top:15),
                                  child:Text(towedVehicleCharges.discountRate),
                                )
                              ],
                            )),
                        TableCell(
                            child: Column(
                              children: <Widget>[
                                Text("APPLY",
                                    style: new TextStyle(
                                        color: Colors.black, fontSize: 10.0)),
                            new Checkbox(value: towedVehicleCharges.discountApply,
//                          //    onChanged: _value1Changed
                          ),
                              ],
                            )),
                        TableCell(
                            child: Column(
                              children: <Widget>[
                                Text("TAXABLE",
                                    style: new TextStyle(
                                        color: Colors.black, fontSize: 10.0)),
                            new Checkbox(value: towedVehicleCharges.chargesTaxable),
                              ],
                            )),
                        TableCell(
                            child: Column(
                              children: <Widget>[
                                Text("TOTAL",
                                    style: new TextStyle(
                                        color: Colors.black, fontSize: 10.0)),
                                Padding(
                                    padding:EdgeInsets.only(top:15),
                                    child:Text(towedVehicleCharges.totalCharges)),
                              ],
                            )),
                      ])
                    ],
                  ),
                )
              ],
            )),
        //Divider()
      )
    ]);
  }
}
