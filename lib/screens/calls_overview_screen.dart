import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calls_provider.dart';
import 'package:vts_mobile_cloud/widgets/active_calls_list.dart';
import 'package:vts_mobile_cloud/widgets/completed_calls_list.dart';
import 'package:vts_mobile_cloud/widgets/cancelled_calls_list.dart';
import '../providers/secureStoreMixin_provider.dart';

class CallsScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CallsScreenState();
  }
}

class _CallsScreenState extends State<CallsScreen> with SecureStoreMixin{
  String userRole;
  var dispatchPaging;
  var callsData;

  getRole() async{
   await  getSecureStore('userRole', (token) {
      setState(() {
        userRole=token;
      });
    });
  }
  getDispatchPaging() async{
   await  getSecureStore('dispatchPaging', (token) {
      setState(() {
        dispatchPaging =_convertTobool(token);
      });
    });
  }
  bool _convertTobool(value) {
    if (value is String) {
      if (value.toLowerCase() == "true")
        return true;
      else
        return false;
    } else
      return value;
  }

  void initState(){
    super.initState();
    getRole();
    getDispatchPaging();
    callsData = Provider.of<Calls>(context, listen:false); //Required for the length
  }

//  @override
//  void dispose(){
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('CALLS', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
            bottom: TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.white,
//              unselectedLabelColor: Colors.blueGrey,
              tabs: [
                Tab(
                  icon: Icon(Icons.av_timer),
                  child: Text("ACTIVE" +' ' +
                      (callsData.activeCount != 0
                          ? callsData.activeCount.toString()
                          : ''
                       ),
                    style:TextStyle(fontSize:12, fontWeight: FontWeight.w600))
                ),
                Tab(
                  icon: Icon(Icons.alarm_on),
                  child: Text("COMPLETED"
                      ' ' +
                      (callsData.completedCount != 0
                          ? callsData.completedCount.toString()
                          : ''),
                      style:TextStyle(fontSize:12, fontWeight: FontWeight.w600))
                ),
                Tab(
                  icon: Icon(Icons.cancel),
                  child: Text("CANCELLED"
                      ' ' +
                      (callsData.cancelledCount != 0
                          ? callsData.cancelledCount.toString()
                          : ''),
                      style:TextStyle(fontSize:12, fontWeight: FontWeight.w600))
                ),
              ],
            ),

          ),
//          body: _isLoading
//              ? Center(
//                  child: CircularProgressIndicator(),
//                )
//              : CallsList()),
          body: TabBarView(
            children: [
              ActiveCallsList(userRole, dispatchPaging),
              CompletedCallsList(userRole, dispatchPaging),
              CancelledCallsList(userRole, dispatchPaging),
            ],
          )),
    );
  }
}