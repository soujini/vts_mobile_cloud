import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';
import '../providers/calls_provider.dart';
import '../providers/towedVehicleNotes_provider.dart';


class TowedVehicleNotesList extends StatelessWidget {
  static const int PAGE_SIZE = 15;
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

  Widget _itemBuilder(context, towedVehicleNotes, _) {
//    return GestureDetector(
//        onTap: () {},
     return Column(children: <Widget>[
      Card(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(children: [

                   Text(
                        towedVehicleNotes.vehicleNotes_string,  overflow: TextOverflow.clip, style: new TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0)),
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
