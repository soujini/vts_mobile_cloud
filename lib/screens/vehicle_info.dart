import 'package:flutter/material.dart';
import '../models/call.dart';

class VehicleInfoScreen extends StatelessWidget {
  Call activeCalls = Call();

  VehicleInfoScreen(this.activeCalls);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title:
            Text('CALL DETAILS', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),

        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Text(
                          (activeCalls.vehicleYear.toString() +
                              ' ' +
                              activeCalls.vehicleYearMakeModelName),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color:Color(0xff1c3764))),
                      Text(' '),
                      Text(('(' + activeCalls.color + ')'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color:Color(0xff1c3764))),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Text((activeCalls.dispatchStatusName.toUpperCase()),
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  new Row(children: <Widget>[
                    Text((activeCalls.towedInvoice),
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ]),
                  new Divider(height: 5.0, color: Color(0xffb5b5bf)),
                  new Row(
                    children: <Widget>[
                      Text((activeCalls.towCustomerName),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color:Color(0xff1c3764))),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Container(
                          width: 120,
                          child: Text("From",
                              style: TextStyle(
                                  color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                      new Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              (activeCalls.towedStreet != null ? activeCalls.towedStreet :''  +
                                  ' ' +
                                  activeCalls.towedStreetTwo != null ? activeCalls.towedStreetTwo:''
                                 ),
                              style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(
                              (activeCalls.towedCityName != null ? activeCalls.towedCityName:'' + ' '+activeCalls.towedStateName != null ? activeCalls.towedStateName:'' +
                                  ' ' +
                                  activeCalls.towedZipCode  != null ? activeCalls.towedZipCode:''),
                              style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                        ]),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Container(
                          width: 120,
                          child: Text("To",
                              style: TextStyle(
                               color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),


                      new Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: <Widget>[
                        Text(
                            (activeCalls.towedToStreet +
                                ' ' +
                                activeCalls.towedToStreetTwo
                                ),
                            style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                        Text(
                            (activeCalls.towedToCityName + ' ' +activeCalls.towedToStateName +
                                ' ' +
                                activeCalls.towedToZipCode),
                            style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                      ],)

                    ],
                  ),
    new Divider(height: 5.0, color: Color(0xffb5b5bf)),

                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 120,
                            child: Text("Dispatcher",
                                style: TextStyle(
                                    color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                        Text(
                            (activeCalls.dispatchContact != null
                                ? activeCalls.dispatchContact
                                : '-'),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                      ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("License #",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text(
                        (activeCalls.licensePlate != null
                            ? activeCalls.licensePlate
                            : '-'),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("VIN",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text((activeCalls.VIN != null ? activeCalls.VIN : '-'),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("Driver",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text((activeCalls.wreckerDriverName),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("Truck",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text((activeCalls.towTruckName),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                  new Divider(height: 5.0, color: Color(0xffb5b5bf)),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("Received",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text((activeCalls.dispatchReceivedTime),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("Dispatch",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text((activeCalls.dispatchDispatchTime),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("Enroute",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text((activeCalls.dispatchEnrouteTime),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("Onsite",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text((activeCalls.dispatchOnsiteTime),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("Rolling",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text((activeCalls.dispatchRollingTime),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("Arrived",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text((activeCalls.dispatchArrivedTime),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 120,
                        child: Text("Cleared",
                            style: TextStyle(
                                color: Color(0xffb5b5bf), fontSize: 14, fontWeight: FontWeight.w500))),
                    Text((activeCalls.dispatchClearedTime),
    style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  ]),
    new Divider(height: 5.0, color: Color(0xffb5b5bf)),
                  new Row(children: <Widget>[
                    Text(("NOTES"),
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Flexible(
                    child: Text(activeCalls.dispatchInstructions_string != null && activeCalls.dispatchInstructions_string != 'null' ? activeCalls.dispatchInstructions_string : '--', style: TextStyle(color:Color(0xff303030), fontSize: 14, fontWeight: FontWeight.w500)),
                  )
//
                ])));

//
//      theme: new ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
//        // counter didn't reset back to zero; the application is not restarted.
//        primarySwatch: Colors.blue,
//      ),
  }
}
