import 'package:flutter/material.dart';
import 'package:custom_navigator/custom_navigator.dart';

import 'package:vts_mobile_cloud/screens/calls_overview_screen.dart';
import 'package:vts_mobile_cloud/screens/search_call_screen.dart';
import 'package:vts_mobile_cloud/screens/info.dart';
import 'package:vts_mobile_cloud/screens/add_call_screen.dart';
import '../providers/secureStoreMixin_provider.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SecureStoreMixin {
  int _currentIndex = 0;
  String userRole;
  CallsScreen _callsScreen = CallsScreen();
  SearchCallScreen _searchCallScreen = SearchCallScreen();
  AddCallScreen _addCallScreen = AddCallScreen();
  InfoScreen _infoScreen = InfoScreen();


  // Custom navigator takes a global key if you want to access the
  // navigator from outside it's widget tree subtree
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState(){
    super.initState();
    getRole();
    // AddCallScreen _addCallScreen = AddCallScreen(currentIndex: _currentIndex, notifyParent: refreshToCalls);
    // this._currentIndex=widget.index;
  }

  refreshToCalls(){
    setState(() {
      _currentIndex=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
//        backgroundColor: Colors.red,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blueGrey,

        items: userRole != null && userRole == "3" ? _itemsDriver:_itemsDriverManager,
        onTap: (index) {
          // here we used the navigator key to pop the stack to get back to our
          // main page
          navigatorKey.currentState.maybePop();
          //  setState(() => //_page = Page('Page $index'));
          setState(() {
            if(index == 0){
              _callsScreen = CallsScreen();
            }
            if(index == 1)
            {
              _searchCallScreen = SearchCallScreen();
            }
            else if(index == 2){
              _addCallScreen = AddCallScreen(currentIndex: _currentIndex, notifyParent: refreshToCalls);
            }
            else if(index == 3){
              _infoScreen = InfoScreen();
            }
            // setState(() {
              _currentIndex = index;
            // });
          });
        },

        currentIndex: _currentIndex,
      ),
      body: new CustomNavigator(
        navigatorKey: navigatorKey,
        home: getScreen(),
        //Specify your page route [PageRoutes.materialPageRoute] or [PageRoutes.cupertinoPageRoute]
        pageRoute: PageRoutes.materialPageRoute,
      ),
    );
  }

  getRole() async{
   await  getSecureStore('userRole', (token) {
      setState(() {
        userRole=token;
      });
    });
  }
  getScreen() {
//    if(_currentIndex == -1){
//      return LoginPage(),
//    }
    if (userRole != null && userRole == "3") {
      if (_currentIndex == 0) {
        return _callsScreen;
      }
      else if (_currentIndex == 1) {
        return _searchCallScreen;
      }
      else if (_currentIndex == 2) {
        return _infoScreen;
      }
    }
    else {
      if (userRole != null && userRole != "3") {}
      if(_currentIndex == 0){
      return _callsScreen;
    }
    else if(_currentIndex == 1){
      return _searchCallScreen;
    }
    else if (_currentIndex == 2)
    {
      return _addCallScreen;
    }
    else if (_currentIndex == 3)
    {
      return _infoScreen;
    }
  }
  }

  final _itemsDriver = [
    BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'CALLS'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
    BottomNavigationBarItem(icon: Icon(Icons.info), label: 'ABOUT'),
  ];
  final _itemsDriverManager = [
    BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'CALLS'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ADD'),
    BottomNavigationBarItem(icon: Icon(Icons.info), label:"ABOUT" ),
  ];
}
