
import 'package:flutter/material.dart';
import 'package:vts_mobile_cloud/widgets/call_edit.dart';

class AddEditCallScreen extends StatelessWidget {
  var initialIndex;
  int selectedTabIndex;
  AddEditCallScreen(this.initialIndex, this.selectedTabIndex);


  @override
  Widget build(BuildContext context) {
  return CallEdit(initialIndex, selectedTabIndex);
  }
}