import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/providers/licenseType_provider.dart';
import 'package:vts_mobile_cloud/providers/processTowedVehicle_provider.dart';
import 'package:vts_mobile_cloud/providers/relationTowCharges_provider.dart';
import 'package:vts_mobile_cloud/providers/systemPriority_provider.dart';
import 'package:vts_mobile_cloud/providers/vehicleYearMakeModel_provider.dart';

import 'package:vts_mobile_cloud/widgets/loader.dart';
import 'package:vts_mobile_cloud/widgets/home_page.dart';
import 'package:vts_mobile_cloud/providers/calls_provider.dart';
import 'package:vts_mobile_cloud/providers/relationTowAuthorization_provider.dart';
import 'package:vts_mobile_cloud/providers/relationTowCustomer_provider.dart';
import 'package:vts_mobile_cloud/providers/relationTowJurisdiction_provider.dart';
import 'package:vts_mobile_cloud/providers/relationTowTruck_provider.dart';
import 'package:vts_mobile_cloud/providers/relationTowType_provider.dart';
import 'package:vts_mobile_cloud/providers/relationWreckerCompany_provider.dart';
import 'package:vts_mobile_cloud/providers/relationWreckerDriver_provider.dart';
import 'package:vts_mobile_cloud/providers/systemState_provider.dart';
import 'package:vts_mobile_cloud/providers/systemCity_provider.dart';
import 'package:vts_mobile_cloud/providers/towReason_provider.dart';
import 'package:vts_mobile_cloud/providers/user_provider.dart';
import 'package:vts_mobile_cloud/providers/vehicleColor_provider.dart';
import 'package:vts_mobile_cloud/providers/vehicleMake_provider.dart';
import 'package:vts_mobile_cloud/providers/vehicleStyle_provider.dart';
import 'package:vts_mobile_cloud/providers/towedVehicleNotes_provider.dart';
import 'package:vts_mobile_cloud/providers/towedVehicleCharges_provider.dart';

import './screens/login_screen.dart';

void main() => runApp(MyApp());

//give a navigator key to [MaterialApp] if you want to use the default navigation
//anywhere in your app eg: line 15 & line 93
GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();
var pageMode ="login";

class MyApp extends StatefulWidget {
  MyApp() : super();

  @override
  _MyAppState createState() => _MyAppState();
  // This widget is the root of your application.
}
class _MyAppState extends State<MyApp>{

//  Map<int, Color> color =
//  {
//    50:Color.fromRGBO(136,14,79, .1),
//    100:Color.fromRGBO(136,14,79, .2),
//    200:Color.fromRGBO(136,14,79, .3),
//    300:Color.fromRGBO(136,14,79, .4),
//    400:Color.fromRGBO(136,14,79, .5),
//    500:Color.fromRGBO(136,14,79, .6),
//    600:Color.fromRGBO(136,14,79, .7),
//    700:Color.fromRGBO(136,14,79, .8),
//    800:Color.fromRGBO(136,14,79, .9),
//    900:Color.fromRGBO(136,14,79, 1),
//  };
  Map<int, Color> color =
  {
    50:Color(0xff185695),
    100:Color(0xff185695),
    200:Color(0xff185695),
    300:Color(0xff185695),
    400:Color(0xff185695),
    500:Color(0xff185695),
    600:Color(0xff185695),
    700:Color(0xff185695),
    800:Color(0xff185695),
    900:Color(0xff185695),
  };


  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xff185695, color);
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(builder: (_)=>UsersVM()),
        ChangeNotifierProvider(builder: (_)=>Calls()),
        ChangeNotifierProvider(builder: (_)=>TowAuthorizationsVM()),
        ChangeNotifierProvider(builder: (_)=>TowCustomersVM()),
        ChangeNotifierProvider(builder: (_)=>TowJurisdictionsVM()),
        ChangeNotifierProvider(builder: (_)=>TowTrucksVM()),
        ChangeNotifierProvider(builder: (_)=>TowTypesVM()),
        ChangeNotifierProvider(builder: (_)=>WreckerCompaniesVM()),
        ChangeNotifierProvider(builder: (_)=>WreckerDriversVM()),
        ChangeNotifierProvider(builder: (_)=>SystemCitiesVM()),
        ChangeNotifierProvider(builder: (_)=>SystemStatesVM()),
        ChangeNotifierProvider(builder: (_)=>TowReasonsVM()),
        ChangeNotifierProvider(builder: (_)=>VehicleColorsVM()),
        ChangeNotifierProvider(builder: (_)=>VehicleYearMakeModelsVM()),
        ChangeNotifierProvider(builder: (_)=>VehicleMakesVM()),
        ChangeNotifierProvider(builder: (_)=>VehicleStylesVM()),
        ChangeNotifierProvider(builder: (_)=>ProcessTowedVehiclesVM()),
        ChangeNotifierProvider(builder: (_)=>LicenseTypesVM()),
        ChangeNotifierProvider(builder: (_)=>SystemPrioritiesVM()),
        ChangeNotifierProvider(builder: (_)=>TowedVehicleNotesVM()),
        ChangeNotifierProvider(builder: (_)=>TowedVehicleChargesVM()),
        ChangeNotifierProvider(builder: (_)=>TowChargesVM()),

      ],

 //   return //Provides instance of type Calls
    child: MaterialApp(
      navigatorKey: mainNavigatorKey,
      title: 'VTS CLOUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: colorCustom,
          bottomAppBarColor: colorCustom
      ),
      home: (pageMode == "login") ? LoginPage(setScreen: setScreen) : MyHomePage(title: "Fluttter App"),

    ));
  }

  setScreen(String mode) {
    setState(() {
      pageMode=mode;
    });

  }
}


