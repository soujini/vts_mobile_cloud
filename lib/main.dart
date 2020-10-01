import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/providers/common_provider.dart';
import 'package:vts_mobile_cloud/providers/licenseType_provider.dart';
import 'package:vts_mobile_cloud/providers/notes_provider.dart';
import 'package:vts_mobile_cloud/providers/processTowedVehicle_provider.dart';
import 'package:vts_mobile_cloud/providers/relationTowCharges_provider.dart';
import 'package:vts_mobile_cloud/providers/storage_company_provider.dart';
import 'package:vts_mobile_cloud/providers/systemPriority_provider.dart';
import 'package:vts_mobile_cloud/providers/vehicleYearMakeModel_provider.dart';

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
import 'package:vts_mobile_cloud/providers/towedVehiclePictures_provider.dart';

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

//getCurrentDateAndTime(){
//  final dateAndTime = DateAndTime();
//  dateAndTime.getCurrentDateAndTime();
//}
class _MyAppState extends State<MyApp>{

  getCurrentDateAndTime(){
    final dateAndTime = DateAndTime();
    dateAndTime.getCurrentDateAndTime();
  }


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
//  Map<int, Color> color =
//  {
//    50:Color(0xff185695),
//    100:Color(0xff185695),
//    200:Color(0xff185695),
//    300:Color(0xff185695),
//    400:Color(0xff185695),
//    500:Color(0xff185695),
//    600:Color(0xff185695),
//    700:Color(0xff185695),
//    800:Color(0xff185695),
//    900:Color(0xff185695),
//  };
  Map<int, Color> color =
  {
    50:Color(0xff1C3764),
    100:Color(0xff1C3764),
    200:Color(0xff1C3764),
    300:Color(0xff1C3764),
    400:Color(0xff1C3764),
    500:Color(0xff1C3764),
    600:Color(0xff1C3764),
    700:Color(0xff1C3764),
    800:Color(0xff1C3764),
    900:Color(0xff1C3764),
  };


  @override
  Widget build(BuildContext context) {
    getCurrentDateAndTime();
    MaterialColor colorCustom = MaterialColor(0xff1C3764, color);
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_)=>UsersVM()),
        ChangeNotifierProvider(create: (_)=>Calls()),
        ChangeNotifierProvider(create: (_)=>TowAuthorizationsVM()),
        ChangeNotifierProvider(create: (_)=>TowCustomersVM()),
        ChangeNotifierProvider(create: (_)=>TowJurisdictionsVM()),
        ChangeNotifierProvider(create: (_)=>TowTrucksVM()),
        ChangeNotifierProvider(create: (_)=>TowTypesVM()),
        ChangeNotifierProvider(create: (_)=>WreckerCompaniesVM()),
        ChangeNotifierProvider(create: (_)=>WreckerDriversVM()),
        ChangeNotifierProvider(create: (_)=>SystemCitiesVM()),
        ChangeNotifierProvider(create: (_)=>SystemStatesVM()),
        ChangeNotifierProvider(create: (_)=>TowReasonsVM()),
        ChangeNotifierProvider(create: (_)=>VehicleColorsVM()),
        ChangeNotifierProvider(create: (_)=>VehicleYearMakeModelsVM()),
        ChangeNotifierProvider(create: (_)=>VehicleMakesVM()),
        ChangeNotifierProvider(create: (_)=>VehicleStylesVM()),
        ChangeNotifierProvider(create: (_)=>ProcessTowedVehiclesVM()),
        ChangeNotifierProvider(create: (_)=>LicenseTypesVM()),
        ChangeNotifierProvider(create: (_)=>SystemPrioritiesVM()),
        ChangeNotifierProvider(create: (_)=>TowedVehicleNotesVM()),
        ChangeNotifierProvider(create: (_)=>TowedVehicleChargesVM()),
        ChangeNotifierProvider(create: (_)=>TowChargesVM()),
        ChangeNotifierProvider(create: (_)=>NotesVM()),
        ChangeNotifierProvider(create: (_)=>TowedVehiclePicturesVM()),
        ChangeNotifierProvider(create: (_)=>StorageCompaniesVM())
      ],

 //   return //Provides instance of type Calls
    child: MaterialApp(
      navigatorKey: mainNavigatorKey,
      title: 'VTS CLOUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: colorCustom,
          bottomAppBarColor: colorCustom,
          fontFamily: 'Montserrat',
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
