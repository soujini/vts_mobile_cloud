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
  ActiveCallsList(this.userRole, this.dispatchPaging);
  String userRole;
  var dispatchPaging;
  static const int PAGE_SIZE = 15;

  Future<List> _refreshCallsList(BuildContext context) async {
    return await Provider.of<Calls>(context, listen:false)
        .listMiniMobile('active', 0, PAGE_SIZE,"")
        .catchError((onError) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text("An error occured!"),
                content:
                    Text("Oops! Something went wrong!" + onError.toString()),
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
            pageFuture: (pageIndex) => Provider.of<Calls>(context, listen:false)
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
            elevation: 0,
              child: Padding(
                  padding: EdgeInsets.all(15),
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
                              size: 12.0, color: Colors.black),
                          backgroundColor: Colors.black12,
                          progressColor: activeCalls.progressStyleColor,
                        ),
                        Expanded(child: SizedBox()),
                        Text((activeCalls.dispatchStatusName.toUpperCase()),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: activeCalls.progressStyleColor)),
                        //Expanded(child: SizedBox()),
                        FlatButton.icon(
                            onPressed: () {
                              Provider.of<Calls>(context, listen:false).selectedCall = activeCalls;
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                      new AddEditCallScreen(0)));
                            },
                            icon: Icon(Icons.edit, size:14),
                            label: Text('Edit Call', style:TextStyle(fontSize:12, fontWeight: FontWeight.w500, color:Color(0xff303030)))),
                        FlatButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return
                                      UpdateStatus(activeCalls.id,
                                          activeCalls.dispatchStatusName,
                                          activeCalls
                                              .dispatchInstructions_string, userRole, dispatchPaging, activeCalls.towType);
                                  });
                            },
                            icon: Icon(Icons.update, size:14),
                            label: Text('Update Status', style:TextStyle(fontSize:12, fontWeight: FontWeight.w500, color:Color(0xff303030)))),
                      ]),
                      Text(
                          '\$${activeCalls.towedTotalAmount.toStringAsFixed(
                              2)}',
                          //towedTotalAmount
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 12)),
    Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: (Column(
    children: <Widget>[
                      Text((activeCalls.towReasonName.toUpperCase()),
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color:Color(0xffB5B5B4))),]))),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:Color(0xff303030))),
                                Text(' '),
                                Text(('(' + activeCalls.color + ')'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:Color(0xff303030))),
                              ],
                            ),
    Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: (Column(
    children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Text((activeCalls.towedInvoice),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 12,  color:Color(0xffB5B5B4))),
                              ],
                            )]))),
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
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500, color:Color(0xff303030))),
                                Text(' '),
                                Text((activeCalls.dispatchDate),
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color:Color(0xffB5B5B4))),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text((activeCalls.dispatchContact),
                                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500, color:Color(0xff303030),)),
                                Text(' '),
                                Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: (Column(
                                children: <Widget>[
                                new GestureDetector(
                                  onTap: () {
                                    launch("tel://" +
                                        activeCalls.dispatchContactPhone);
                                  },
                                  child: Text(
                                      (activeCalls.dispatchContactPhone),
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color:Color(0xff6C89BA),)),
                                )]))),

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
                          Text(
                              (activeCalls.towedStreet != null ? activeCalls.towedStreet :''  +
                                  ' ' +
                                  activeCalls.towedStreetTwo != null ? activeCalls.towedStreetTwo:'' +
                                  ' ' +
                                  activeCalls.towedCityName != null ? activeCalls.towedCityName:'' +
                                  ' ' +
                                  activeCalls.towedStateName != null ? activeCalls.towedStateName:'' +
                                  ' ' +
                                  activeCalls.towedZipCode  != null ? activeCalls.towedZipCode:''),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13,color:Color(0xff303030))),
                        ],
                      ),
                    ]))
            ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: (Column(
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    Text(
                                        (activeCalls.towedToStreet != null ? activeCalls.towedToStreet :''  +
                                            ' ' +
                                            activeCalls.towedToStreetTwo != null ? activeCalls.towedToStreetTwo :''  +
                                            ' ' +
                                            activeCalls.towedToCityName != null ? activeCalls.towedToCityName :''  +
                                            ' ' +
                                            activeCalls.towedToStateName != null ? activeCalls.towedToStateName :''  +
                                            ' ' +
                                            activeCalls.towedToZipCode != null ? activeCalls.towedToZipCode :''),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600, fontSize: 13,color:Color(0xff303030))),
                                  ],
                                ),
                              ]))
                      ),
                    ],
                  ))),
        ]));
  }
  }



