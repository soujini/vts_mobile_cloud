import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';

import '../providers/calls_provider.dart';
import '../screens/vehicle_info.dart';
import '../screens/add_edit_call.dart';
import '../widgets/update_status.dart';

class CancelledCallsList extends StatelessWidget {
  static const int PAGE_SIZE = 15;
  Future<List> _refreshCallsList(BuildContext context) async {
    return await Provider.of<Calls>(context)
        .listMiniMobile('cancelled', 0, PAGE_SIZE,"")
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
    return RefreshIndicator(
        onRefresh: () => _refreshCallsList(context),
        child: PagewiseListView(
            errorBuilder: (context, error) {
              return Text(error);
            },
            showRetry: false,
            loadingBuilder: (context) {
              return Loader();
              //              return CircularProgressIndicator(
////                backgroundColor: Colors.green,
//              );
            },
            noItemsFoundBuilder: (context) {
              return Text('No Items Found');
            },
            pageSize: PAGE_SIZE,
            itemBuilder: this._itemBuilder,
            pageFuture: (pageIndex) => Provider.of<Calls>(context)
                .listMiniMobile('cancelled', pageIndex, PAGE_SIZE,"")));
  }

  Widget _itemBuilder(context, cancelledCalls, _) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new VehicleInfoScreen(cancelledCalls)));
        },
        child: Column(children: <Widget>[
          Card(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: [
                        CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 5.0,
                          percent: cancelledCalls.progressPercentage,
//                                        header: new Text("Icon header"),
                          center: new Icon(Icons.directions_car,
                              size: 15.0, color: Colors.black),
                          backgroundColor: Colors.black12,
                          progressColor: cancelledCalls.progressStyleColor,
                        ),
                        Expanded(child: SizedBox()),
                        Text((cancelledCalls.dispatchStatusName.toUpperCase()),
                            // .toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: cancelledCalls.progressStyleColor)),
                        //Expanded(child: SizedBox()),
                        FlatButton.icon(
                            onPressed: () {
                              Provider.of<Calls>(context).selectedCall.id = cancelledCalls.id;
                              Provider.of<Calls>(context).selectedCall.dispatchStatusName = cancelledCalls.dispatchStatusName;
                              Provider.of<Calls>(context).selectedCall.dispatchInstructions_string = cancelledCalls.dispatchInstructions_string;
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                      new AddEditCallScreen()));
                            },
                            textColor: Colors.grey,
                            icon: Icon(Icons.edit),
                            label: Text('Edit Call')),
                        FlatButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return UpdateStatus(int.parse(cancelledCalls.id),cancelledCalls.dispatchStatusName, cancelledCalls.dispatchInstructions_string);
                                  });
                              // showDialogUpdateStatus(context);
                            },
                            textColor: Colors.grey,
                            icon: Icon(Icons.update),
                            label: Text('Update Status')),
                      ]),
                      Text(
                          '\$${cancelledCalls.towedTotalAmount.toStringAsFixed(2)}',
                          //towedTotalAmount
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 14)),
                      Text((cancelledCalls.towReasonName),
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: (Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Text(
                                    (cancelledCalls.vehicleYear.toString() +
                                        ' ' +
                                        cancelledCalls.vehicleYearMakeModelName),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(' '),
                                Text(('(' + cancelledCalls.color + ')'),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text((cancelledCalls.towedInvoice),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ],
                            ),
                          ],
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: (Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Text((cancelledCalls.towCustomerName),
                                    style: TextStyle(fontSize: 14)),
                                Text(' '),
                                Text((cancelledCalls.dispatchDate),
                                    style: TextStyle(fontSize: 14)),

//                                          Text(
//                                              (DateFormat('MM-dd-yyyy')
//                                                  .format(cancelledCalls
//                                                  .dispatchDate)),
//                                              style: TextStyle(
//                                                  fontSize: 14)),
                                Text(' '),
//                                          Text(
//                                              ('(' +
//                                                  DateFormat('H:mm')
//                                                      .format(cancelledCalls[
//                                                  index]
//                                                      .dispatchDispatchTime) +
//                                                  ')'),
//                                              style: TextStyle(
//                                                  color: Colors.grey,
//                                                  fontSize: 14)),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text((cancelledCalls.dispatchContact),
                                    style: TextStyle(fontSize: 14)),
                                Text(' '),
                                Text((cancelledCalls.dispatchContactPhone),
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text(
                                    (cancelledCalls.towedStreet +
                                        ' ' +
                                        cancelledCalls.towedStreetTwo +
                                        ' ' +
                                        cancelledCalls.towedCityName +
                                        ' ' +
                                        cancelledCalls.towedStateName +
                                        ' ' +
                                        cancelledCalls.towedZipCode),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text(
                                    (cancelledCalls.towedToStreet +
                                        ' ' +
                                        cancelledCalls.towedToStreetTwo +
                                        ' ' +
                                        cancelledCalls.towedToCityName +
                                        ' ' +
                                        cancelledCalls.towedToStateName +
                                        ' ' +
                                        cancelledCalls.towedToZipCode),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ],
                            ),
                          ],
                        )),
                      ),
                    ],
                  ))),
          //Divider()
        ]));
  }
}
