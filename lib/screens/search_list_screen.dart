
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calls_provider.dart';

import '../widgets/search_calls_list.dart';
class SearchListScreen extends StatelessWidget {
  SearchListScreen(this.filterFields, this.userRole, this.dispatchPaging);
  String userRole;
  String filterFields="";
  var dispatchPaging;

//  static const routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('SEARCH LIST', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),

        ),
            body:SearchCallsList(this.filterFields, this.userRole, this.dispatchPaging),

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

    );
  }
}