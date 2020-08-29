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

class CancelledCallsList extends StatelessWidget {
  CancelledCallsList(this.userRole, this.dispatchPaging);
  final userRole;
   var dispatchPaging;

  static const int PAGE_SIZE = 15;
  Future<List> _refreshCallsList(BuildContext context) async {
    return await Provider.of<Calls>(context, listen:false)
        .listMiniMobile('cancelled', 0, PAGE_SIZE,"")
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
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: [
                        CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 5.0,
                          percent: cancelledCalls.progressPercentage,
                          center: new Icon(Icons.directions_car,
                              size: 12.0, color: Colors.black),
                          backgroundColor: Colors.black12,
                          progressColor: cancelledCalls.progressStyleColor,
                        ),
                        Expanded(child: SizedBox()),
                        Text((cancelledCalls.dispatchStatusName.toUpperCase()),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: cancelledCalls.progressStyleColor)),
                        FlatButton.icon(
                            onPressed: () {
                              Provider.of<Calls>(context, listen:false).selectedCall = cancelledCalls;
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                      new AddEditCallScreen(0)));
                            },
                            textColor: Colors.grey,
                            icon: Icon(Icons.edit, size:14),
                            label: Text('Edit Call', style:TextStyle(fontSize:12, fontWeight: FontWeight.w500, color:Color(0xff303030)))),
                        FlatButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return UpdateStatus(cancelledCalls.id,cancelledCalls.dispatchStatusName, cancelledCalls.dispatchInstructions_string, userRole, dispatchPaging, cancelledCalls.towType);
                                  });
                              // showDialogUpdateStatus(context);
                            },
                            textColor: Colors.grey,
                            icon: Icon(Icons.update, size:14),
                            label: Text('Update Status', style:TextStyle(fontSize:12, fontWeight: FontWeight.w500, color:Color(0xff303030)))),
                      ]),
                      Text(
                          '\$${cancelledCalls.towedTotalAmount.toStringAsFixed(2)}',
                          //towedTotalAmount
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 12)),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: (Column(
                              children: <Widget>[
                                cancelledCalls.towReasonName != null && cancelledCalls.towReasonName != ''?
                                Text((cancelledCalls.towReasonName.toUpperCase()),
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color:Color(0xffB5B5B4))):Row(),]))),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: (Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Text(
                                    (cancelledCalls.vehicleYear.toString() +
                                        ' ' +
                                        cancelledCalls.vehicleMakeName + ' ' +
                                        cancelledCalls.vehicleYearMakeModelName),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:Color(0xff303030))),
                                Text(' '),
                                Text(('(' + cancelledCalls.color + ')'),
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
                                Text((cancelledCalls.towedInvoice),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
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
                                Text((cancelledCalls.towCustomerName),
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500, color:Color(0xff303030))),
                                Text(' '),
                                Text((cancelledCalls.dispatchDate),
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color:Color(0xffB5B5B4))),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text((cancelledCalls.dispatchContact),
                                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500, color:Color(0xff303030),)),
                                Text(' '),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: (Column(
                                        children: <Widget>[
                                          new GestureDetector(
                                            onTap: () {
                                              launch("tel://" +
                                                  cancelledCalls.dispatchContactPhone);
                                            },
                                            child: Text(
                                                (cancelledCalls.dispatchContactPhone),
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
                                      (cancelledCalls.towedStreet != null ? cancelledCalls.towedStreet :''  +
                                          ' ' +
                                          cancelledCalls.towedStreetTwo != null ? cancelledCalls.towedStreetTwo :''  +
                                          ' ' +
                                          cancelledCalls.towedCityName != null ? cancelledCalls.towedCityName :''  +
                                          ' ' +
                                          cancelledCalls.towedStateName != null ? cancelledCalls.towedStateName :''  +
                                          ' ' +
                                          cancelledCalls.towedZipCode  != null ? cancelledCalls.towedZipCode :''),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 13,color:Color(0xff303030))),
                                ],
                              ),
                            ]))),
                      cancelledCalls.towedToStreet != null && cancelledCalls.towedToStreet != ''?
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: (Column(
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  Text(
                                      (cancelledCalls.towedToStreet != null ? cancelledCalls.towedToStreet :''  +
                                          ' ' +
                                          cancelledCalls.towedToStreetTwo != null ? cancelledCalls.towedToStreetTwo :''  +
                                          ' ' +
                                          cancelledCalls.towedToCityName != null ? cancelledCalls.towedToCityName :''  +
                                          ' ' +
                                          cancelledCalls.towedToStateName != null ? cancelledCalls.towedToStateName :''  +
                                          ' ' +
                                          cancelledCalls.towedToZipCode  != null ? cancelledCalls.towedToZipCode :''),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 13,color:Color(0xff303030))),
                                ],
                              ),
                            ]))) :Row()
                    ],
                  ))),
          //Divider()
        ]));
  }
}
