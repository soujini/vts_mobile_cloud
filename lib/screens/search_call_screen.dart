import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:vts_mobile_cloud/screens/search_list_screen.dart';
import 'package:vts_mobile_cloud/widgets/tow_type_modal.dart';
import 'package:vts_mobile_cloud/widgets/authorization_modal.dart';
import 'package:vts_mobile_cloud/widgets/wrecker_company_modal.dart';
import 'package:vts_mobile_cloud/widgets/wrecker_driver_modal.dart';

import '../widgets/search_calls_list.dart';

class SearchCallScreen extends StatefulWidget {
  @override
  createState() {
    return SearchCallScreenState();
  }
}

class SearchCallScreenState extends State<SearchCallScreen> {
  DateTime now = DateTime.now();

  List<RadioModel> searchOption = new List<RadioModel>();
  List<RadioModel> searchOptionType = new List<RadioModel>();
  String filterFields = "";

  String searchOptionField = "";
  String dispatchStatus = "";
  var selectedOptionIndex;
  var selectedTypeIndex;
  var selectedModalOption=0;
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
    searchOption.add(new RadioModel(false, 'CALL DATE', ''));
    searchOption.add(new RadioModel(false, 'PLATE #', ''));
    searchOption.add(new RadioModel(false, 'PO#', ''));
    searchOption.add(new RadioModel(false, 'INVOICE', ''));
    searchOption.add(new RadioModel(false, 'DRIVER', ''));
    searchOption.add(new RadioModel(false, 'COMPANY', ''));
    searchOption.add(new RadioModel(false, 'AUTHORIZATION', ''));
    searchOption.add(new RadioModel(false, 'TOW TYPE', ''));

    searchOptionType.add(new RadioModel(false, 'ALL', ''));
    searchOptionType.add(new RadioModel(false, 'RECEIVED', ''));
    searchOptionType.add(new RadioModel(false, 'DISPATCH', ''));
    searchOptionType.add(new RadioModel(false, 'ENROUTE', ''));
    searchOptionType.add(new RadioModel(false, 'ONSITE', ''));
    searchOptionType.add(new RadioModel(false, 'ROLLING', ''));
    searchOptionType.add(new RadioModel(false, 'ARRIVED', ''));
    searchOptionType.add(new RadioModel(false, 'CLEARED', ''));
  }

  setDriver(id, name) {
    setState(() {
      selectedModalOption=id;
//      _call.wreckerDriver = id;
//      _call.wreckerDriverName = name;
      myController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }
  setCompany(id, name) {
    setState(() {
      selectedModalOption=id;
//      _call.wreckerCompany = id;
//      _call.wreckerCompanyName = name;
      myController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }
  setTowType(id, name) {
    setState(() {
      selectedModalOption=id;
//      _call.towType = id;
//      _call.towTypeName = name;
      myController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }


  setAuthorization(id, name) {
    selectedModalOption=id;
    setState(() {
//      _call.towAuthorization = id;
//      _call.towAuthorizationName = name;
      myController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: name))
              .value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // home: Scaffold(
            appBar: AppBar(
              title: Text("Search Calls"),
            ),
            body: SingleChildScrollView(
              child:Center(
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding:EdgeInsets.all(20.0),
                        child:   Text("SEARCH OPTION (Choose any one)"),
                  )

                ]),
                SizedBox(
                  height: 125,
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 4,
                    childAspectRatio: 2.0,
                    padding: const EdgeInsets.all(5.0),
//                mainAxisSpacing: 1.0,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(searchOption.length, (index) {
                      return Center(
                          child: new InkWell(
                        //highlightColor: Colors.red,
                        splashColor: Colors.green,
                        onTap: () {
                          setState(() {
                            selectedOptionIndex = index;
                            myController.value =
                                new TextEditingController.fromValue(new TextEditingValue(text: ""))
                                    .value;
                          });
                          if (index == 0) {
                            searchOptionField = "dispatchDate:";
                          } else if (index == 1) {
                            searchOptionField = "licensePlate:";
                          } else if (index == 2) {
                            searchOptionField = "towedPONumber:";
                          } else if (index == 3) {
                            searchOptionField = "towedInvoice:";
                          }else if (index == 4) {
                            searchOptionField = "wreckerDriver:";
                          }else if (index == 5) {
                            searchOptionField = "wreckerCompany:";
                          }else if (index == 6) {
                            searchOptionField = "towAuthorization:";
                          }else if (index == 7) {
                            searchOptionField = "towType:";
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

//                Text("asdasdhajdsaskd "+selectedOptionIndex.toString()),
                Padding(
                  padding:EdgeInsets.all(20.0),
                  child:(selectedOptionIndex == 1 || selectedOptionIndex == 2 || selectedOptionIndex == 3) ?
                  SizedBox(
                  height: 75,
                  child: TextField(
                      controller: myController,
                      decoration:
                      InputDecoration(labelText: 'Enter Value for Search Option')
                  ),
                ) : (selectedOptionIndex == 0)
                      ?
                  ListTile(
                    title: new TextFormField(
                      controller: myController,
                      decoration: new InputDecoration(
                        labelText: "Call Date",
                        suffixIcon: IconButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                //  minTime: DateTime(2018, 3, 5),
                                //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                                //   print('change $date');
                                // },
                                onConfirm: (date) {
                                  String formattedDate =
                                  DateFormat('MM-dd-yyyy').format(date);
                                  myController.text = formattedDate;
//                              String formattedTime = DateFormat('kk.mm').format(now);
//                              String formattedTime2 = DateFormat('kk^mm').format(now);
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          }, //_controller.clear(),
                          icon: Icon(Icons.date_range),
                        ),
                      ),
                    //  onSaved: (val) => setState(() => _call.towedDate = val),
                    ),
                  ) :  (selectedOptionIndex == 4)?
                  new ListTile(
//                  leading: Container(
//                    width: 100, // can be whatever value you want
//                    alignment: Alignment.centerLeft,
//                    child: Text("Driver"),
//                  ),
                    //trailing: Icon(Icons.shopping_cart),
                    title: new TextFormField(
                        controller: this.myController,
                        decoration: new InputDecoration(
                          labelText: "Driver",
                          suffixIcon: Icon(Icons.arrow_forward_ios),
                        ),
                        onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new WreckerDriverModal(
                                      setDriver: setDriver)));
                        }),
                  ) : (selectedOptionIndex == 5)?
                  new ListTile(
//                  leading: Container(
//                    width: 100, // can be whatever value you want
//                    alignment: Alignment.centerLeft,
//                    child: Text("Company *"),
//                  ),
                    //trailing: Icon(Icons.shopping_cart),
                    title: new TextFormField(
                        controller: this.myController,
                        decoration: new InputDecoration(
                          labelText: "Company *",
                          suffixIcon: Icon(Icons.arrow_forward_ios),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please select Company';
                          }
                        },
                        onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new WreckerCompanyModal(
                                      setCompany: setCompany)));
                        }),
                  ): (selectedOptionIndex == 6) ?
                  new ListTile(
//                  leading: Container(
//                    width: 100, // can be whatever value you want
//                    alignment: Alignment.centerLeft,
//                    child: Text("Authorization"),
//                  ),
                    //trailing: Icon(Icons.shopping_cart),
                    title: new TextFormField(
                        controller: this.myController,
                        decoration: new InputDecoration(
                          labelText: "Authorization",
                          suffixIcon: Icon(Icons.arrow_forward_ios),
                        ),
                        onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new TowAuthorizationModal(
                                      setAuthorization: setAuthorization)));
                        }),
                  ) : (selectedOptionIndex == 7) ?
                  new ListTile(
//                  leading: Container(
//                    width: 100, // can be whatever value you want
//                    alignment: Alignment.centerLeft,
//                    child: Text("Tow Type *"),
//                  ),
                    //trailing: Icon(Icons.shopping_cart),
                    title: new TextFormField(
                        controller: this.myController,
                        decoration: new InputDecoration(
                          hintText: "Tow Type *",
                          suffixIcon: Icon(Icons.arrow_forward_ios),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please select Tow Type';
                          }
                        },
                        onTap: () {
//                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChildScreen(func: function))),
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                  new TowTypeModal(setTowType: setTowType)));
                        }),
                  ):
                  new Container()
                ),
                Row(children: <Widget>[
                  Padding(
                    padding:EdgeInsets.all(20.0),
                    child:   Text("SEARCH TYPE (Choose any one)"),
                  )

                ]),
                SizedBox(
                  height: 125.0,
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 4,
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
                          if (index == 0) {
                            dispatchStatus = "";
                          } else if (index == 1) {
                            dispatchStatus = "R";
                          } else if (index == 2) {
                            dispatchStatus = "D";
                          } else if (index == 3) {
                            dispatchStatus = "E";
                          } else if (index == 4) {
                            dispatchStatus = "O";
                          } else if (index == 5) {
                            dispatchStatus = "G";
                          } else if (index == 6) {
                            dispatchStatus = "A";
                          } else if (index == 7) {
                            dispatchStatus = "C";
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
                          if(selectedOptionIndex == 0){
                            filterFields = searchOptionField +
                                myController.text +
                                "|pinNumber:PIN0000074|towedStatus:C|dispatchStatus:" +
                                dispatchStatus;
                          }
                          if(selectedOptionIndex > 0 && selectedOptionIndex < 4){
                            filterFields = searchOptionField +
                                myController.text +
                                "|pinNumber:PIN0000074|towedStatus:C|dispatchStatus:" +
                                dispatchStatus;
                          }
                          if(selectedOptionIndex >= 4){
                            filterFields = searchOptionField +
                                selectedModalOption.toString() +
                                "|pinNumber:PIN0000074|towedStatus:C|dispatchStatus:" +
                                dispatchStatus;

                          }
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      SearchListScreen(filterFields)));
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
            height: 45,
            width: 95,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 11.5)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Colors.green : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.green : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 1.0),
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

