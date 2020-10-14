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

class SearchCallsList extends StatefulWidget {
  var userRole;
  var dispatchPaging;
  var filterFields;
  SearchCallsList(this.filterFields, this.userRole, this.dispatchPaging);

  @override
  _SearchCallsList createState() => _SearchCallsList();
}

class _SearchCallsList extends State<SearchCallsList> {
  static const int PAGE_SIZE = 15;

  Future<List> _refreshCallsList(BuildContext context) async {
    return await Provider.of<Calls>(context, listen: false)
        .listMiniMobile('search', 0, PAGE_SIZE, widget.filterFields)
        .catchError((onError) {
      showDialog(
          context: context,
          builder: ((context) =>
              AlertDialog(
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
                    .listMiniMobile(
                    'search', pageIndex, PAGE_SIZE, widget.filterFields)));
  }
  refresh(){
    setState(() {

    });
  }
  Widget _itemBuilder(context, searchedCalls, index) {
    searchedCalls.dispatchInstructions_string = searchedCalls.dispatchInstructions_string.replaceAll("\\n", "\n");
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new VehicleInfoScreen(searchedCalls)));
        },
        child: Column(children: <Widget>[
          index == 0 ? Padding(
              padding: EdgeInsets.all(15),
              child:Text("Total "+searchedCalls.count.toString(), style: TextStyle(
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
                          percent: searchedCalls.progressPercentage,
                          center: new Icon(Icons.directions_car,
                              size: 12.0, color: Colors.black),
                          backgroundColor: Colors.black12,
                          progressColor: searchedCalls.progressStyleColor,
                        ),
                        Expanded(child: SizedBox()),
                        Text((searchedCalls.dispatchStatusName.toUpperCase()),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: searchedCalls.progressStyleColor)),
                        //Expanded(child: SizedBox()),
                        FlatButton.icon(
                            onPressed: () {
                              Provider.of<Calls>(context, listen: false).selectedCall = searchedCalls;
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                      new AddEditCallScreen(0, 0)),).then((value) => setState(() {}));
                            },
                            textColor: Colors.grey,
                            icon: Icon(Icons.edit, size:14),
                            label: Text('Edit Call', style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff303030)))),
                        FlatButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {

                                    return UpdateStatus(
                                        selectedCall: searchedCalls,
                                        userRole:widget.userRole,
                                        dispatchPaging: widget.dispatchPaging,
                                        notifyParent:refresh
                                    );
                                  });
                            },
                            textColor: Colors.grey,
                            icon: Icon(Icons.update, size:14),
                            label: Text('Update Status', style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff303030)))),
                      ]),
                      Text(
                          '\$${searchedCalls.towedTotalAmount.toStringAsFixed( 2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 12)),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: (Column(
                              children: <Widget>[
                                searchedCalls.towReasonName != null && searchedCalls.towReasonName != ''?
                                Text((searchedCalls.towReasonName.toUpperCase()),
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color:Color(0xffB5B5B4))):Row(),]))),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: (Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Text(
                                    (searchedCalls.vehicleYear.toString() +
                                        ' ' +
                                        searchedCalls.vehicleMakeName + ' ' +
                                        searchedCalls.vehicleYearMakeModelName),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:Color(0xff303030))),
                                Text(' '),
                                Text(('(' + searchedCalls.color + ')'),
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
                                          Text((searchedCalls.towedInvoice),
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
                                Text((searchedCalls.towCustomerName),
                                    style: TextStyle(fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff303030))),
                                Text(' '),
                                Text((searchedCalls.dispatchDate),
                                    style: TextStyle(fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffB5B5B4))),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text((searchedCalls.dispatchContact),
                                    style: TextStyle(fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff303030),)),
                                Text(' '),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: (Column(
                                        children: <Widget>[
                                          new GestureDetector(
                                            onTap: () {
                                              launch("tel://" +
                                                  searchedCalls
                                                      .dispatchContactPhone);
                                            },
                                            child: Text(
                                                (searchedCalls
                                                    .dispatchContactPhone),
                                                style: TextStyle(fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff6C89BA),)),
                                          )
                                        ]))),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: (Column(
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          Text(
                                              (searchedCalls.towedStreet != null
                                                  ? searchedCalls.towedStreet.replaceAll("\\", "")
                                                  : '' +
                                                  ' ' +
                                                  searchedCalls
                                                      .towedStreetTwo != null
                                                  ? searchedCalls.towedStreetTwo.replaceAll("\\", "")
                                                  : '' +
                                                  ' ' +
                                                  searchedCalls.towedCityName !=
                                                  null ? searchedCalls
                                                  .towedCityName : '' +
                                                  ' ' +
                                                  searchedCalls
                                                      .towedStateName != null
                                                  ? searchedCalls.towedStateName
                                                  : '' +
                                                  ' ' +
                                                  searchedCalls.towedZipCode !=
                                                  null ? searchedCalls
                                                  .towedZipCode : ''),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: Color(0xff303030))),
                                        ],
                                      )
                                    ]))),
                            searchedCalls.towedToStreet != null &&
                                searchedCalls.towedToStreet != '' ?
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: (Column(
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          Text(
                                              (searchedCalls.towedToStreet !=
                                                  null ? searchedCalls
                                                  .towedToStreet.replaceAll("\\", "") : '' +
                                                  ' ' +
                                                  searchedCalls
                                                      .towedToStreetTwo != null
                                                  ? searchedCalls
                                                  .towedToStreetTwo.replaceAll("\\", "")
                                                  : '' +
                                                  ' ' +
                                                  searchedCalls
                                                      .towedToCityName != null
                                                  ? searchedCalls
                                                  .towedToCityName
                                                  : '' +
                                                  ' ' +
                                                  searchedCalls
                                                      .towedToStateName != null
                                                  ? searchedCalls
                                                  .towedToStateName
                                                  : '' +
                                                  ' ' +
                                                  searchedCalls
                                                      .towedToZipCode != null
                                                  ? searchedCalls.towedToZipCode
                                                  : ''),

                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: Color(0xff303030))),
                                        ],
                                      ),
                                    ]))) : Row(),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),

                                child: (Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      searchedCalls.dispatchInstructions_string != null && searchedCalls.dispatchInstructions_string != '' && searchedCalls.dispatchInstructions_string != 'null' && searchedCalls.dispatchInstructions_string != '--'?
                                      Text((searchedCalls.dispatchInstructions_string),
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color:Color(0xff6C89BA))):Row(),]))),
                          ],
                        )),
                      ),
                    ],
                  ))),
          //Divider()
        ]));
  }
}