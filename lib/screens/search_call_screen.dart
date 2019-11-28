import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vts_mobile_cloud/screens/search_list_screen.dart';

import '../widgets/search_calls_list.dart';

class SearchCallScreen extends StatefulWidget {
  @override
  createState() {
    return SearchCallScreenState();
  }
}

class SearchCallScreenState extends State<SearchCallScreen> {
  List<RadioModel> searchOption = new List<RadioModel>();
  List<RadioModel> searchOptionType = new List<RadioModel>();
  String filterFields="";

  String searchOptionField="";
  String dispatchStatus="";
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchOption.add(new RadioModel(false, 'Call Date', ''));
    searchOption.add(new RadioModel(false, 'License Plate', ''));
    searchOption.add(new RadioModel(false, 'PO#', ''));
    searchOption.add(new RadioModel(false, 'Invoice', ''));

    searchOptionType.add(new RadioModel(false, 'All', ''));
    searchOptionType.add(new RadioModel(false, 'Received', ''));
    searchOptionType.add(new RadioModel(false, 'Dispatch', ''));
    searchOptionType.add(new RadioModel(false, 'Enroute', ''));
    searchOptionType.add(new RadioModel(false, 'Onsite', ''));
    searchOptionType.add(new RadioModel(false, 'Rolling', ''));
    searchOptionType.add(new RadioModel(false, 'Arrived', ''));
    searchOptionType.add(new RadioModel(false, 'Cleared', ''));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "asdasd",
        home: Scaffold(
            appBar: AppBar(
              title: Text("Search Call"),
            ),
            body: SingleChildScrollView(
              child: Column(children: <Widget>[
                SizedBox(
                  height: 175,
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 3,
                    childAspectRatio: 2.0,
                    padding: const EdgeInsets.all(5.0),
//                mainAxisSpacing: 1.0,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(searchOption.length, (index) {
                      return Center(
                          child: new InkWell(
                        //highlightColor: Colors.red,
                        splashColor: Colors.blueAccent,
                        onTap: () {
                          if(index == 0){
                            searchOptionField="dispatchDate:";
                          }
                          else if(index == 1){
                            searchOptionField="licensePlate:";
                          }
                          else if(index == 2){
                            searchOptionField="towedPONumber:";
                          }
                          else if(index == 3){
                            searchOptionField="towedInvoice:";
                          }
                          setState(() {
                            searchOption.forEach(
                                (element) => element.isSelected = false);
                            searchOption[index].isSelected = true;
                          });
                        },
                        child: new RadioItem(searchOption[index]),
                      ));
                    }),
                  ),
                ),
                SizedBox(
                  height: 225.0,
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 3,
                    childAspectRatio: 2.0,
                    padding: const EdgeInsets.all(5.0),
//                mainAxisSpacing: 1.0,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(searchOptionType.length, (index) {
                      return Center(
                          child: new InkWell(
                        //highlightColor: Colors.red,
                        splashColor: Colors.blueAccent,
                        onTap: () {

                          if(index == 0){
                            dispatchStatus= "";
                          }
                          else if(index == 1){
                            dispatchStatus= "R";
                          }
                          else if(index == 2){
                            dispatchStatus= "D";
                          }
                          else if(index == 3){
                            dispatchStatus= "E";
                          }
                          else if(index == 4){
                            dispatchStatus= "O";
                          }
                          else if(index == 5){
                            dispatchStatus= "G";
                          }
                          else if(index == 6){
                            dispatchStatus= "A";
                          }
                          else if(index == 7){
                            dispatchStatus= "C";
                          }
                          setState(() {
                            searchOptionType.forEach(
                                (element) => element.isSelected = false);
                            searchOptionType[index].isSelected = true;
                          });
                        },
                        child: new RadioItem(searchOptionType[index]),
                      ));
                    }),
                  ),
                ),
                SizedBox(
                  height: 75,
                  child: TextField(
                      controller: myController,
                  decoration:
                  InputDecoration(labelText: 'Enter Value for Search Option')
                      ),
                ),
                SizedBox(
                    //                    padding: EdgeInsets.all(8.0),

//                        width: 100,
                    height: 50,
                    child: FlatButton(
//                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
//                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: Color(0xff333333))),
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(0.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          filterFields=searchOptionField+myController.text+"|pinNumber:PIN0000074|towedStatus:C|dispatchStatus:"+dispatchStatus;
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => SearchListScreen(filterFields)));
//                       setState(() =>
//                        selected_status="Accept");
                        },
                        child: Text('FIND')))
              ]),
            )));
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      //  margin: new EdgeInsets.all(10.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50,
            width: 120,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Colors.blueAccent : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.blueAccent : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}

//import 'package:flutter/material.dart';
//import 'package:vts_mobile_cloud/widgets/search_calls_list.dart';
//
//class SearchCallScreen extends StatelessWidget {
//  SearchCallScreen({this.onPush});
//  final ValueChanged<int> onPush;
////  static const routeName = '/search-call';
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('SEARCH CALL'),
//        ),
//        body: Container(
//            margin: EdgeInsets.all(10.0),
//            padding: EdgeInsets.all(5.0),
//            alignment: Alignment.topCenter,
//            decoration: BoxDecoration(
//              color: Colors.white,
//              // border: Border.all(),
//            ),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
////        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(1.0),
//                  child: Text('Search Option (Choose any one)'),
//                ),
//                Row(
//                  children: <Widget>[
//                    Padding(
//                        padding: EdgeInsets.all(1.0),
//                        child: SizedBox(
//                            width: 100,
//                            height: 40,
//                            child: FlatButton(
////                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
////                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                                shape: new RoundedRectangleBorder(
//                                    borderRadius:
//                                        new BorderRadius.circular(10.0),
//                                    side: BorderSide(color: Color(0xff333333))),
//                                disabledTextColor: Colors.black,
//                                padding: EdgeInsets.all(8.0),
//                                splashColor: Colors.blueAccent,
//                                onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                                },
//                                child: Text('Call Date')))),
//                    Padding(
//                        padding: EdgeInsets.all(8.0),
//                        child: SizedBox(
//                            width: 100,
//                            height: 40,
//                            child: FlatButton(
////                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
////                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                                shape: new RoundedRectangleBorder(
//                                    borderRadius:
//                                        new BorderRadius.circular(10.0),
//                                    side: BorderSide(color: Color(0xff333333))),
//                                disabledTextColor: Colors.black,
//                                padding: EdgeInsets.all(8.0),
//                                splashColor: Colors.blueAccent,
//                                onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                                },
//                                child: Text('License')))),
//                    Padding(
//                        padding: EdgeInsets.all(8.0),
//                        child: SizedBox(
//                            width: 100,
//                            height: 40,
//                            child: FlatButton(
//                                //   color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
//                                // textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                                shape: new RoundedRectangleBorder(
//                                    borderRadius:
//                                        new BorderRadius.circular(10.0),
//                                    side: BorderSide(color: Color(0xff333333))),
//                                disabledTextColor: Colors.black,
//                                padding: EdgeInsets.all(8.0),
//                                splashColor: Colors.blueAccent,
//                                onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                                },
//                                child: Text('PO#')))),
//                  ],
//                ),
//                Row(
//                  children: <Widget>[
//                    Padding(
//                        padding: EdgeInsets.all(8.0),
//                        child: SizedBox(
//                            width: 100,
//                            height: 40,
//                            child: FlatButton(
//                                // color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
//                                // textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                                shape: new RoundedRectangleBorder(
//                                    borderRadius:
//                                        new BorderRadius.circular(10.0),
//                                    side: BorderSide(color: Color(0xff333333))),
//                                disabledTextColor: Colors.black,
//                                padding: EdgeInsets.all(8.0),
//                                splashColor: Colors.blueAccent,
//                                onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                                },
//                                child: Text('Invoice')))),
//                  ],
//                ),
//                Text('Search Type (Choose any one)',
//                    textAlign: TextAlign.start),
//                Row(children: <Widget>[
//                  Padding(
//                      padding: EdgeInsets.all(8.0),
//                      child: SizedBox(
//                          width: 100,
//                          height: 40,
//                          child: FlatButton(
////                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
////                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius: new BorderRadius.circular(10.0),
//                                  side: BorderSide(color: Color(0xff333333))),
//                              disabledTextColor: Colors.black,
//                              padding: EdgeInsets.all(8.0),
//                              splashColor: Colors.blueAccent,
//                              onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                              },
//                              child: Text('All')))),
//                  Padding(
//                      padding: EdgeInsets.all(8.0),
//                      child: SizedBox(
//                          width: 100,
//                          height: 40,
//                          child: FlatButton(
////                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
////                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius: new BorderRadius.circular(10.0),
//                                  side: BorderSide(color: Color(0xff333333))),
//                              disabledTextColor: Colors.black,
//                              padding: EdgeInsets.all(8.0),
//                              splashColor: Colors.blueAccent,
//                              onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                              },
//                              child: Text('Received')))),
//                  Padding(
//                      padding: EdgeInsets.all(8.0),
//                      child: SizedBox(
//                          width: 100,
//                          height: 40,
//                          child: FlatButton(
////                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
////                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius: new BorderRadius.circular(10.0),
//                                  side: BorderSide(color: Color(0xff333333))),
//                              disabledTextColor: Colors.black,
//                              padding: EdgeInsets.all(8.0),
//                              splashColor: Colors.blueAccent,
//                              onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                              },
//                              child: Text('Dispatch'))))
//                ]),
//                Row(children: <Widget>[
//                  Padding(
//                      padding: EdgeInsets.all(8.0),
//                      child: SizedBox(
//                          width: 100,
//                          height: 40,
//                          child: FlatButton(
////                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
////                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius: new BorderRadius.circular(10.0),
//                                  side: BorderSide(color: Color(0xff333333))),
//                              disabledTextColor: Colors.black,
//                              padding: EdgeInsets.all(8.0),
//                              splashColor: Colors.blueAccent,
//                              onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                              },
//                              child: Text('Enroute')))),
//                  Padding(
//                      padding: EdgeInsets.all(8.0),
//                      child: SizedBox(
//                          width: 100,
//                          height: 40,
//                          child: FlatButton(
////                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
////                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius: new BorderRadius.circular(10.0),
//                                  side: BorderSide(color: Color(0xff333333))),
//                              disabledTextColor: Colors.black,
//                              padding: EdgeInsets.all(8.0),
//                              splashColor: Colors.blueAccent,
//                              onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                              },
//                              child: Text('Onsite')))),
//                  Padding(
//                      padding: EdgeInsets.all(8.0),
//                      child: SizedBox(
//                          width: 100,
//                          height: 40,
//                          child: FlatButton(
////                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
////                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius: new BorderRadius.circular(10.0),
//                                  side: BorderSide(color: Color(0xff333333))),
//                              disabledTextColor: Colors.black,
//                              padding: EdgeInsets.all(8.0),
//                              splashColor: Colors.blueAccent,
//                              onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                              },
//                              child: Text('Rolling'))))
//                ]),
//                Row(
//                  children: <Widget>[
//                    Padding(
//                        padding: EdgeInsets.all(8.0),
//                        child: SizedBox(
//                            width: 100,
//                            height: 40,
//                            child: FlatButton(
////                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
////                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                                shape: new RoundedRectangleBorder(
//                                    borderRadius:
//                                        new BorderRadius.circular(10.0),
//                                    side: BorderSide(color: Color(0xff333333))),
//                                disabledTextColor: Colors.black,
//                                padding: EdgeInsets.all(8.0),
//                                splashColor: Colors.blueAccent,
//                                onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                                },
//                                child: Text('Arrived')))),
//                    Padding(
//                        padding: EdgeInsets.all(8.0),
//                        child: SizedBox(
//                            width: 100,
//                            height: 40,
//                            child: FlatButton(
//                                //   color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
//                                // textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                                shape: new RoundedRectangleBorder(
//                                    borderRadius:
//                                        new BorderRadius.circular(10.0),
//                                    side: BorderSide(color: Color(0xff333333))),
//                                disabledTextColor: Colors.black,
//                                padding: EdgeInsets.all(8.0),
//                                splashColor: Colors.blueAccent,
//                                onPressed: () {
////                        setState(() =>
////                        selected_status="Accept");
//                                },
//                                child: Text('Cleared')))),
//                  ],
//                ),
//                TextField(
//                    decoration:
//                        InputDecoration(labelText: 'License Plate')),
//                Padding(
//                    padding: EdgeInsets.all(8.0),
//                    child: SizedBox(
//                        width: 100,
//                        height: 40,
//                        child: FlatButton(
////                      color: selected_status == "Accept" ? Color(0xff12406F): Colors.white,
////                      textColor: selected_status == "Accept" ? Colors.white: Colors.black,
//                            shape: new RoundedRectangleBorder(
//                                borderRadius: new BorderRadius.circular(10.0),
//                                side: BorderSide(color: Color(0xff333333))),
//                            disabledTextColor: Colors.black,
//                            padding: EdgeInsets.all(8.0),
//                            splashColor: Colors.blueAccent,
//                            onPressed: () {
//                              Navigator.push(
//                                  context,
//                                  new MaterialPageRoute(
//                                      builder: (context) =>  SearchCallsList()));
////                        setState(() =>
////                        selected_status="Accept");
//                            },
//                            child: Text('FIND')))),
//              ],
//            )));
//  }
//}
