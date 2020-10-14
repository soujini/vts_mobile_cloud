import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/providers/calls_provider.dart';
import 'package:vts_mobile_cloud/providers/towedVehicleNotes_provider.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';

enum SingingCharacter { Owner, Payment }
class NotesEdit extends StatefulWidget {
  bool isLoading = false;
  final Function notifyParent;
  NotesEdit({Key key, this.notifyParent}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotesEditState();
  }
}

class _NotesEditState extends State<NotesEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = true;

  var _note = TowedVehicleNote();
  SingingCharacter _character;
  var _vehicleNotes_stringController = new TextEditingController();

  void initState(){
    _note = Provider.of<TowedVehicleNotesVM>(context, listen: false).selectedNote;
    getValues();
  }
  getValues() {
    widget.isLoading = true;

    setState(() {
      _vehicleNotes_stringController.value = new TextEditingController.fromValue(
          new TextEditingValue(text: _note.vehicleNotes_string))
          .value;

      if(_note.paymentNotes == true){
        _character = SingingCharacter.Payment;
      }
      else{
        _character = SingingCharacter.Owner;
      }
      // _note.ownerNotes = _note.ownerNotes;
      widget.isLoading = false;
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

  save() async {
    this.setState(() {
      widget.isLoading = true;
    });
    final form = _formKey.currentState;
    var selectedCall = Provider
        .of<Calls>(context, listen: false)
        .selectedCall;

    _note.towedVehicle = selectedCall.id;
    if (_note.paymentNotes == null) {
      _note.paymentNotes = false;
    }
    if (_note.ownerNotes == null) {
      _note.ownerNotes = false;
    }
    if (form.validate()) {
      form.save();
      await Provider.of<TowedVehicleNotesVM>(context, listen: false).update(_note);
      var notesUpdateResponse = Provider
          .of<TowedVehicleNotesVM>(context, listen: false)
          .notesUpdateResponse;
      if (notesUpdateResponse["errorStatus"] == "false") {
        widget.isLoading = false;
        _showErrorMessage(context, notesUpdateResponse["errorMessage"]);
      }
      else {
        widget.isLoading = false;
        Navigator.pop(context);
        widget.notifyParent();
      }
    }
    else {
      this.setState(() {
        widget.isLoading = false;
      });
      //invalid fields
    }
  }

  @override
  Widget build(BuildContext context) {
    // return AlertDialog(
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: Text('EDIT NOTES', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
        ),
        body: Container(
            child: widget.isLoading == true ? Center(child:Loader()) :Form(
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
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 3,
                      controller: _vehicleNotes_stringController,
                      decoration: new InputDecoration(
                        hintText: "Notes",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Notes';
                        }
                        else{
                          return null;
                        }
                      },
                      onSaved: (val) => setState(() => _note.vehicleNotes_string = val),
                    ),
                  ),
                  ListTile(
                      title: const Text('Owner'),
                      trailing: Radio(
                        value: SingingCharacter.Owner,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() { _character = value;  _note.ownerNotes=true; _note.paymentNotes=false;});
                        },
                      )),
                  ListTile(
                      title: const Text('Payment'),
                      trailing: Radio(
                        value: SingingCharacter.Payment,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() { _character = value; _note.paymentNotes=true; _note.ownerNotes=false; });
                        },
                      )),
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
            )));
  }
}
