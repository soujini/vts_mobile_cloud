import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:vts_mobile_cloud/providers/processTowedVehicle_provider.dart';
import 'package:vts_mobile_cloud/widgets/charges_edit.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';
import '../providers/calls_provider.dart';
import '../providers/towedVehicleCharges_provider.dart';

class TowedVehicleChargesList extends StatefulWidget {
  TowedVehicleChargesList({Key key, this.userRole, this.notifyParent});

  final String userRole;
  final Function notifyParent;
  bool isLoading=false;

  @override
  _TowedVehicleChargesList createState() => _TowedVehicleChargesList();
}
class _TowedVehicleChargesList extends State<TowedVehicleChargesList> {
  static const int PAGE_SIZE = 15;

  Future<List> _refreshCallsList(BuildContext context) async {
    var selectedCall = Provider.of<Calls>(context, listen: false).selectedCall;
    return await Provider.of<TowedVehicleChargesVM>(context, listen: false)
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

  _showErrorMessage(BuildContext context, errorMessage) {
    Scaffold.of(context).showSnackBar(
        new SnackBar(
            backgroundColor: Colors.lightGreen,
            content: Text(errorMessage,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500
                ))));
  }
  Future deleteCharge(id, towCharges, towedVehicle) async {
       setState(() {
      widget.isLoading = true;
       });

    var selectedCall = Provider.of<Calls>(context, listen: false).selectedCall;

    await Provider.of<TowedVehicleChargesVM>(context, listen: false).delete(id, selectedCall.id);
     var chargesDeleteResponse = Provider.of<TowedVehicleChargesVM>(context, listen: false).chargesDeleteResponse;
       setState(() {

       });
     if (chargesDeleteResponse["errorStatus"] == "false") {
      widget.isLoading = false;
      _showErrorMessage(context, chargesDeleteResponse["errorMessage"]);
    }
    else {
      //call process change charge
      await Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
          .processChangeCharges(towedVehicle,towCharges);
      var processChangeChargeResponse = Provider
          .of<ProcessTowedVehiclesVM>(context, listen: false)
          .processChangeChargeResponse;

      if (processChangeChargeResponse["errorStatus"] == "false") {
        widget.isLoading = false;
        _showErrorMessage(
            context, processChangeChargeResponse["errorMessage"]);
      }
      else {
        setState(() {
          widget.isLoading = false;
        });
      }
    }
  }
  refresh(){
  setState(() {

  });
  }

  @override
  Widget build(BuildContext context) {
    // _refreshCallsList(context);
    var selectedCall = Provider.of<Calls>(context, listen: false).selectedCall;
    return RefreshIndicator(
        onRefresh: () => _refreshCallsList(context),
        child: PagewiseListView(
          key:UniqueKey(),
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
                Provider.
                of<TowedVehicleChargesVM>(context, listen: false)
                    .listMini(
                        pageIndex, PAGE_SIZE, selectedCall.id.toString())));
  }

  Widget _itemBuilder(context, towedVehicleCharges, _) {

  return Card(
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
                      fontSize: 14.0)),
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
              Visibility(
                  visible:widget.userRole == "3" ? false : true,
                  child: IconButton(
                    icon: new Icon(Icons.edit, size:20),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new ChargesEdit(notifyParent:refresh)));
                      Provider.of<TowedVehicleChargesVM>(context,
                          listen: false)
                          .selectedCharge
                          = towedVehicleCharges;
                    },
                  )),
              Visibility(
                  // visible:userRole != null && userRole == "3" ? false :true,
                visible:true,
                  child: IconButton(
                    icon: new Icon(Icons.delete_outline, size:20),
                    tooltip: 'Delete',
                    onPressed: () => {
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  'DELETE CHARGE', style: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.bold, color:Color(0xff1C3764))),
                              content: widget.isLoading == true ? Center(child:Loader()):SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        'Are you sure you want to delete Towed Vehicle Charge - ' +
                                            towedVehicleCharges
                                                .towChargesName +
                                            ' with a total charge of \$\ ' +
                                            towedVehicleCharges
                                                .totalCharges +
                                            '?', style: TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.w400, color:Colors.black)),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(color: Colors.green)
                                  ),
                                  color: Colors.white,
                                  textColor: Colors.green,
                                  child: Text('Yes'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    deleteCharge(
                                         towedVehicleCharges.id, towedVehicleCharges.towCharges, towedVehicleCharges.towedVehicle);
                                    },
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(color: Colors.grey)
                                  ),
                                  color: Colors.white,
                                  textColor: Colors.grey,
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }),
                    },
//                    onPressed: () {
//                      Navigator.push(
//                          context,
//                          new MaterialPageRoute(
//                              builder: (context) => new ChargesAdd()));
//                    },
                  )),
            ]),
            new Divider(color: Colors.black38),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.0),
              child: Table(
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Column(
                          children: <Widget>[
                            Text("Qty.",
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 10.0,  fontWeight:FontWeight.w500)),
                            Padding(
                                padding: EdgeInsets.only(top: 15),
                                child:
                                Text(towedVehicleCharges.chargesQuantity)),
                          ],
                        )),
                    TableCell(
                        child: Column(
                          children: <Widget>[
                            Text("Disc. Qty.",
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 10.0, fontWeight:FontWeight.w500)),
                            Padding(
                                padding: EdgeInsets.only(top: 15),
                                child:
                                Text(towedVehicleCharges.discountQuantity)),
                          ],
                        )),
                    TableCell(
                        child: Column(
                          children: <Widget>[
                            Text("Rate",
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 10.0, fontWeight:FontWeight.w500)),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(towedVehicleCharges.chargesRate),
                            )
                          ],
                        )),
                    TableCell(
                        child: Column(
                          children: <Widget>[
                            Text("Disc.",
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 10.0,  fontWeight:FontWeight.w500)),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(towedVehicleCharges.discountRate),
                            )
                          ],
                        )),
                    TableCell(
                        child: Column(
                          children: <Widget>[
                            Text("Apply",
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 10.0, fontWeight:FontWeight.w500)),
                            new Checkbox(
                              value: towedVehicleCharges.discountApply,
//                          //    onChanged: _value1Changed
                            ),
                          ],
                        )),
                    TableCell(
                        child: Column(
                          children: <Widget>[
                            Text("Taxable",
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 10.0, fontWeight:FontWeight.w500)),
                            new Checkbox(
                                value: towedVehicleCharges.chargesTaxable),
                          ],
                        )),
                    TableCell(
                        child: Column(
                          children: <Widget>[
                            Text("Total",
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 10.0, fontWeight:FontWeight.w500)),
                            Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Text(towedVehicleCharges.totalCharges)),
                          ],
                        )),
                  ])
                ],
              ),
            )
          ],
        )),
    //Divider()
  );
  }
}
