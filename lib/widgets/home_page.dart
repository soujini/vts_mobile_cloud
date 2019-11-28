import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_navigator/custom_navigator.dart';

import 'package:vts_mobile_cloud/screens/calls_overview_screen.dart';
import 'package:vts_mobile_cloud/screens/search_call_screen.dart';
import 'package:vts_mobile_cloud/screens/info.dart';
import 'package:vts_mobile_cloud/screens/add_call_screen.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  LoginPage _loginScreen = LoginPage();
  CallsScreen _callsScreen = CallsScreen();
  SearchCallScreen _searchCallScreen = SearchCallScreen();
  AddCallScreen _addCallScreen = AddCallScreen();
  InfoScreen _infoScreen = InfoScreen();
//  Page _page = Page('Page 0');
  int _currentIndex = 0;

  // Custom navigator takes a global key if you want to access the
  // navigator from outside it's widget tree subtree
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blueGrey,

        items: _items,
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
              _addCallScreen = AddCallScreen();
            }
            else if(index == 3){
              _infoScreen = InfoScreen();
            }
            _currentIndex = index;
          });

        },
        currentIndex: _currentIndex,
      ),
      body: CustomNavigator(
        navigatorKey: navigatorKey,
        home: getScreen(),
        //Specify your page route [PageRoutes.materialPageRoute] or [PageRoutes.cupertinoPageRoute]
        pageRoute: PageRoutes.materialPageRoute,
      ),
    );
  }


  getScreen(){
//    if(_currentIndex == -1){
//      return LoginPage(),
//    }
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

  final _items = [
    BottomNavigationBarItem(icon: Icon(Icons.call), title: Text('CALLS')),
    BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('SEARCH')),
    BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('ADD')),
    BottomNavigationBarItem(icon: Icon(Icons.info), title: Text('ABOUT')),
  ];
}
