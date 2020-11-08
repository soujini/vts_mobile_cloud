import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calls_provider.dart';
import 'package:vts_mobile_cloud/widgets/active_calls_list.dart';
import 'package:vts_mobile_cloud/widgets/completed_calls_list.dart';
import 'package:vts_mobile_cloud/widgets/cancelled_calls_list.dart';
import '../providers/secureStoreMixin_provider.dart';

class CallsScreen extends StatefulWidget {
  CallsScreen();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CallsScreenState();
  }
}
//AutomaticKeepAliveClientMixin to keep tab controller alive
class _CallsScreenState extends State<CallsScreen> with SecureStoreMixin, AutomaticKeepAliveClientMixin {
  String userRole;
  var dispatchPaging;
  var callsData;
  int selectedTabIndex = 0;
  @override
  bool wantKeepAlive = true;
  var refreshMainTabController = "false";

  void initState() {
    super.initState();
    getRoleAndDispatchPagingAndSetSelectedTabIndex();
    // callsData = Provider.of<Calls>(context, listen:false); //Required for the length
  }
   @override
 void dispose(){
   super.dispose();
 }
  Future<String> getRole() async{
   await getSecureStore('userRole', (token) {
     setState(() {
       userRole = token;
     });
   });
   print(userRole);
   return userRole;
 }

  void getRoleAndDispatchPagingAndSetSelectedTabIndex() async{
     await getSecureStore('userRole', (token) {
       setState(() {
         userRole = token;
       });
     });
    await  getSecureStore('dispatchPaging', (token) {
      dispatchPaging = token;
    });
  }
  void refresh() {
   }


  @override
  Widget build(BuildContext context){
    return userRole != null ? DefaultTabController(
      length: userRole != "3" ? 2 : 1,
       initialIndex:selectedTabIndex == null ? 0 : selectedTabIndex,
      child:  Scaffold(
          appBar: AppBar(
            title: Text('CALLS', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
            bottom:
            userRole != "3" && userRole != null ?
            TabBar(
              key:UniqueKey(),
              indicatorColor: Colors.green,
              labelColor: Colors.white,
              onTap: (index) {
                  setState(() {
                  selectedTabIndex=index;
                  });
              },
              tabs: [
                Tab(
                  icon: Icon(Icons.av_timer),
                  child: refreshMainTabController == "true" ? Text("ACTIVE",
                      // ' ' +
                      // (callsData.activeCount != 0
                      //     ? callsData.activeCount.toString()
                      //     : ''
                       //),
                    style:TextStyle(fontSize:12, fontWeight: FontWeight.w600)) : Text ("ACTIVE",style:TextStyle(fontSize:12, fontWeight: FontWeight.w600))
                ) ,
                // Tab(
                //   icon: Icon(Icons.alarm_on),
                //     child: refreshMainTabController == "true" ? Text("COMPLETED",
                //         // ' ' +
                //         // (callsData.completedCount != 0
                //         //     ? callsData.completedCount.toString()
                //         //     : ''
                //         // ),
                //       style:TextStyle(fontSize:12, fontWeight: FontWeight.w600)) : Text ("COMPLETED",style:TextStyle(fontSize:12, fontWeight: FontWeight.w600))
                // ),
                Tab(
                  icon: Icon(Icons.cancel),
                    child: refreshMainTabController == "true" ? Text("CANCELLED",
                        // ' ' +
                        // (callsData.cancelledCount != 0
                        //     ? callsData.cancelledCount.toString()
                        //     : ''
                        // ),
                      style:TextStyle(fontSize:12, fontWeight: FontWeight.w600)) : Text ("CANCELLED",style:TextStyle(fontSize:12, fontWeight: FontWeight.w600))
                ),
              ],
            )
            :
            TabBar(
              key:UniqueKey(),
              indicatorColor: Colors.green,
              labelColor: Colors.white,
              onTap: (index) {
                setState(() {
                  selectedTabIndex=index;
                });
              },
              tabs: [
                Tab(
                    icon: Icon(Icons.av_timer),
                    child: refreshMainTabController == "true" ? Text("ACTIVE",
                        // ' ' +
                        // (callsData.activeCount != 0
                        //     ? callsData.activeCount.toString()
                        //     : ''
                        //),
                        style:TextStyle(fontSize:12, fontWeight: FontWeight.w600)) : Text ("ACTIVE",style:TextStyle(fontSize:12, fontWeight: FontWeight.w600))
                ) ,
                // Tab(
                //   icon: Icon(Icons.alarm_on),
                //     child: refreshMainTabController == "true" ? Text("COMPLETED",
                //         // ' ' +
                //         // (callsData.completedCount != 0
                //         //     ? callsData.completedCount.toString()
                //         //     : ''
                //         // ),
                //       style:TextStyle(fontSize:12, fontWeight: FontWeight.w600)) : Text ("COMPLETED",style:TextStyle(fontSize:12, fontWeight: FontWeight.w600))
                // ),
                // Tab(
                //     icon: Icon(Icons.cancel),
                //     child: refreshMainTabController == "true" ? Text("CANCELLED",
                //         // ' ' +
                //         // (callsData.cancelledCount != 0
                //         //     ? callsData.cancelledCount.toString()
                //         //     : ''
                //         // ),
                //         style:TextStyle(fontSize:12, fontWeight: FontWeight.w600)) : Text ("CANCELLED",style:TextStyle(fontSize:12, fontWeight: FontWeight.w600))
                // ),
              ],
            ),
          ),
          body:
          userRole != null && userRole != '' && userRole != "3" ?
          TabBarView(
            children: [
              ActiveCallsList(userRole:userRole, dispatchPaging: dispatchPaging, notifyParent:refresh, refreshMainTabController:refreshMainTabController, selectedCallsTabIndex:selectedTabIndex),
              // CompletedCallsList(userRole:userRole, dispatchPaging: dispatchPaging, notifyParent:refresh,refreshMainTabController:refreshMainTabController, selectedCallsTabIndex:selectedTabIndex),
              CancelledCallsList(userRole:userRole, dispatchPaging: dispatchPaging, notifyParent:refresh,refreshMainTabController:refreshMainTabController,  selectedCallsTabIndex:selectedTabIndex),
                ],
          ) :
          TabBarView(
            children: [
              ActiveCallsList(userRole:userRole, dispatchPaging: dispatchPaging, notifyParent:refresh, refreshMainTabController:refreshMainTabController, selectedCallsTabIndex:selectedTabIndex),
            ],
    ))) : Text("Nothing");
  }
}