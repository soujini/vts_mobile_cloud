import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/calls_provider.dart';
import '../screens/vehicle_info.dart';
import '../screens/add_edit_call.dart';
import '../widgets/update_status.dart';


class ActiveCallsList extends StatelessWidget {
  static const int PAGE_SIZE = 15;
  Future<List> _refreshCallsList(BuildContext context) async {
    return await Provider.of<Calls>(context)
        .listMiniMobile('active', 0, PAGE_SIZE,"")
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
            pageFuture: (pageIndex) => Provider.of<Calls>(context)
                .listMiniMobile('active', pageIndex, PAGE_SIZE,"")));
  }

  Widget _itemBuilder(context, activeCalls, _) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new VehicleInfoScreen(activeCalls)));
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
                          percent: activeCalls.progressPercentage,
//                                        header: new Text("Icon header"),
                          center: new Icon(Icons.directions_car,
                              size: 15.0, color: Colors.black),
                          backgroundColor: Colors.black12,
                          progressColor: activeCalls.progressStyleColor,
                        ),
                        Expanded(child: SizedBox()),
                        Text((activeCalls.dispatchStatusName.toUpperCase()),
                            // .toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: activeCalls.progressStyleColor)),
                        //Expanded(child: SizedBox()),
                        FlatButton.icon(

                            onPressed: () {
                              Provider
                                  .of<Calls>(context)
                                  .selectedCall
                                  .id = activeCalls.id;
                              Provider
                                  .of<Calls>(context)
                                  .selectedCall
                                  .dispatchStatusName =
                                  activeCalls.dispatchStatusName;
                              Provider
                                  .of<Calls>(context)
                                  .selectedCall
                                  .dispatchInstructions_string =
                                  activeCalls.dispatchInstructions_string;

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
                                    return
                                      UpdateStatus(activeCalls.id,
                                          activeCalls.dispatchStatusName,
                                          activeCalls
                                              .dispatchInstructions_string);
                                  });
                            },
                            textColor: Colors.grey,
                            icon: Icon(Icons.update),
                            label: Text('Update Status')),
                      ]),
                      Text(
                          '\$${activeCalls.towedTotalAmount.toStringAsFixed(
                              2)}',
                          //towedTotalAmount
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 14)),
                      Text((activeCalls.towReasonName),
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: (Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Text(
                                    (activeCalls.vehicleYear.toString() +
                                        ' ' +
                                        activeCalls.vehicleMakeName + ' ' +
                                        activeCalls.vehicleYearMakeModelName),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(' '),
                                Text(('(' + activeCalls.color + ')'),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text((activeCalls.towedInvoice),
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
                                Text((activeCalls.towCustomerName),
                                    style: TextStyle(fontSize: 14)),
                                Text(' '),
                                Text((activeCalls.dispatchDate),
                                    style: TextStyle(fontSize: 14)),

//                                          Text(
//                                              (DateFormat('MM-dd-yyyy')
//                                                  .format(activeCalls
//                                                  .dispatchDate)),
//                                              style: TextStyle(
//                                                  fontSize: 14)),
                                Text(' '),
//                                          Text(
//                                              ('(' +
//                                                  DateFormat('H:mm')
//                                                      .format(activeCalls[
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
                                Text((activeCalls.dispatchContact),
                                    style: TextStyle(fontSize: 14)),
                                Text(' '),
                                new GestureDetector(
                                  onTap: () {
                                    launch("tel://" +
                                        activeCalls.dispatchContactPhone);
                                  },
                                  child: Text(
                                      (activeCalls.dispatchContactPhone),
                                      style: TextStyle(fontSize: 14)),
                                )

                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text(
                                    (activeCalls.towedStreet +
                                        ' ' +
                                        activeCalls.towedStreetTwo +
                                        ' ' +
                                        activeCalls.towedCityName +
                                        ' ' +
                                        activeCalls.towedStateName +
                                        ' ' +
                                        activeCalls.towedZipCode),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text(
                                    (activeCalls.towedToStreet +
                                        ' ' +
                                        activeCalls.towedToStreetTwo +
                                        ' ' +
                                        activeCalls.towedToCityName +
                                        ' ' +
                                        activeCalls.towedToStateName +
                                        ' ' +
                                        activeCalls.towedToZipCode),
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



