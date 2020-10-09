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

class CompletedCallsList extends StatefulWidget {
  var userRole;
  var dispatchPaging;
  int selectedTabIndex;
  final Function notifyParent;
  var refreshMainTabController;
  CompletedCallsList({Key key, this.userRole, this.dispatchPaging, this.selectedTabIndex, this.notifyParent, this.refreshMainTabController}) : super(key: key);

  @override
  _CompletedCallsList createState() => _CompletedCallsList();
}
class _CompletedCallsList extends State<CompletedCallsList> {
  static const int PAGE_SIZE = 15;

  Future<List> _refreshCallsList(BuildContext context) async {
    return await Provider.of<Calls>(context, listen:false)
        .listMiniMobile('completed', 0, PAGE_SIZE,"")
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
            key:UniqueKey(),
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
                .listMiniMobile('completed', pageIndex, PAGE_SIZE,"")));
  }

  Widget _itemBuilder(context, completedCalls, index) {
    completedCalls.dispatchInstructions_string = completedCalls.dispatchInstructions_string.replaceAll("\\n", "\n");
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new VehicleInfoScreen(completedCalls)));
        },
        child: Column(children: <Widget>[
          index == 0 ? Padding(
              padding: EdgeInsets.all(15),
              child:Text("Total "+completedCalls.count.toString(), style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff1C3764)))) : Text(''),
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
                          percent: completedCalls.progressPercentage,
//                                        header: new Text("Icon header"),
                          center: new Icon(Icons.directions_car,
                              size: 12.0, color: Colors.black),
                          backgroundColor: Colors.black12,
                          progressColor: completedCalls.progressStyleColor,
                        ),
                        Expanded(child: SizedBox()),
                        Text((completedCalls.dispatchStatusName.toUpperCase()),
                            // .toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: completedCalls.progressStyleColor)),
                        //Expanded(child: SizedBox()),
                        FlatButton.icon(
                            onPressed: () {
                              Provider.of<Calls>(context, listen:false).selectedCall = completedCalls;
                              // Navigator.pop(context);
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new AddEditCallScreen(0, widget.selectedTabIndex)),).then((value) => setState(() {}));
                            },
                            icon: Icon(Icons.edit, size:14),
                            label: Text('Edit Call', style:TextStyle(fontSize:12, fontWeight: FontWeight.w500, color:Color(0xff303030)))),
                        FlatButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return UpdateStatus(completedCalls.id, completedCalls.dispatchStatusName, completedCalls.dispatchInstructions_string, widget.userRole, widget.dispatchPaging, completedCalls.towType);
                                  });
                              // showDialogUpdateStatus(context);
                            },
                            icon: Icon(Icons.update),
                            label: Text('Update Status', style:TextStyle(fontSize:12, fontWeight: FontWeight.w500, color:Color(0xff303030)))),
                      ]),
                      Text(
                          '\$${completedCalls.towedTotalAmount.toStringAsFixed(2)}',
                          //towedTotalAmount
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 12)),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: (Column(
                            children: <Widget>[
                              completedCalls.towReasonName != null && completedCalls.towReasonName != ''?
                      Text((completedCalls.towReasonName),
                              style: TextStyle(color: Colors.grey,
                              fontSize: 14)):Row(),]))),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: (Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Text(
                                    (completedCalls.vehicleYear.toString() +
                                        ' ' +
                                        completedCalls.vehicleMakeName + ' ' +
                                        completedCalls.vehicleYearMakeModelName),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:Color(0xff303030))),
                                Text(' '),
                                Text(('(' + completedCalls.color + ')'),
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
                                Text((completedCalls.towedInvoice),
                                  style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14)),
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
                                Text((completedCalls.towCustomerName),
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500, color:Color(0xff303030))),
                                Text(' '),
                                Text((completedCalls.dispatchDate),
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color:Color(0xffB5B5B4))),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text((completedCalls.dispatchContact),
                                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500, color:Color(0xff303030),)),
                                Text(' '),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: (Column(
                                        children: <Widget>[
                                          new GestureDetector(
                                            onTap: () {
                                              launch("tel://" +
                                                  completedCalls.dispatchContactPhone);
                                            },
                                            child: Text(
                                                (completedCalls.dispatchContactPhone),
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
                                      (completedCalls.towedStreet != null ? completedCalls.towedStreet :''  +
                                          ' ' +
                                          completedCalls.towedStreetTwo != null ? completedCalls.towedStreetTwo:'' +
                                          ' ' +
                                          completedCalls.towedCityName != null ? completedCalls.towedCityName:'' +
                                          ' ' +
                                          completedCalls.towedStateName != null ? completedCalls.towedStateName:'' +
                                          ' ' +
                                          completedCalls.towedZipCode  != null ? completedCalls.towedZipCode:''),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 13,color:Color(0xff303030))),
                                ],
                              ),
                            ]))),
                      completedCalls.towedToStreet != null && completedCalls.towedToStreet != ''?
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: (Column(
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    Text(
                                        (completedCalls.towedToStreet != null ? completedCalls.towedToStreet :''  +
                                            ' ' +
                                            completedCalls.towedToStreetTwo != null ? completedCalls.towedToStreetTwo :''  +
                                            ' ' +
                                            completedCalls.towedToCityName != null ? completedCalls.towedToCityName :''  +
                                            ' ' +
                                            completedCalls.towedToStateName != null ? completedCalls.towedToStateName :''  +
                                            ' ' +
                                            completedCalls.towedToZipCode != null ? completedCalls.towedToZipCode :''),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600, fontSize: 13,color:Color(0xff303030))),
                                  ],
                                ),
                              ]))) : Row(),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: (Column(
                              children: <Widget>[
                                completedCalls.dispatchInstructions_string != null && completedCalls.dispatchInstructions_string != '' && completedCalls.dispatchInstructions_string != 'null' && completedCalls.dispatchInstructions_string != '--'?
                                Text((completedCalls.dispatchInstructions_string),
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color:Color(0xff6C89BA))):Row(),]))),
                    ],
                  ))),
          //Divider()
        ]));
  }
}


































