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

class ActiveCallsList extends StatefulWidget {
  var userRole;
  var dispatchPaging;
  int selectedTabIndex = 0;
  final Function notifyParent;
  var refreshMainTabController;
  int selectedCallsTabIndex;
  ActiveCallsList({Key key, this.userRole, this.dispatchPaging, this.notifyParent, this.refreshMainTabController, this.selectedCallsTabIndex}) : super(key: key);

  @override
  _ActiveCallsList createState() => _ActiveCallsList();
}
class _ActiveCallsList extends State<ActiveCallsList> {
  static const int PAGE_SIZE = 15;
  // @override
  void initState() {
    super.initState();
  }

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
                          .listMiniMobile('active', pageIndex, PAGE_SIZE, "")
              ));
    ;
  }
  refresh(){
    setState(() {

    });
  }
  _showErrorMessage(BuildContext context, errorMessage) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        backgroundColor: Colors.lightGreen,
        content: Text(errorMessage,
            style:
            TextStyle(color: Colors.black, fontWeight: FontWeight.w500))));
  }

  Widget _itemBuilder(context, activeCalls, index) {
    activeCalls.dispatchInstructions_string = activeCalls.dispatchInstructions_string.replaceAll("\\n", "\n");
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new VehicleInfoScreen(activeCalls)));
        },
        child:Column(children: <Widget>[
        index == 0 ? Padding(
        padding: EdgeInsets.all(15),
           child:Text("Total "+activeCalls.count.toString(), style: TextStyle(
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
                              // Navigator.pop(context);
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new AddEditCallScreen(0, widget.selectedTabIndex)),).then((value) => setState(() {}));
                              // new AddEditCallScreen(0, widget.selectedTabIndex)));
                            },
                            icon: Icon(Icons.edit, size:14),
                            label: Text('Edit Call', style:TextStyle(fontSize:12, fontWeight: FontWeight.w500, color:Color(0xff303030)))),
                        FlatButton.icon(
                            onPressed: () {
                              if(activeCalls.wreckerDriver == null || activeCalls.wreckerDriver == '' || activeCalls.wreckerDriver == 0 || activeCalls.towTruck == null || activeCalls.towTruck == '' || activeCalls.towTruck == 0) {
                                _showErrorMessage(context, "Please select the Driver and Truck information on the Tow Tab");
                              }
                              else{
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return
                                        UpdateStatus(
                                            selectedCall: activeCalls,
                                            userRole: widget.userRole,
                                            dispatchPaging: widget
                                                .dispatchPaging,
                                            notifyParent: refresh
                                        );
                                    });
                              }
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
                                activeCalls.towReasonName != null && activeCalls.towReasonName != ''?
                                Text((activeCalls.towReasonName.toUpperCase()),
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color:Color(0xffB5B5B4))):Row(),]))),
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
                                        (activeCalls.towedStreet != null ? activeCalls.towedStreet.replaceAll("\\", "") :''  +
                                            ' ' +
                                            activeCalls.towedStreetTwo != null ? activeCalls.towedStreetTwo.replaceAll("\\", ""):'' +
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
                      activeCalls.towedToStreet != null && activeCalls.towedToStreet != ''?
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: (Column(
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    Text(
                                        (activeCalls.towedToStreet != null ? activeCalls.towedToStreet.replaceAll("\\", "") :''  +
                                            ' ' +
                                            activeCalls.towedToStreetTwo != null ? activeCalls.towedToStreetTwo.replaceAll("\\", "") :''  +
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
                      ):Row(),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),

                          child: (Column(
                              children: <Widget>[
                                activeCalls.dispatchInstructions_string != null && activeCalls.dispatchInstructions_string != '' && activeCalls.dispatchInstructions_string != 'null' && activeCalls.dispatchInstructions_string != '--'?
                                Text((activeCalls.dispatchInstructions_string),
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color:Color(0xff6C89BA))):Row(),]))),
                    ],
                  ))),
        ],)

        );
  }
  }



