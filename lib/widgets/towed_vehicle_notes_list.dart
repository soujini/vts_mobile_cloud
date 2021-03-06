import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';
import '../providers/calls_provider.dart';
import '../providers/towedVehicleNotes_provider.dart';
import 'package:vts_mobile_cloud/widgets/notes_edit.dart';

class TowedVehicleNotesList extends StatefulWidget {
  TowedVehicleNotesList({Key key, this.userRole,this.userId});

  final String userRole;
  final String userId;
  bool isLoading = false;

  @override
  _TowedVehicleNotesList createState() => _TowedVehicleNotesList();
}
class _TowedVehicleNotesList extends State<TowedVehicleNotesList> {
  static const int PAGE_SIZE = 15;
  //
  // void initState(){
  //   super.initState();
  // }


  Future<List> _refreshCallsList(BuildContext context) async {
    var selectedCall = Provider.of<Calls>(context, listen:false).selectedCall;

    return await Provider.of<TowedVehicleNotesVM>(context, listen:false)
        .listMini(0, PAGE_SIZE,selectedCall.id.toString())
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
    var selectedCall = Provider.of<Calls>(context, listen:false).selectedCall;
    return RefreshIndicator(
        onRefresh: () => _refreshCallsList(context),
        child: PagewiseListView(
            key:UniqueKey(),
            shrinkWrap: true,
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
                Provider.of<TowedVehicleNotesVM>(context, listen:false)
                    .listMini(pageIndex, PAGE_SIZE, selectedCall.id.toString())));
  }
  refresh(){
    setState(() {
      widget.isLoading = false; //dummy
    });
  }

  _showErrorMessage(BuildContext context, errorMessage) {
    Scaffold.of(context).showSnackBar(
        new SnackBar(
            backgroundColor: Colors.lightGreen,
            content: Text(errorMessage,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500
                ))));
  }
  Future deleteNote(context, id, towedVehicle) async {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
            title: Text("Deleting Note..."),
            content:
            SingleChildScrollView(
                padding: EdgeInsets.only(left:100, right:100, top:10, bottom:10),
                child: ListBody(
                    children: <Widget>[
                      Loader()
                    ])
            )
        )));

    await Provider.of<TowedVehicleNotesVM>(context, listen: false).delete(id, towedVehicle);
    var notesDeleteResponse = await Provider.of<TowedVehicleNotesVM>(context, listen: false).notesDeleteResponse;

    if (notesDeleteResponse["errorStatus"] == "false") {
      widget.isLoading = false;
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      _showErrorMessage(context, notesDeleteResponse["errorMessage"]);
    }
      else {
      // widget.notifyParent();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      setState(() {
        widget.isLoading=false;//dummy
      });
      }

    }

  Widget _itemBuilder(context, towedVehicleNotes, _) {
    towedVehicleNotes.vehicleNotes_string = towedVehicleNotes.vehicleNotes_string.replaceAll("\\r\\n", "\n");
    towedVehicleNotes.vehicleNotes_string = towedVehicleNotes.vehicleNotes_string.replaceAll("\\n", "\n");

     return Column(children: <Widget>[
      Card(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                   Row(children: <Widget>[
//                     Spacer(),
//                     Visibility(
//                         visible:widget.userRole == "3" ? false : true,
//                         child: IconButton(
//                           icon: new Icon(Icons.edit, size:20),
//                           tooltip: 'Edit',
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 new MaterialPageRoute(
//                                     builder: (context) => new NotesEdit(notifyParent:refresh)));
//                             Provider.of<TowedVehicleNotesVM>(context,listen: false).selectedNote = towedVehicleNotes;
//                           },
//                         )),
//                     Visibility(
//                       // visible:userRole != null && userRole == "3" ? false :true,
//                         visible:true,
//                         child: IconButton(
//                           icon: new Icon(Icons.delete_outline, size:20),
//                           tooltip: 'Delete',
//                           onPressed: () => {
//                             showDialog<void>(
//                                 context: context,
//                                 barrierDismissible: false,
//                                 // user must tap button!
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: Text(
//                                         'DELETE NOTE', style: TextStyle(fontSize: 16,
//                                         fontWeight: FontWeight.bold, color:Color(0xff1C3764))),
//                                     content: widget.isLoading == true ? Center(child:Loader()):SingleChildScrollView(
//                                       child: ListBody(
//                                         children: <Widget>[
//                                           Text(
//                                               'Are you sure you want to delete Note - ' + towedVehicleNotes.vehicleNotes_string+
//                                                   '?', style: TextStyle(fontSize: 14,
//                                               fontWeight: FontWeight.w400, color:Colors.black)),
//                                         ],
//                                       ),
//                                     ),
//                                     actions: <Widget>[
//                                       FlatButton(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(0.0),
//                                             side: BorderSide(color: Colors.green)
//                                         ),
//                                         color: Colors.white,
//                                         textColor: Colors.green,
//                                         child: Text('Yes'),
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                           deleteNote(towedVehicleNotes.id, towedVehicleNotes.towedVehicle);
//                                           // deleteCharge(
//                                           //     towedVehicleCharges.id, towedVehicleCharges.towCharges, towedVehicleCharges.towedVehicle);
//                                         },
//                                       ),
//                                       FlatButton(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(0.0),
//                                             side: BorderSide(color: Colors.grey)
//                                         ),
//                                         color: Colors.white,
//                                         textColor: Colors.grey,
//                                         child: Text('No'),
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                       ),
//                                     ],
//                                   );
//                                 }),
//                           },
// //                    onPressed: () {
// //                      Navigator.push(
// //                          context,
// //                          new MaterialPageRoute(
// //                              builder: (context) => new ChargesAdd()));
// //                    },
//                         )),
//                   ],),
              Row(children: [
                Spacer(),
                Visibility(
                    visible:widget.userRole == "3" ? false : true,
                    child: IconButton(
                      icon: new Icon(Icons.edit, size:20),
                      tooltip: 'Edit',
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new NotesEdit(notifyParent:refresh)));
                        Provider.of<TowedVehicleNotesVM>(context,listen: false).selectedNote = towedVehicleNotes;
                      },
                    )),
                Visibility(
                  visible: (widget.userRole == "3" && towedVehicleNotes.vehicleCreatedByUserId.toString() == widget.userId.toString()) || widget.userRole != "3" ? true : false,
                    // visible:towedVehicleNotes.vehicleCreatedByUserId != userId && widget.userRole == "3" ? false :true,
                    // visible:true,
                    child: IconButton(
                      icon: new Icon(Icons.delete_outline, size:20),
                      tooltip: 'Delete',
                      onPressed: () => {
                        showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    'DELETE NOTE', style: TextStyle(fontSize: 16,
                                    fontWeight: FontWeight.bold, color:Color(0xff1C3764))),
                                content: widget.isLoading == true ? Center(child:Loader()):SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Are you sure you want to delete Note - ' + towedVehicleNotes.vehicleNotes_string+
                                              '?', style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w400, color:Colors.black)),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                        side: BorderSide(color: Colors.green)
                                    ),
                                    color: Colors.white,
                                    textColor: Colors.green,
                                    child: Text('Yes'),
                                    onPressed: () => {
                                      // Navigator.of(context).pop();
                                      deleteNote(context, towedVehicleNotes.id, towedVehicleNotes.towedVehicle)
                                      // deleteCharge(
                                      //     towedVehicleCharges.id, towedVehicleCharges.towCharges, towedVehicleCharges.towedVehicle);
                                    },
                                  ),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                        side: BorderSide(color: Colors.grey)
                                    ),
                                    color: Colors.white,
                                    textColor: Colors.grey,
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }),
                      },
//                    onPressed: () {
//                      Navigator.push(
//                          context,
//                          new MaterialPageRoute(
//                              builder: (context) => new ChargesAdd()));
//                    },
                    )),
              ]),
                  Row(children: [

                    Flexible(
                   child:Text(
                        towedVehicleNotes.vehicleNotes_string, style: new TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0))),


                  ]),
                  Padding(
                      padding: EdgeInsets.only(top:10),
                  child: Row(children: [
                    Text("Created"  + ' on '+towedVehicleNotes.vehicleCreatedDate + ' at '+towedVehicleNotes.vehicleCreatedTime +"\n"),

                  ])),
                  Row(children: [
                    Text("By "+towedVehicleNotes.vehicleCreatedByUserName)
                  ]),
                  towedVehicleNotes.vehicleModifiedDate != null && towedVehicleNotes.vehicleModifiedDate != ''?
                  Row(children: [
                    Text("Modified"  + ' on '+towedVehicleNotes.vehicleModifiedDate)
                  ]):Row(),
                ],
              )),
      //Divider()
      )]);
  }
}
