import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:vts_mobile_cloud/screens/search_list_screen.dart';
import 'package:vts_mobile_cloud/widgets/tow_type_modal.dart';
import 'package:vts_mobile_cloud/widgets/authorization_modal.dart';
import 'package:vts_mobile_cloud/widgets/wrecker_company_modal.dart';
import 'package:vts_mobile_cloud/widgets/wrecker_driver_modal.dart';
import '../providers/secureStoreMixin_provider.dart';

class SearchCallScreen extends StatefulWidget {
  @override
  createState() {
    return SearchCallScreenState();
  }
}

class SearchCallScreenState extends State<SearchCallScreen> with SecureStoreMixin {
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
  String userRole;
  String pinNumber;
  var dispatchPaging;

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
    getRole();
    getDispatchPaging();
    getSecureStore('pinNumber', (token) {
      pinNumber=token;
    });

    searchOption.add(new RadioModel(false, 'Call Date', ''));
    searchOption.add(new RadioModel(false, 'Plate #', ''));
    searchOption.add(new RadioModel(false, 'PO #', ''));
    searchOption.add(new RadioModel(false, 'Invoice', ''));
    searchOption.add(new RadioModel(false, 'Driver', ''));
    searchOption.add(new RadioModel(false, 'Company', ''));
    searchOption.add(new RadioModel(false, 'Authorization', ''));
    searchOption.add(new RadioModel(false, 'Tow Type', ''));

    searchOptionType.add(new RadioModel(false, 'All', ''));
    searchOptionType.add(new RadioModel(false, 'Received', ''));
    searchOptionType.add(new RadioModel(false, 'Dispatch', ''));
    searchOptionType.add(new RadioModel(false, 'Enroute', ''));
    searchOptionType.add(new RadioModel(false, 'Onsite', ''));
    searchOptionType.add(new RadioModel(false, 'Rolling', ''));
    searchOptionType.add(new RadioModel(false, 'Arrived', ''));
    searchOptionType.add(new RadioModel(false, 'Cleared', ''));
  }

  setDriver(suggestion) {
    setState(() {
      selectedModalOption=suggestion.wreckerDriver;
//      _call.wreckerDriver = id;
//      _call.wreckerDriverName = name;
      myController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: suggestion.wreckerDriverName))
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
  setTowType(suggestion) {
    setState(() {
      selectedModalOption=suggestion.towType;
//      _call.towType = id;
//      _call.towTypeName = name;
      myController.value =
          new TextEditingController.fromValue(new TextEditingValue(text: suggestion.towTypeName))
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
        dispatchPaging=token;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
       // home: Scaffold(
            appBar: AppBar(
              title: Text('SEARCH CALLS', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
            ),
            body: SingleChildScrollView(
              child:Center(
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding:EdgeInsets.only(top:20.0, bottom:20, left:20, right:5),
                        child: Text("SEARCH OPTION", style:TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:Color(0xff1c3764))),
                  ),
                  Padding(
                      padding:EdgeInsets.only(bottom:2),
                      child: Text("(Choose any one)", style:TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color:Color(0xffB5B5B4))),
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
                Padding(
                  padding:EdgeInsets.all(0.0),
                  child:(selectedOptionIndex == 1 || selectedOptionIndex == 2 || selectedOptionIndex == 3) ?
                  SizedBox(

                  height: 75,
                      child:Padding(
                        padding:EdgeInsets.all(15.0),
                  child: TextField(
                      textCapitalization: TextCapitalization.characters,
                      controller: myController,
                      decoration:
                      InputDecoration(labelText: 'Enter Value for Search Option', labelStyle: TextStyle(fontSize:14, fontWeight:FontWeight.w500))

                  )),
                ) : (selectedOptionIndex == 0)
                      ?
                  new ListTile(
                    title: new TextFormField(
                      controller: myController,
                      decoration: new InputDecoration(
                        labelText: "Call Date",
                          labelStyle: TextStyle(fontSize:14, fontWeight:FontWeight.w500),
                        suffixIcon: IconButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                //  minTime: DateTime(2018, 3, 5),
                                //  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                                //   //print('change $date');
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
                          icon: Icon(Icons.date_range, size:20),
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
                            labelStyle: TextStyle(fontSize:14, fontWeight:FontWeight.w500),
                          suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
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
                            labelStyle: TextStyle(fontSize:14, fontWeight:FontWeight.w500),
                          suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please select Company';
                          }
                          else{
                            return null;
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
                            labelStyle: TextStyle(fontSize:14, fontWeight:FontWeight.w500),
                          suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
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
                            labelStyle: TextStyle(fontSize:14, fontWeight:FontWeight.w500),
                          suffixIcon: Icon(Icons.arrow_forward_ios, size:14),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please select Tow Type';
                          }
                          else{
                            return null;
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
                    padding:EdgeInsets.only(top:20.0, bottom:20, left:20, right:5),
                    child:   Text("SEARCH TYPE", style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold, color:Color(0xff1c3764))),
                  ),
                  Padding(
                    padding:EdgeInsets.only(bottom:2),
                    child: Text("(Choose any one)", style:TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color:Color(0xffB5B5B4))),
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
                    height: 50,
                    child: FlatButton(
                        color: Color(0xff1C3764),
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: Color(0xff1C3764))),
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          if(selectedOptionIndex == 0){
                            filterFields = searchOptionField +
                                myController.text +
                                "|pinNumber:"+pinNumber+"|towedStatus:C|dispatchStatus:" +
                                dispatchStatus;
                          }
                          if(selectedOptionIndex > 0 && selectedOptionIndex < 4){
                            filterFields = searchOptionField +
                                myController.text +
                                "|pinNumber:"+pinNumber+"|towedStatus:C|dispatchStatus:" +
                                dispatchStatus;
                          }
                          if(selectedOptionIndex >= 4){
                            filterFields = searchOptionField +
                                selectedModalOption.toString() +
                                "|pinNumber:"+pinNumber+"|towedStatus:C|dispatchStatus:" +
                                dispatchStatus;

                          }
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      SearchListScreen(filterFields, userRole, dispatchPaging)));
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

