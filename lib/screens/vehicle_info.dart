import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/call.dart';

class VehicleInfoScreen extends StatelessWidget {
  Call activeCalls = Call();

  VehicleInfoScreen(this.activeCalls);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('Call Details'),
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
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(' '),
                      Text(('(' + activeCalls.color + ')'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
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
                  new Divider(height: 5.0, color: Colors.black38),
                  new Row(
                    children: <Widget>[
                      Text((activeCalls.towCustomerName),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Container(
                          width: 80,
                          child: Text("From",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14))),
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
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Container(
                          width: 80,
                          child: Text("To",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14))),
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
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                    ],
                  ),
                  new Divider(height: 5.0, color: Colors.black38),

                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 80,
                            child: Text("Dispatcher",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14))),
                        Text(
                            (activeCalls.dispatchContact != null
                                ? activeCalls.dispatchContact
                                : '-'),
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                      ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("License #",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text(
                        (activeCalls.licensePlate != null
                            ? activeCalls.licensePlate
                            : '-'),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("VIN",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text((activeCalls.VIN != null ? activeCalls.VIN : '-'),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("Driver",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text((activeCalls.wreckerDriverName),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("Truck",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text((activeCalls.towTruckName),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Divider(height: 5.0, color: Colors.black38),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("Received",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text((activeCalls.dispatchReceivedTime),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("Dispatch",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text((activeCalls.dispatchDispatchTime),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("Enroute",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text((activeCalls.dispatchEnrouteTime),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("Onsite",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text((activeCalls.dispatchOnsiteTime),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("Rolling",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text((activeCalls.dispatchRollingTime),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("Arrived",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text((activeCalls.dispatchArrivedTime),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Row(children: <Widget>[
                    Container(
                        width: 80,
                        child: Text("Cleared",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14))),
                    Text((activeCalls.dispatchClearedTime),
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ]),
                  new Divider(height: 5.0, color: Colors.black38),
                  new Row(children: <Widget>[
                    Text(("NOTES"),
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Flexible(
                    child: Text(activeCalls.dispatchInstructions_string),
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
