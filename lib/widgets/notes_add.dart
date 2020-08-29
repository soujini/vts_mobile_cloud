import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/providers/calls_provider.dart';
import 'package:vts_mobile_cloud/providers/notes_provider.dart';
import 'package:vts_mobile_cloud/screens/add_edit_call.dart';
import 'package:vts_mobile_cloud/widgets/loader.dart';

enum SingingCharacter { Owner, Payment }
class NotesAdd extends StatefulWidget {
  bool isLoading = false;
//  UpdateStatus(this.id, this.dispatchStatusName, this.dispatchInstructions_string);

  @override
  State<StatefulWidget> createState() {
    return _NotesAddState();
  }
}

class _NotesAddState extends State<NotesAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _note = Note();
  SingingCharacter _character;

  var _vehicleNotes_stringController = new TextEditingController();

//  void _reset() {
//    setState(() {
//      _formKey.currentState.reset();
//    });
//  }

  save() async {
    this.setState(() {
      widget.isLoading=true;
    });
    final form = _formKey.currentState;

    var selectedCall = Provider.of<Calls>(context, listen:false).selectedCall;

    _note.towedVehicle = selectedCall.id;
    if(_note.paymentNotes == null){
      _note.paymentNotes=false;
    }
    if(_note.ownerNotes == null){
      _note.ownerNotes=false;
    }
    form.save();
    await Provider.of<NotesVM>(context, listen:false).create(_note).then((res) {
      this.setState(() {
        widget.isLoading=false;
      });
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new AddEditCallScreen(4)));
    });
  }


//      if (form.validate()) {
//        form.save();
//        await Provider.of<NotesVM>(context).create(_note);
//      }


  @override
  Widget build(BuildContext context) {
   // return AlertDialog(
    return Scaffold(
        appBar: AppBar(
        // automaticallyImplyLeading: true,
          title: Text('ADD NOTES', style:TextStyle(fontSize:14, fontWeight: FontWeight.w600)),
    ),
    body: Container(
        child: widget.isLoading == true ? Center(child:Loader()) :Form(
      key: _formKey,
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
                                  setState(() { _character = value;  _note.paymentNotes=true; });
                                },
                  )),
          ListTile(
              title: const Text('Payment'),
              trailing: Radio(
                  value: SingingCharacter.Payment,
                                groupValue: _character,
                                onChanged: (SingingCharacter value) {
                                  setState(() { _character = value; _note.ownerNotes=true; });
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
