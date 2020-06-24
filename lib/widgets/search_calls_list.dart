import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';

import '../providers/calls_provider.dart';
import '../screens/vehicle_info.dart';
import '../screens/add_edit_call.dart';
import '../widgets/update_status.dart';

class SearchCallsList extends StatelessWidget {
  String filterFields="";
  SearchCallsList(this.filterFields);
  static const int PAGE_SIZE = 15;
  Future<List> _refreshCallsList(BuildContext context) async {
    return await Provider.of<Calls>(context, listen:false)
        .listMiniMobile('search', 0, PAGE_SIZE, filterFields)
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
            pageFuture: (pageIndex) => Provider.of<Calls>(context, listen:false)
                .listMiniMobile('search', pageIndex, PAGE_SIZE,filterFields)));
  }

  Widget _itemBuilder(context, searchedCalls, _) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new VehicleInfoScreen(searchedCalls)));
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
                          percent: searchedCalls.progressPercentage,
//                                        header: new Text("Icon header"),
                          center: new Icon(Icons.directions_car,
                              size: 15.0, color: Colors.black),
                          backgroundColor: Colors.black12,
                          progressColor: searchedCalls.progressStyleColor,
                        ),
                        Expanded(child: SizedBox()),
                        Text((searchedCalls.dispatchStatusName.toUpperCase()),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: searchedCalls.progressStyleColor)),
                        //Expanded(child: SizedBox()),
                        FlatButton.icon(
                            onPressed: () {
                              Provider.of<Calls>(context, listen:false).selectedCall.id = searchedCalls.id;
                              Provider.of<Calls>(context, listen:false).selectedCall.dispatchStatusName = searchedCalls.dispatchStatusName;
                              Provider.of<Calls>(context, listen:false).selectedCall.dispatchInstructions_string = searchedCalls.dispatchInstructions_string;
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
                                    return UpdateStatus(searchedCalls.id, searchedCalls.dispatchStatusName, searchedCalls.dispatchInstructions_string);
                                  });
                              // showDialogUpdateStatus(context);
                            },
                            textColor: Colors.grey,
                            icon: Icon(Icons.update),
                            label: Text('Update Status')),
                      ]),
                      Text(
                          '\$${searchedCalls.towedTotalAmount.toStringAsFixed(2)}',
                          //towedTotalAmount
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 14)),
                      Text((searchedCalls.towReasonName),
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: (Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Text(
                                    (searchedCalls.vehicleYear.toString() +
                                        ' ' +
                                        searchedCalls.vehicleYearMakeModelName),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(' '),
                                Text(('(' + searchedCalls.color + ')'),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text((searchedCalls.towedInvoice),
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
                                Text((searchedCalls.towCustomerName),
                                    style: TextStyle(fontSize: 14)),
                                Text(' '),
                                Text((searchedCalls.dispatchDate),
                                    style: TextStyle(fontSize: 14)),

////                                          Text(
////                                              (DateFormat('MM-dd-yyyy')
////                                                  .format(searchedCalls
////                                                  .dispatchDate)),
////                                              style: TextStyle(
////                                                  fontSize: 14)),
                                Text(' '),
////                                          Text(
////                                              ('(' +
////                                                  DateFormat('H:mm')
////                                                      .format(searchedCalls[
////                                                  index]
////                                                      .dispatchDispatchTime) +
////                                                  ')'),
////                                              style: TextStyle(
////                                                  color: Colors.grey,
////                                                  fontSize: 14)),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text((searchedCalls.dispatchContact),
                                    style: TextStyle(fontSize: 14)),
                                Text(' '),
                                Text((searchedCalls.dispatchContactPhone),
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text(
                                    (searchedCalls.towedStreet +
                                        ' ' +
                                        searchedCalls.towedStreetTwo +
                                        ' ' +
                                        searchedCalls.towedCityName +
                                        ' ' +
                                        searchedCalls.towedStateName +
                                        ' ' +
                                        searchedCalls.towedZipCode),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text(
                                    (searchedCalls.towedToStreet +
                                        ' ' +
                                        searchedCalls.towedToStreetTwo +
                                        ' ' +
                                        searchedCalls.towedToCityName +
                                        ' ' +
                                        searchedCalls.towedToStateName +
                                        ' ' +
                                        searchedCalls.towedToZipCode),
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

//  @override
//  Widget build(BuildContext context) {
//    return RefreshIndicator(
//        onRefresh: () => _refreshCallsList(context),
//        child: PagewiseListView(
//            errorBuilder: (context, error) {
//              return Text(error);
//            },
//            showRetry: false,
//            loadingBuilder: (context) {
//              return Loader();
////              return CircularProgressIndicator(
//////                backgroundColor: Colors.green,
////              );
//            },
//            noItemsFoundBuilder: (context) {
//              return Text('No Items Found');
//            },
//            pageSize: PAGE_SIZE,
//            itemBuilder: this._itemBuilder,
//            pageFuture: (pageIndex) => Provider.of<Calls>(context)
//                .listMiniMobile('search', pageIndex, PAGE_SIZE,filterFields)));
//  }
//
//  Widget _itemBuilder(context, searchedCalls, _) {
//    return
//    GestureDetector(
//        onTap: () {
//          Navigator.push(
//              context,
//              new MaterialPageRoute(
//                  builder: (context) => new VehicleInfoScreen(searchedCalls)));
//        },
//        child: Column(children: <Widget>[
//          Card(
//              child: Padding(
//                  padding: EdgeInsets.all(10),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Row(children: [
//                        CircularPercentIndicator(
//                          radius: 40.0,
//                          lineWidth: 5.0,
//                          percent: searchedCalls.progressPercentage,
////                                        header: new Text("Icon header"),
//                          center: new Icon(Icons.directions_car,
//                              size: 15.0, color: Colors.black),
//                          backgroundColor: Colors.black12,
//                          progressColor: searchedCalls.progressStyleColor,
//                        ),
//                        Expanded(child: SizedBox()),
//                        Text((searchedCalls.dispatchStatusName.toUpperCase()),
//                            // .toUpperCase(),
//                            style: TextStyle(
//                                fontSize: 14,
//                                fontWeight: FontWeight.bold,
//                                color: searchedCalls.progressStyleColor)),
//                        //Expanded(child: SizedBox()),
//                        FlatButton.icon(
//                            onPressed: () {
//                              Navigator.push(
//                                  context,
//                                  new MaterialPageRoute(
//                                      builder: (context) =>
//                                      new AddEditCallScreen()));
//                            },
//                            textColor: Colors.grey,
//                            icon: Icon(Icons.edit),
//                            label: Text('Edit Call')),
//                        FlatButton.icon(
//                            onPressed: () {
//                              showDialog(
//                                  context: context,
//                                  builder: (BuildContext context) {
//                                    return UpdateStatus(int.parse(searchedCalls.id),searchedCalls.dispatchStatusName, searchedCalls.dispatchInstructions_string);
//                                  });
//                              // showDialogUpdateStatus(context);
//                            },
//                            textColor: Colors.grey,
//                            icon: Icon(Icons.update),
//                            label: Text('Update Status')),
//                      ]),
//                      Text(
//                          '\$${searchedCalls.towedTotalAmount.toStringAsFixed(2)}',
//                          //towedTotalAmount
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold,
//                              color: Colors.green,
//                              fontSize: 14)),
//                      Text((searchedCalls.towReasonName),
//                          style: TextStyle(color: Colors.grey, fontSize: 14)),
//                      Padding(
//                        padding: EdgeInsets.symmetric(vertical: 5),
//                        child: (Column(
//                          children: <Widget>[
//                            new Row(
//                              children: <Widget>[
//                                Text(
//                                    (searchedCalls.vehicleYear +
//                                        ' ' +
//                                        searchedCalls.vehicleYearMakeModelName),
//                                    style: TextStyle(
//                                        fontSize: 16,
//                                        fontWeight: FontWeight.bold)),
//                                Text(' '),
//                                Text(('(' + searchedCalls.color + ')'),
//                                    style: TextStyle(
//                                        fontSize: 16,
//                                        fontWeight: FontWeight.bold)),
//                              ],
//                            ),
//                            new Row(
//                              children: <Widget>[
//                                Text((searchedCalls.towedInvoice),
//                                    style: TextStyle(
//                                        color: Colors.grey, fontSize: 14)),
//                              ],
//                            ),
//                          ],
//                        )),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.symmetric(vertical: 5),
//                        child: (Column(
//                          children: <Widget>[
//                            new Row(
//                              children: <Widget>[
//                                Text((searchedCalls.towCustomerName),
//                                    style: TextStyle(fontSize: 14)),
//                                Text(' '),
//                                Text((searchedCalls.dispatchDate),
//                                    style: TextStyle(fontSize: 14)),
//
////                                          Text(
////                                              (DateFormat('MM-dd-yyyy')
////                                                  .format(searchedCalls
////                                                  .dispatchDate)),
////                                              style: TextStyle(
////                                                  fontSize: 14)),
//                                Text(' '),
////                                          Text(
////                                              ('(' +
////                                                  DateFormat('H:mm')
////                                                      .format(searchedCalls[
////                                                  index]
////                                                      .dispatchDispatchTime) +
////                                                  ')'),
////                                              style: TextStyle(
////                                                  color: Colors.grey,
////                                                  fontSize: 14)),
//                              ],
//                            ),
//                            new Row(
//                              children: <Widget>[
//                                Text((searchedCalls.dispatchContact),
//                                    style: TextStyle(fontSize: 14)),
//                                Text(' '),
//                                Text((searchedCalls.dispatchContactPhone),
//                                    style: TextStyle(fontSize: 14)),
//                              ],
//                            ),
//                            new Row(
//                              children: <Widget>[
//                                Text(
//                                    (searchedCalls.towedStreet +
//                                        ' ' +
//                                        searchedCalls.towedStreetTwo +
//                                        ' ' +
//                                        searchedCalls.towedCityName +
//                                        ' ' +
//                                        searchedCalls.towedStateName +
//                                        ' ' +
//                                        searchedCalls.towedZipCode),
//                                    style: TextStyle(
//                                        color: Colors.grey, fontSize: 14)),
//                              ],
//                            ),
//                            new Row(
//                              children: <Widget>[
//                                Text(
//                                    (searchedCalls.towedToStreet +
//                                        ' ' +
//                                        searchedCalls.towedToStreetTwo +
//                                        ' ' +
//                                        searchedCalls.towedToCityName +
//                                        ' ' +
//                                        searchedCalls.towedToStateName +
//                                        ' ' +
//                                        searchedCalls.towedToZipCode),
//                                    style: TextStyle(
//                                        color: Colors.grey, fontSize: 14)),
//                              ],
//                            ),
//                          ],
//                        )),
//                      ),
//                    ],
//                  ))),
//          //Divider()
//        ]));
//  }
}
