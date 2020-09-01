import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  String message="";
  Success(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

               SizedBox(
                height: 200.0,
                child: Image.asset(
                  "assets/success.png",
                  fit: BoxFit.contain,
                ),
              ),
          Container(
            child:Text(this.message, style: TextStyle(color: Colors.lightGreen, fontSize: 22, fontWeight: FontWeight.w500),)
          )

        ]));
  }
}