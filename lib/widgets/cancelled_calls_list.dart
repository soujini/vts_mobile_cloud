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

class CancelledCallsList extends StatefulWidget {
  var userRole;
  var dispatchPaging;
  int selectedTabIndex;
  final Function notifyParent;
  var refreshMainTabController;
  int selectedCallsTabIndex;

  CancelledCallsList(
      {Key key,
      this.userRole,
      this.dispatchPaging,
      this.selectedTabIndex,
      this.notifyParent,
      this.refreshMainTabController,
      this.selectedCallsTabIndex})
      : super(key: key);

  @override
  _CancelledCallsList createState() => _CancelledCallsList();
}

class _CancelledCallsList extends State<CancelledCallsList> {
  static const int PAGE_SIZE = 15;

  Future<List> _refreshCallsList(BuildContext context) async {
    return await Provider.of<Calls>(context, listen: false)
        .listMiniMobile('cancelled', 0, PAGE_SIZE, "")
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
            key: UniqueKey(),
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
                Provider.of<Calls>(context, listen: false)
                    .listMiniMobile('cancelled', pageIndex, PAGE_SIZE, "")));
  }

  refresh() {
    setState(() {});
  }

  _showErrorMessage(BuildContext context, errorMessage) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        backgroundColor: Colors.lightGreen,
        content: Text(errorMessage,
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w500))));
  }

  Widget _itemBuilder(context, cancelledCalls, index) {
    cancelledCalls.dispatchInstructions_string =
        cancelledCalls.dispatchInstructions_string.replaceAll("\\n", "\n");
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new VehicleInfoScreen(cancelledCalls)));
        },
        child: Column(children: <Widget>[
          index == 0
              ? Padding(
                  padding: EdgeInsets.all(15),
                  child: Text("Total " + cancelledCalls.count.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1C3764))))
              : Text(''),
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
                              Provider.of<Calls>(context, listen: false)
                                  .selectedCall = cancelledCalls;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new AddEditCallScreen(
                                        0, widget.selectedTabIndex)),
                              ).then((value) => setState(() {}));
                            },
                            textColor: Colors.grey,
                            icon: Icon(Icons.edit, size: 14),
                            label: Text('Edit Call',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff303030)))),
                        FlatButton.icon(
                            onPressed: () {
                              if (cancelledCalls.wreckerDriver == null ||
                                  cancelledCalls.wreckerDriver == '' ||
                                  cancelledCalls.wreckerDriver == 0 ||
                                  cancelledCalls.towTruck == null ||
                                  cancelledCalls.towTruck == '' ||
                                  cancelledCalls.towTruck == 0) {
                                _showErrorMessage(context,
                                    "Please select the Driver and Truck information on the Tow Tab");
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return UpdateStatus(
                                          selectedCall: cancelledCalls,
                                          userRole: widget.userRole,
                                          dispatchPaging: widget.dispatchPaging,
                                          notifyParent: refresh);
                                    });
                                // showDialogUpdateStatus(context);
                              }
                            },
                            // textColor: Colors.grey,
                            icon: Icon(Icons.update, size: 14),
                            label: Text('Update Status',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff303030)))),
                      ]),
                      Text(
                          '\$${cancelledCalls.towedTotalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 12)),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: (Column(children: <Widget>[
                            cancelledCalls.towReasonName != null &&
                                    cancelledCalls.towReasonName != ''
                                ? Text(
                                    (cancelledCalls.towReasonName
                                        .toUpperCase()),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Color(0xffB5B5B4)))
                                : Row(),
                          ]))),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: (Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Text(
                                    (cancelledCalls.vehicleYear.toString() +
                                        ' ' +
                                        cancelledCalls.vehicleMakeName +
                                        ' ' +
                                        cancelledCalls
                                            .vehicleYearMakeModelName),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff303030))),
                                Text(' '),
                                Text(('(' + cancelledCalls.color + ')'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff303030))),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: (Column(children: <Widget>[
                                  new Row(
                                    children: <Widget>[
                                      Text((cancelledCalls.towedInvoice),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14)),
                                    ],
                                  )
                                ]))),
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
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff303030))),
                                Text(' '),
                                Text((cancelledCalls.dispatchDate),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffB5B5B4))),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text((cancelledCalls.dispatchContact),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff303030),
                                    )),
                                Text(' '),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: (Column(children: <Widget>[
                                      new GestureDetector(
                                        onTap: () {
                                          launch("tel://" +
                                              cancelledCalls
                                                  .dispatchContactPhone);
                                        },
                                        child: Text(
                                            (cancelledCalls
                                                .dispatchContactPhone),
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff6C89BA),
                                            )),
                                      )
                                    ]))),
                              ],
                            ),
                          ],
                        )),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: (Column(children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Text(
                                    (cancelledCalls.towedStreet != null
                                        ? cancelledCalls.towedStreet
                                            .replaceAll("\\", "")
                                        : '' +
                                                    ' ' +
                                                    cancelledCalls
                                                        .towedStreetTwo !=
                                                null
                                            ? cancelledCalls.towedStreetTwo
                                                .replaceAll("\\", "")
                                            : '' +
                                                        ' ' +
                                                        cancelledCalls
                                                            .towedCityName !=
                                                    null
                                                ? cancelledCalls.towedCityName
                                                : '' +
                                                            ' ' +
                                                            cancelledCalls
                                                                .towedStateName !=
                                                        null
                                                    ? cancelledCalls
                                                        .towedStateName
                                                    : '' +
                                                                ' ' +
                                                                cancelledCalls
                                                                    .towedZipCode !=
                                                            null
                                                        ? cancelledCalls
                                                            .towedZipCode
                                                        : ''),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Color(0xff303030))),
                              ],
                            ),
                          ]))),
                      cancelledCalls.towedToStreet != null &&
                              cancelledCalls.towedToStreet != ''
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: (Column(children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    Text(
                                        (cancelledCalls.towedToStreet != null
                                            ? cancelledCalls.towedToStreet
                                                .replaceAll("\\", "")
                                            : '' +
                                                        ' ' +
                                                        cancelledCalls
                                                            .towedToStreetTwo !=
                                                    null
                                                ? cancelledCalls
                                                    .towedToStreetTwo
                                                    .replaceAll("\\", "")
                                                : '' +
                                                            ' ' +
                                                            cancelledCalls
                                                                .towedToCityName !=
                                                        null
                                                    ? cancelledCalls
                                                        .towedToCityName
                                                    : '' +
                                                                ' ' +
                                                                cancelledCalls
                                                                    .towedToStateName !=
                                                            null
                                                        ? cancelledCalls
                                                            .towedToStateName
                                                        : '' +
                                                                    ' ' +
                                                                    cancelledCalls
                                                                        .towedToZipCode !=
                                                                null
                                                            ? cancelledCalls
                                                                .towedToZipCode
                                                            : ''),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Color(0xff303030))),
                                  ],
                                ),
                              ])))
                          : Row(),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: (Column(children: <Widget>[
                            cancelledCalls.dispatchInstructions_string !=
                                        null &&
                                    cancelledCalls
                                            .dispatchInstructions_string !=
                                        '' &&
                                    cancelledCalls
                                            .dispatchInstructions_string !=
                                        'null' &&
                                    cancelledCalls
                                            .dispatchInstructions_string !=
                                        '--'
                                ? Text(
                                    (cancelledCalls
                                        .dispatchInstructions_string),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff6C89BA)))
                                : Row(),
                          ]))),
                    ],
                  ))),
          //Divider()
        ]));
  }
}
