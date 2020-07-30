import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vts_mobile_cloud/providers/towedVehiclePictures_provider.dart';
import '../providers/calls_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class PhotosAdd extends StatefulWidget {
  @override
  createState() {
    return _PhotosAddState();
  }
}

class _PhotosAddState extends State<PhotosAdd> {
  final _formKey = GlobalKey<FormState>();
  final _picture = TowedVehiclePicture();
  File _image;
  final _picker = ImagePicker();
  List<RadioModel> searchOption = new List<RadioModel>();
  String filterFields = "";
  String searchOptionField = "";
  var selectedOptionIndex;
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
    searchOption.add(new RadioModel(false, 'REAR VIEW', '4'));
    searchOption.add(new RadioModel(false, 'LEFT SIDE VIEW', '2'));
    searchOption.add(new RadioModel(false, 'FRONT VIEW', '1'));
    searchOption.add(new RadioModel(false, 'RIGHT SIDE VIEW', '3'));
    searchOption.add(new RadioModel(false, 'DRIVER\'S LICENSE', '5'));
    searchOption.add(new RadioModel(false, 'PHOTO ID', '6'));
    searchOption.add(new RadioModel(false, 'PASSPORT', '7'));
    searchOption.add(new RadioModel(false, 'INSURANCE CARD', '8'));

  }
  Future<void> _optionsDialogBox() {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take a picture'),
                    onTap: openCamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Select from gallery'),
                    onTap: openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }
  Future openCamera() async{
    Navigator.of(context, rootNavigator: true).pop();
     final PickedFile pickedFile = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path.toString());
      List<int> imageBytes = _image.readAsBytesSync();
      _picture.base64Photo = base64.encode(imageBytes);
    });
  }
    Future openGallery() async{
      Navigator.of(context, rootNavigator: true).pop();
    final PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      List<int> imageBytes = _image.readAsBytesSync();
      _picture.base64Photo = base64.encode(imageBytes);
    });
  }
  Future save() async{
    final form = _formKey.currentState;
    var selectedCall = Provider.of<Calls>(context, listen:false).selectedCall;
    _picture.towedVehicle = selectedCall.id;
//    _picture.vehicleNotes= "";
print(selectedOptionIndex);
if(selectedOptionIndex == 0){
  _picture.vehiclePictureType=4;
}
else if(selectedOptionIndex == 1){
      _picture.vehiclePictureType=2;
    }
else if(selectedOptionIndex == 2){
  _picture.vehiclePictureType=1;
}
else if(selectedOptionIndex == 3){
  _picture.vehiclePictureType=3;
}
else if(selectedOptionIndex == 4){
  _picture.vehiclePictureType=5;
}
else if(selectedOptionIndex == 5){
  _picture.vehiclePictureType=6;
}
else if(selectedOptionIndex == 6){
  _picture.vehiclePictureType=7;
}
else if(selectedOptionIndex == 7){
  _picture.vehiclePictureType=8;
}

//   form.save();
//    print(form);
    await Provider.of<TowedVehiclePicturesVM>(context, listen:false).create(_picture);
//    .then((res) {
//      Navigator.push(
//          context,
//          new MaterialPageRoute(
//              builder: (context) =>
//              new AddEditCallScreen()));
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // home: Scaffold(
        appBar: AppBar(
          title: Text("Add Photo"),
        ),
        body: SingleChildScrollView(
            child:Center(
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding:EdgeInsets.all(20.0),
                    child:   Text("CHOOSE OPTION (Choose any one)"),
                  )

                ]),
                SizedBox(
                  height: 200,
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
                            splashColor: Colors.green,
                            onTap: () {
                              _optionsDialogBox();
                              setState(() {
                                selectedOptionIndex = index;
                                myController.value = new TextEditingController.fromValue(new TextEditingValue(text: "")).value;

//                                _picture.vehiclePictureType=new TextEditingController.fromValue(new TextEditingValue(text: "")).value;
                              });
//                              if (index == 0) {
//                                searchOptionField = "dispatchDate:";
//                              } else if (index == 1) {
//                                searchOptionField = "licensePlate:";
//                              } else if (index == 2) {
//                                searchOptionField = "towedPONumber:";
//                              } else if (index == 3) {
//                                searchOptionField = "towedInvoice:";
//                              }else if (index == 4) {
//                                searchOptionField = "wreckerDriver:";
//                              }else if (index == 5) {
//                                searchOptionField = "wreckerCompany:";
//                              }else if (index == 6) {
//                                searchOptionField = "towAuthorization:";
//                              }else if (index == 7) {
//                                searchOptionField = "towType:";
//                              }
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
                    child:
                    Container(
                      height:200,
                      child: _image == null ? Text('No image selected.') : Image.file(_image),
                    ),
//                    SizedBox(
//                      height: 75,
////                      child: TextField(
////                          controller: myController,
////                          decoration:
////                          InputDecoration(labelText: 'Enter Value for Search Option')
////                      ),
//                    )
                ),

                SizedBox(
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
                        onPressed:  () =>save(),
//                          if(selectedOptionIndex == 0){
//                            filterFields = searchOptionField +
//                                myController.text +
//                                "|pinNumber:PIN0000074|towedStatus:C|dispatchStatus:" +
//                                dispatchStatus;
//                          }
//                          if(selectedOptionIndex > 0 && selectedOptionIndex < 4){
//                            filterFields = searchOptionField +
//                                myController.text +
//                                "|pinNumber:PIN0000074|towedStatus:C|dispatchStatus:" +
//                                dispatchStatus;
//                          }
//                          if(selectedOptionIndex >= 4){
//                            filterFields = searchOptionField +
//                                selectedModalOption.toString() +
//                                "|pinNumber:PIN0000074|towedStatus:C|dispatchStatus:" +
//                                dispatchStatus;
//
//                          }


                        child: Text('SAVE')))
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
            width: 120,
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

