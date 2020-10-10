import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/screens/calls_overview_screen.dart';
import '../providers/calls_provider.dart';
import 'package:vts_mobile_cloud/providers/processTowedVehicle_provider.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';

class UpdateStatus extends StatefulWidget {
  int id=0;
  String dispatchStatusName="";
  String dispatchInstructionsString="";
  String userRole;
  var dispatchPaging;
  int towType;
  bool isLoading=false;
  final Function notifyParent;
  UpdateStatus({Key key, this.id, this.dispatchStatusName, this.dispatchInstructionsString, this.userRole, this.dispatchPaging, this.towType,this.notifyParent});

  @override
  State<StatefulWidget> createState() {
    return _UpdateStatusState();
  }
}

class _UpdateStatusState extends State<UpdateStatus> {
  final _formKey = GlobalKey<FormState>();

  bool pressAttention = false;
  String selectedStatus="";

  smsDriver(BuildContext context) async{
    await Provider.of<ProcessTowedVehiclesVM>(context, listen:false).processDriverSMSMessage(widget.id);
    var response = Provider.of<ProcessTowedVehiclesVM>(context, listen:false).smsResult;
    if(response[0].errorStatus == false){
     Navigator.of(context).pop();
      showErrorSuccessDialog(context,response[0].errorMessage);
    }
    else{
      showErrorSuccessDialog(context,"SMS sent to the driver");
    }
  }
//  _showDialog(context,message) {
//    BuildContext ctx = context.findAncestorWidgetOfExactType();
//    var x = context.ancestorWidgetOfExactType(Scaffold);
//    x.showSnackBar(SnackBar(content: Text(message)));
////    Scaffold.of(ctx)
////        .showSnackBar(SnackBar(content: Text(message)));
////    Navigator.push(context,
////        new MaterialPageRoute(builder: (context) => new CallsScreen()));
//  }

  showSMSDriverDialog(){
      //Show dialog to send sms to driver
      Navigator.of(context).pop();
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('SMS DRIVER'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'Are you sure you want to SMS driver  '),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
//                    Navigator.of(context).pop();
                    smsDriver(context);

                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.push(context,
                    //     new MaterialPageRoute(builder: (context) => new CallsScreen()));
                  },
                ),
              ],
            );
          });
  }

  showMoveToTowOrImpoundDialog() async{
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Clear Ticket'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      "Are you sure you want to move this ticket to Tow or Impound?"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Tow'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setStatus("tow",true);
                },
              ),
              FlatButton(
                child: Text('Impound'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setStatus("impound",true);
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showErrorSuccessDialog(context, message){
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('MESSAGE'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      message),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.notifyParent();
                  // Navigator.push(context,
                  //     new MaterialPageRoute(builder: (context) => new CallsScreen()));
                },
              ),
            ],
          );
        });
  }

  checkStatus(){
//    Navigator.pop(context); //closes update status

    if(selectedStatus.toUpperCase() == 'CLEARED') {
      showMoveToTowOrImpoundDialog();
    }
    else{
      setStatus( "",false);
    }
  }

  setStatus(String mode, bool moveStatus){
    setState(() =>widget.isLoading=true);
       Provider.of<Calls>(context, listen: false)
           .update(
           widget.id, selectedStatus, widget.dispatchInstructionsString != "null" || widget.dispatchInstructionsString != null ? widget.dispatchInstructionsString : '' , mode, moveStatus,widget.towType)
           .then((res) {
         setState(() =>widget.isLoading=false);
         if(selectedStatus == 'Dispatch' && widget.dispatchPaging == true) {
           showSMSDriverDialog();
         }
         else{
           Navigator.pop(context);
           widget.notifyParent();
           // Navigator.push(context,
           //     new MaterialPageRoute(builder: (context) => new CallsScreen()));
         }
       });
  }

@override
  Widget build(BuildContext context) {
     return AlertDialog(
        content: widget.isLoading == false ?
     Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    'UPDATE STATUS', style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold, color:Color(0xff1C3764))),
              ),
//              Padding(
//                  padding: EdgeInsets.all(8.0),
//                  child: SizedBox(
//                      width: 125,
//                      height: 40,
//                      child: FlatButton(
//                          color:  selectedStatus == "Accept" ? Color(0xff12406F): Colors.white,
//                          textColor: getCurrentStatusColor("Accept"),
//                          shape: new RoundedRectangleBorder(
//                              borderRadius: new BorderRadius.circular(
//                                  10.0), side: BorderSide(color: Color(0xff333333))),
//                          disabledTextColor: Colors.black,
//                          padding: EdgeInsets.all(8.0),
//                          splashColor: Colors.blueAccent,
//                          onPressed: () {
//                            setState(() =>
//                            selectedStatus="Accept");
//                          },
//                          child: Text('ACCEPT')))
//              ),
            Visibility(
              visible:widget.dispatchStatusName == "Dispatch" || widget.dispatchStatusName == "Received" || widget.dispatchStatusName == "Enroute" ? true : false,
              child:Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selectedStatus == "Dispatch" ? Color(0xff12406F): Colors.white,
                          textColor:getCurrentStatusColor("Dispatch"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            if(widget.dispatchStatusName != "Dispatch"){
                              setState(() =>selectedStatus="Dispatch");
                            }
                            else{
                              return null;
                            }
                          },
                          child: Text('DISPATCH')))
              )),
            Visibility(
                visible:widget.dispatchStatusName == "Enroute" || widget.dispatchStatusName == "Dispatch" || widget.dispatchStatusName == "Onsite" ? true : false,
              child:Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selectedStatus == "Enroute" ? Color(0xff12406F): Colors.white,
                          textColor:getCurrentStatusColor("Enroute"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            if(widget.dispatchStatusName != "Enroute") {
                              setState(() => selectedStatus = "Enroute");
                            }
                            else{
                              return null;
                            }

                          },
                          child: Text('ENROUTE')))
              )),
            Visibility(
              visible:widget.dispatchStatusName == "Onsite" || widget.dispatchStatusName == "Enroute" || widget.dispatchStatusName == "Rolling" ? true : false,
              child:Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selectedStatus == "Onsite" ? Color(0xff12406F): Colors.white,
                          textColor: getCurrentStatusColor("Onsite"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,

                          onPressed: () {
                            if(widget.dispatchStatusName != "Onsite") {
                              setState(() => selectedStatus = "Onsite");
                            }
                            else{
                              return null;
                            }

                          },
                          child: Text('ONSITE')))
              )),
            Visibility(
              visible:widget.dispatchStatusName == "Rolling" || widget.dispatchStatusName == "Onsite" || widget.dispatchStatusName == "Arrived" ? true : false,
              child:Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selectedStatus == "Rolling" ? Color(0xff12406F): Colors.white,
                          textColor: getCurrentStatusColor("Rolling"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            if(widget.dispatchStatusName != "Rolling") {
                              setState(() => selectedStatus = "Rolling");
                            }
                            else{
                              return null;
                            }
                          },
                          child: Text('ROLLING')))
              )),
            Visibility(
                visible:widget.dispatchStatusName == "Arrived" || widget.dispatchStatusName == "Rolling" || widget.dispatchStatusName == "Cleared" ? true : false,
              child:Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selectedStatus == "Arrived" ? Color(0xff12406F): Colors.white,
                          textColor: getCurrentStatusColor("Arrived"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            if(widget.dispatchStatusName != "Arrived") {
                              setState(() => selectedStatus = "Arrived");
                            }
                            else{
                              return null;
                            }

                          },
                          child: Text('ARRIVED')))
              )),
            Visibility(
                visible:widget.dispatchStatusName == "Cleared" || widget.dispatchStatusName == "Arrived" && widget.userRole != "3" ? true : false,
              child:Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 125,
                      height: 40,
                      child: FlatButton(
                          color: selectedStatus == "Cleared" ? Color(0xff12406F): Colors.white,
                          textColor: getCurrentStatusColor("Cleared"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  10.0), side: BorderSide(color: Color(0xff333333))),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,

                          onPressed: () {
                          if(widget.dispatchStatusName != "Cleared") {
                            setState(() => selectedStatus = "Cleared");
                          }
                          else{
                            return null;
                          }
                          },
                          child: Text('CLEARED')))
              )),
            Visibility(
                visible:true,
              child:Padding(
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
//                                  color: Color(0xff6ACA25),
                                  color:  widget.dispatchStatusName == "Arrived" && widget.userRole == "3" ? Colors.grey : Color(0xff1C3764),
                                  textColor: Colors.white,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius
                                          .circular(10.0)),
                                  disabledTextColor: Colors.black,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors.blueAccent,
                                  onPressed: () => widget.dispatchStatusName == "Arrived" && widget.userRole == "3" ? '' : checkStatus(),
                                  child: Align(
                                      alignment: Alignment
                                          .center,
                                      child: Text( widget.dispatchStatusName == "Arrived" && widget.userRole == "3" ? 'SET TO ARRIVED' : 'SET TO \n'+ selectedStatus.toUpperCase(),
                                          textAlign: TextAlign.center)
                                  )
                              )
                          ))
                    ],

                  )
              ))
            ],
          ),
        ):
        // CircularProgressIndicator(
        //         backgroundColor: Colors.green )
       Loader()
     );
  }
getCurrentStatusColor(String currentStatus) {
  if (widget.dispatchStatusName == currentStatus)
    {
    return Colors.green;
    }

  else{
    return Colors.grey;
  }
}
}