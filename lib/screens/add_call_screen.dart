import 'package:flutter/material.dart';
import '../widgets/call_add.dart';

class AddCallScreen extends StatefulWidget {
  final Function notifyParent;
  int currentIndex;
  AddCallScreen({Key key, this.currentIndex, this.notifyParent}) : super(key: key);
  @override
  _AddCallScreen createState() => _AddCallScreen();
}
class _AddCallScreen extends State<AddCallScreen> {
  refresh(){
    // widget.notifyParent();
    setState(() {
      widget.currentIndex=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CallAdd(notifyParent:refresh);
  }
}
