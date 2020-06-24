import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/processTowedVehicle_provider.dart';

class DuplicateCall extends StatefulWidget {
  DuplicateCall();

  @override
  State<StatefulWidget> createState() {
    return _DuplicateCallState();
  }
}

class _DuplicateCallState extends State<DuplicateCall> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('DUPLICATE VEHICLE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Padding(
              padding: EdgeInsets.all(0.0),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Impound',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                                .duplicateData[
                                            "storageCompanyName"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                            context, listen:false)
                                        .duplicateData["storageCompanyName"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle()),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Towed Status',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                            .duplicateData["towedStatusName"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                            context, listen:false)
                                        .duplicateData["towedStatusName"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle()),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Towed Date',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                            .duplicateData["towedDate"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                            context, listen:false)
                                        .duplicateData["towedDate"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle()),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Impound Date',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                                .duplicateData[
                                            "storageReceivedDate"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                            context, listen:false)
                                        .duplicateData["storageReceivedDate"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle()),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Released Date',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                                .duplicateData[
                                            "storageReleaseDate"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                            context, listen:false)
                                        .duplicateData["storageReleaseDate"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle()),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('VIN',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                            .duplicateData["VIN"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                            context, listen:false)
                                        .duplicateData["VIN"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Provider.of<ProcessTowedVehiclesVM>(context, listen:false).duplicateData["VINDuplicate"] == "true" ? Colors.orange : Colors.black,
                                )),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Vehicle',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                                .duplicateData[
                                            "searchYearMakeModelName"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                                context, listen:false)
                                            .duplicateData[
                                        "searchYearMakeModelName"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Provider.of<ProcessTowedVehiclesVM>(context, listen:false).duplicateData["yearMakeModelDuplicate"] == "true" ? Colors.orange : Colors.black,
                                )),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('License Plate',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                            .duplicateData["licensePlate"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                            context, listen:false)
                                        .duplicateData["licensePlate"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle()),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Company',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                                .duplicateData[
                                            "wreckerCompanyName"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                            context, listen:false)
                                        .duplicateData["wreckerCompanyName"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle()),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Invoice #',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                            .duplicateData["towedInvoice"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                            context, listen:false)
                                        .duplicateData["towedInvoice"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Provider.of<ProcessTowedVehiclesVM>(context, listen:false).duplicateData["towedInvoiceDuplicate"] == "true" ? Colors.orange : Colors.black,
                                )),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Stock #',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          Expanded(
                            child: Text(
                                Provider.of<ProcessTowedVehiclesVM>(context, listen:false)
                                            .duplicateData["stockNumber"] !=
                                        null
                                    ? Provider.of<ProcessTowedVehiclesVM>(
                                            context, listen:false)
                                        .duplicateData["stockNumber"]
                                    : ' ',
                                textAlign: TextAlign.left,
                                style: TextStyle()),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                                'A similar vehicle already exists! Do you still wish to Add?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              child: Text('CANCEL', style: TextStyle( fontWeight: FontWeight.w500)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              child: Text('ADD CALL', style: TextStyle( fontWeight: FontWeight.w500)),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )),
                ],
              )),
        ],
      ),
    ));
  }
}
