import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:vts_mobile_cloud/providers/secureStoreMixin_provider.dart';
import 'package:vts_mobile_cloud/providers/towedVehiclePictures_provider.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';
import '../providers/calls_provider.dart';
import '../providers/towedVehicleNotes_provider.dart';
import 'package:vts_mobile_cloud/widgets/notes_edit.dart';

class PhotosList extends StatefulWidget {
  PhotosList({Key key, this.userRole,this.userId, this.notifyParent});

  final String userRole;
  final String userId;
  final Function notifyParent;
  bool isLoading = false;

  @override
  _PhotosList createState() => _PhotosList();
}
class _PhotosList extends State<PhotosList> {
  static const int PAGE_SIZE = 15;
  //
  // void initState(){
  //   super.initState();
  // }


  Future<List> _refreshCallsList(BuildContext context) async {
    var selectedCall = Provider.of<Calls>(context, listen:false).selectedCall;

    return await Provider.of<TowedVehiclePicturesVM>(context, listen:false)
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
                Provider.of<TowedVehiclePicturesVM>(context, listen:false)
                    .listMini(pageIndex, PAGE_SIZE, selectedCall.id.toString())));
  }
  refresh(){
    setState(() {

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
  Future deletePicture(id, towedVehicle) async {
    setState(() {
      widget.isLoading = true;
    });

    var selectedCall = Provider.of<Calls>(context, listen: false).selectedCall;
    await Provider.of<TowedVehiclePicturesVM>(context, listen: false).delete(id, towedVehicle);
    var picturesDeleteResponse = Provider.of<TowedVehiclePicturesVM>(context, listen: false).picturesDeleteResponse;
    setState(() {

    });
    if (picturesDeleteResponse["errorStatus"] == "false") {
      widget.isLoading = false;
      _showErrorMessage(context, picturesDeleteResponse["errorMessage"]);
    }
    else {
      setState(() {
        widget.isLoading = false;
      });
    }
  }


  Widget _itemBuilder(context, towedVehiclePictures, _) {
    // towedVehicleNotes.vehicleNotes_string = towedVehicleNotes.vehicleNotes_string.replaceAll("\\r\\n", "\n");
    return Column(children: <Widget>[
      Card(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: [
                  Spacer(),

                  Visibility(
                      // visible: (widget.userRole == "3" && towedVehicleNotes.vehicleCreatedByUserId.toString() == widget.userId.toString()) || widget.userRole != "3" ? true : false,
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
                                      'DELETE PICTURE', style: TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.bold, color:Color(0xff1C3764))),
                                  content: widget.isLoading == true ? Center(child:Loader()):SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Are you sure you want to delete Picture - ' + towedVehiclePictures.vehiclePictureTypeName+
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
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        deletePicture(towedVehiclePictures.id, towedVehiclePictures.towedVehicle);

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
                          towedVehiclePictures.vehiclePictureTypeName, style: new TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0))),


                ]),
                Padding(
                    padding: EdgeInsets.only(top:10),
                    child: Row(children: [
                      Text("Created"  + ' on '+towedVehiclePictures.vehicleCreatedDate + ' at '+towedVehiclePictures.vehicleCreatedTime +"\n"),

                    ])),
                Row(children: [
                  Text("By "+towedVehiclePictures.vehicleCreatedByUserName)
                ]),
                // towedVehiclePictures.vehicleModifiedDate != null && towedVehiclePictures.vehicleModifiedDate != ''?
                // Row(children: [
                //   Text("Modified"  + ' on '+towedVehiclePictures.vehicleModifiedDate)
                // ]):Row(),
              ],
            )),
        //Divider()
      )]);
  }
}
