
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/globals.dart' as globals;

import '../providers/calls_provider.dart';
import 'package:vts_mobile_cloud/widgets/active_calls_list.dart';
import 'package:vts_mobile_cloud/widgets/completed_calls_list.dart';
import 'package:vts_mobile_cloud/widgets/cancelled_calls_list.dart';

class CallsScreen extends StatefulWidget {
  CallsScreen({this.onPush});
  final ValueChanged<int> onPush;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CallsScreenState();
  }
}

class _CallsScreenState extends State<CallsScreen> {


  bool _isInit = false;
  bool _isLoading = false;


//  static const routeName = 'calls';

//  @override
//  void initState() {
//    _isInit = true;
//    super.initState();
//  }


//    if (_isInit) {
//      // TODO: implement didChangeDependencies
//
//      setState(() {
//        _isLoading = true;
//      });
//      Provider.of<Calls>(context).listMini('active',1,30).catchError((onError) {
//        showDialog(
//            context: context,
//            builder: ((context) => AlertDialog(
//                  title: Text("An error occured!"),
//                  content:
//                      Text("Oops something went wrong " + onError.toString()),
//                  actions: <Widget>[
//                    FlatButton(
//                      child: Text("OK"),
//                      onPressed: () {
//                      // Navigator.of(context).pop();
//                        //throw Exception("This is a test crash!");
//
//                      },
//                    )
//                  ],
//                )));
//      }).then((_) {
//        setState(() {
//          _isLoading = false;
//        });
//      });
//      Provider.of<Calls>(context).listMini('cancelled', 1, 30).then((_) {
//        setState(() {
//          _isLoading = false;
//        });
//      });
//      super.didChangeDependencies();
//    }
//    _isInit = false;
//  }

//  Future<void> _refreshCallsList(BuildContext context) async {
//    await Provider.of<Calls>(context).listMini2('active',1,30);
//  }
////  showDialogUpdateStatus(context){
////    return showDialog(
////        context: context,
////        builder: (BuildContext context) {
////          return Container(
////              width:200,
////              child: AlertDialog(
////                title: Text('trying hard to make this a widget'),
////              )
////          );
////        });
////  }

  @override
  Widget build(BuildContext context) {
    final callsData = Provider.of<Calls>(context); //Required for the length
        return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: [

                    Tab(
                      icon: Icon(Icons.av_timer),
                      text: "Active" +' ' +
                          (callsData.activeCount != 0
                              ? callsData.activeCount.toString()
                              : ''),
                    ),
                    Tab(
                      icon: Icon(Icons.alarm_on),
                      text: "Completed"
                          ' ' +
                          (callsData.completedCount != 0
                              ? callsData.completedCount.toString()
                              : ''),
                    ),
                    Tab(
                      icon: Icon(Icons.cancel),
                      text: "Cancelled"
                          ' ' +
                          (callsData.cancelledCount != 0
                              ? callsData.cancelledCount.toString()
                              : ''),
                    ),
                  ],
                ),
                title: Text('CALLS'),
              ),
//          body: _isLoading
//              ? Center(
//                  child: CircularProgressIndicator(),
//                )
//              : CallsList()),
              body: TabBarView(
                children: [
                  ActiveCallsList(),
                  CompletedCallsList(),
                  CancelledCallsList(),
                ],
              )),
        );
  }
}