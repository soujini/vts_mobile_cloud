import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calls_provider.dart';


class UpdateStatus extends StatefulWidget {
  int id=0;
  String dispatchStatusName="";
  String dispatchInstructions_string="";
  UpdateStatus(this.id, this.dispatchStatusName, this.dispatchInstructions_string);

  @override
  State<StatefulWidget> createState() {
    return _UpdateStatusState();
  }
}

class _UpdateStatusState extends State<UpdateStatus> {
  final _formKey = GlobalKey<FormState>();
  bool pressAttention = false;
  String selected_status="";


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
                child: Text(
                    'UPDATE STATUS', style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold)),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color:  selected_status == "Accept" ? Color(0xff12406F): Colors.white,
                          textColor: getCurrentStatusColor("Accept"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            setState(() =>
                            selected_status="Accept");
                          },
                          child: Text('ACCEPT')))
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selected_status == "Enroute" ? Color(0xff12406F): Colors.white,
                          textColor:getCurrentStatusColor("Enroute"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            setState(() =>
                            selected_status="Enroute");
                          },
                          child: Text('ENROUTE')))
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selected_status == "Onsite" ? Color(0xff12406F): Colors.white,
                          textColor: getCurrentStatusColor("Onsite"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,

                          onPressed: () {
                            setState(() =>
                            selected_status="Onsite");
                          },
                          child: Text('ONSITE')))
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selected_status == "Rolling" ? Color(0xff12406F): Colors.white,
                          textColor: getCurrentStatusColor("Rolling"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            setState(() =>
                            selected_status="Rolling");
                          },
                          child: Text('ROLLING')))
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selected_status == "Arrived" ? Color(0xff12406F): Colors.white,
                          textColor: getCurrentStatusColor("Arrived"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            setState(() =>
                            selected_status="Arrived");
                          },
                          child: Text('ARRIVED')))
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selected_status == "Cleared" ? Color(0xff12406F): Colors.white,
                          textColor: getCurrentStatusColor("Cleared"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,

                          onPressed: () {
                            setState(() =>
                            selected_status="Cleared");
                          },
                          child: Text('CLEARED')))
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(

                              width: 100,
                              height: 50,
                              child: FlatButton(
                                  color: Colors.white,
                                  textColor: Color(0xff6ACA25),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(
                                          10.0), side: BorderSide(color: Color(0xff6ACA25))),
                                  disabledTextColor: Colors.black,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors
                                      .lightGreenAccent,
                                  onPressed: ()=>Navigator.pop(context),
                                  child: Text('CANCEL')))
                      ),
                      Padding(
                          padding: EdgeInsets.all(1.0),
                          child: SizedBox(
                              width: 100,
                              height: 50,
                              child: FlatButton(
                                  color: Color(0xff6ACA25),
                                  textColor: Colors.white,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius
                                          .circular(10.0)),
                                  disabledTextColor: Colors.black,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors
                                      .lightGreenAccent,
                                  onPressed: () {
                                    Provider.of<Calls>(context)
                                        .update(widget.id,selected_status,widget.dispatchInstructions_string);
                                    Navigator.pop(context);
                                  },
                                  child: Align(
                                      alignment: Alignment
                                          .center,
                                      child: Text('SET TO \n'+ selected_status.toLowerCase(),
                                          textAlign: TextAlign.center)
                                  )
                              )
                          ))
                    ],

                  )
              )
            ],
          ),
        ));
  }
getCurrentStatusColor(String currentStatus) {
  if (widget.dispatchStatusName == currentStatus)
    {
    return Colors.green;
    }

  else{
    return Colors.black38;
  }
//  selected_status == "Accept" ? Color(0xff12406F): Colors.white,
}
}