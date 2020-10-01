import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/providers/secureStoreMixin_provider.dart';
import 'package:vts_mobile_cloud/providers/towedVehicleCharges_provider.dart';
import 'package:vts_mobile_cloud/providers/processTowedVehicle_provider.dart';
import 'package:vts_mobile_cloud/widgets/tow_charges_modal.dart';
import '../providers/calls_provider.dart';
import 'package:vts_mobile_cloud/screens/add_edit_call.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';

class ChargesAdd extends StatefulWidget {
  int selectedCall=0;
  bool isLoading=false;

  ChargesAdd(this.selectedCall);

  @override
  State<StatefulWidget> createState() {
    return _ChargesAddState();
  }
}

class _ChargesAddState extends State<ChargesAdd> with SecureStoreMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isFormReadOnly=false;
  bool _autoValidate = true;
  final _charge = TowedVehicleCharge();
  String userRole;

  var _towChargesController = new TextEditingController();
  var _chargesQuantityController = new TextEditingController();
  var _discountQuantityController = new TextEditingController();
  var _chargesRateController = new TextEditingController();



  setTowCharge(id, name) {
    // final form = _formKey.currentState;
    // if (form.validate()) {
    //    form.save();
      getAndSetDefaultCharges(id);
      setState(() {
        _charge.towCharges = id;
        _towChargesController.value =
            new TextEditingController.fromValue(
                new TextEditingValue(text: name))
                .value;
      });
      _formKey.currentState.validate();
    }

  getAndSetDefaultCharges(towCharges) async {
    var selectedCall = Provider.of<Calls>(context, listen: false).callDetails;
    var towCustomer = selectedCall[0].towCustomer;
    var towType = selectedCall[0].towType;
    await Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
        .getDefaultCharges(towCharges, towCustomer, towType);
    var defaultCharges =
        Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
            .defaultCharges[0];
    setState(() {
      _charge.chargesQuantity = defaultCharges.chargesQuantity;
      _charge.discountQuantity = defaultCharges.discountQuantity;
      _charge.chargesRate = defaultCharges.chargesRate;

      _chargesQuantityController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: defaultCharges.chargesQuantity))
          .value;
      _discountQuantityController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: defaultCharges.discountQuantity))
          .value;
      _chargesRateController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: defaultCharges.chargesRate))
          .value;
    });
  }
  _showErrorMessage(BuildContext context, errorMessage) {
    Scaffold.of(context).showSnackBar(
        new SnackBar(
            backgroundColor: Colors.lightGreen,
            content: Text(errorMessage,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500
                ))));
  }
  getRole() async{
    await  getSecureStore('userRole', (token) {
      setState(() {
        userRole=token;
      });
    });
    if(userRole == "3"){
      _isFormReadOnly = true;
    }
  }
  save() async {

    final form = _formKey.currentState;
    var selectedCall = Provider.of<Calls>(context, listen: false).selectedCall;
    _charge.towedVehicle = selectedCall.id;
    _charge.discountRate = "0.00";
    _charge.discountApply = false;
    _charge.totalCharges = "0.00";

         if (form.validate()) {
           form.save();
           this.setState(() {
             widget.isLoading=true;
           });

           await Provider.of<TowedVehicleChargesVM>(context, listen: false)
               .create(_charge);
           var response = Provider
               .of<TowedVehicleChargesVM>(context, listen: false)
               .createResponse;
           if (response["errorStatus"] == "false") {
             this.setState(() {
               widget.isLoading = false;
             });
             _showErrorMessage(context, response["errorMessage"]);
           }
           else {
             await Provider.of<ProcessTowedVehiclesVM>(context, listen: false)
                 .processChangeCharges(_charge.towedVehicle, _charge.towCharges);
             var processChangeChargeResponse = Provider
                 .of<ProcessTowedVehiclesVM>(context, listen: false)
                 .processChangeChargeResponse;
             if (processChangeChargeResponse["errorStatus"] == "false") {
               this.setState(() {
                 widget.isLoading = false;
               });
               _showErrorMessage(
                   context, processChangeChargeResponse["errorMessage"]);
             }
             else {
               this.setState(() {
                 widget.isLoading = false;
               });
               // Navigator.pop(context);
               Navigator.push(context,
                   new MaterialPageRoute(
                       builder: (context) => new AddEditCallScreen(5)));
             }
           }
         }
         else{
           print("invalid fields");
         }
  }
  void initState(){
    super.initState();
    getRole();
  }

  String validateFields(String value){
    if (!value.isEmpty)
      return null;
    else
        return 'Please enter the value';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('ADD CHARGES', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
        ),
        body: widget.isLoading == true? Center(child:Loader()):Container(
            child: SingleChildScrollView(
                // child: AlertDialog(
                //content:
                child: Form(
          key: _formKey,
                  autovalidate: _autoValidate,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
              ),
              new ListTile(
                title: new TextFormField(
                    readOnly:true,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    controller: this._towChargesController,
                    decoration: new InputDecoration(
                      labelText: 'Charge *',
                      suffixIcon: Icon(Icons.arrow_forward_ios),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select Vehicle Charge';
                      }
                    },
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new TowChargesModal(
                                  setTowCharge: setTowCharge, selectedCall : widget.selectedCall)));
                    }),
              ),
              new ListTile(
                title: new TextFormField(
                  readOnly: _isFormReadOnly,
                  onEditingComplete: () {
                    // this.save();
                    FocusScope.of(context).requestFocus(new FocusNode());
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.number,
                  controller: _chargesQuantityController,
                  decoration: new InputDecoration(
                    labelText: 'Quantity *',
//                    suffixIcon: IconButton(
//                      //onPressed: () => _getVIN(), //_controller.clear(),
//                      icon: Icon(Icons.autorenew),
//                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please select Quantity';
                    }
                  },
                  onSaved: (val) =>
                      setState(() => _charge.chargesQuantity = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  readOnly: _isFormReadOnly,
                  onEditingComplete: () {
                    // this.save();
                    FocusScope.of(context).requestFocus(new FocusNode());
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.number,
                  controller: _discountQuantityController,
                  decoration: new InputDecoration(
                    labelText: 'Discount Quantity',
//                    suffixIcon: IconButton(
//                      //onPressed: () => _getVIN(), //_controller.clear(),
//                      icon: Icon(Icons.autorenew),
//                    ),
                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter Charges';
//                    }
                  //  },
                  onSaved: (val) =>
                      setState(() => _charge.discountQuantity = val),
                ),
              ),
              new ListTile(
                title: new TextFormField(
                  readOnly: _isFormReadOnly && _charge.chargesRate != "0.00",
                  onEditingComplete: () {
                    // this.save();
                    FocusScope.of(context).requestFocus(new FocusNode());
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.number,
                  controller: _chargesRateController,
                  decoration: new InputDecoration(
                    labelText: 'Rate *',
//                    suffixIcon: IconButton(
//                      //onPressed: () => _getVIN(), //_controller.clear(),
//                      icon: Icon(Icons.autorenew),
//                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please select Rate';
                    }
                  },
                  //  },
                  onSaved: (val) => setState(() => _charge.chargesRate = val),
                ),
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Color(0xff1c3764))
                  ),
                  color: Color(0xff1c3764),
                  textColor: Colors.white,
                  onPressed: () => save(),
                  child: Text('SAVE')),
            ],
          ),
        ))));
  }
}
