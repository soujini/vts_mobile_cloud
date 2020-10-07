import 'package:flutter/material.dart';
import '../widgets/call_add.dart';

class AddCallScreen extends StatefulWidget {
  final Function notifyParent;
  AddCallScreen({Key key, this.notifyParent}) : super(key: key);
  @override
  _AddCallScreen createState() => _AddCallScreen();
}
class _AddCallScreen extends State<AddCallScreen> {
  refresh(){
    widget.notifyParent();
  }

  @override
  Widget build(BuildContext context) {
    return CallAdd(notifyParent:refresh);
  }
}
