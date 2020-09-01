import 'package:flutter/material.dart';
import '../widgets/success.dart';

class SuccessScreen extends StatelessWidget {
  String message="";
  SuccessScreen(this.message);

  @override
  Widget build(BuildContext context) {
    return Success(this.message);
  }
}
