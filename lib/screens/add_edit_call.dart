
import 'package:flutter/material.dart';
import 'package:vts_mobile_cloud/widgets/call_edit.dart';

class AddEditCallScreen extends StatelessWidget {
  AddEditCallScreen(this.initialIndex);
  var initialIndex;

  @override
  Widget build(BuildContext context) {
  return CallEdit(initialIndex);
  }
}