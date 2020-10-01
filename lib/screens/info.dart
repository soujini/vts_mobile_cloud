
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../providers/secureStoreMixin_provider.dart';
import 'package:get_version/get_version.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen() : super();
//  method()=>createState().save2();

  @override
  InfoScreenState createState() => InfoScreenState();
}


class InfoScreenState extends State<InfoScreen> with SecureStoreMixin {
  var userId = "";
  var userName = "";
  var userRoleName = "";

  String _platformVersion = 'Unknown';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  @override
  void initState() {
    // TODO: implement initState
    getAboutInformation();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get build number.';
    }

    String projectAppID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectAppID = await GetVersion.appID;
    } on PlatformException {
      projectAppID = 'Failed to get app ID.';
    }

    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectName = await GetVersion.appName;
    } on PlatformException {
      projectName = 'Failed to get app name.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });
  }

  getAboutInformation() async{
      await  getSecureStore('userId', (token) {
        setState(() {
          userId=token;
        });

      });
      await  getSecureStore('userName', (token) {
        setState(() {
          userName = token;
        });
      });
        await  getSecureStore('userRoleName', (token)
      {
        setState(() {
          userRoleName = token;
        });
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ABOUT', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
      ),
        body: Builder(
            builder: (context) => Center(
              child: new Column(
                children: <Widget>[
                  Padding(
                    // padding: new EdgeInsets.symmetric(vertical: 50.0),
                      padding: new EdgeInsets.only(top:30, bottom: 10),
                      child: SizedBox(
                        height: 100.0,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      )),
                        Padding(
                      padding: new EdgeInsets.only(top:10),
                      child:Text("Copyright 2020 VTS Systems")
                  ),
                  Padding(
                      padding: new EdgeInsets.only(top:20),
                      child: Text("End User License Agreement",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                      padding: new EdgeInsets.only(top:40),
                      child:Text("CONTACT",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))
                  ),
                  Padding(
                      padding: new EdgeInsets.only(top:20),
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,,
                          children: <Widget>[
                          Text("Phone : "),
                          Text("(877)-374-7225",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500))
                        ],
                      )
                  ),
                  Padding(
                      padding: new EdgeInsets.only(top:10),
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,,
                          children: <Widget>[
                            Text("Email : "),
                            Text("support@vts-cloud.com",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500))
                      ])
                  ),
                  Padding(
                      padding: new EdgeInsets.only(top:50),
                      child:Text("APPLICATION INFORMATION", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))
                  ),
                  Padding(
                      padding: new EdgeInsets.only(top:20),
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,,
                          children: <Widget>[
                      Text(_projectName),
                      ])
                  ),
                  Padding(
                      padding: new EdgeInsets.only(top:10),
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,,
                          children: <Widget>[

                            Text(_platformVersion),
                            Text(" : "),
                            Text("Version ",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                      Text(_projectVersion, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                            Text(" (Build ",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                            Text(_projectCode,  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                            Text(")",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),

                      ])
                  ),
                  Padding(
                      padding: new EdgeInsets.only(top:50),
                      child:Text("USER INFORMATION", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))
                  ),
            Padding(
                padding: new EdgeInsets.only(top:20),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,,
                    children: <Widget>[
                      Text("Username : "),
                      Text(userName != null ? userName : '', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500))
                    ])
            ),
                  Padding(
                      padding: new EdgeInsets.only(top:10),
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,,
                          children: <Widget>[
                            Text("User Id : "),
                             Text(userId != null ? userId : '', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500))
                      ])
                  ),
                  Padding(
                      padding: new EdgeInsets.only(top:10),
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,,
                          children: <Widget>[
                            Text("Role : "),
                            Text(userRoleName != null ? userRoleName : '', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500))
                          ])
                  ),
                ],
              )
            )
        )

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