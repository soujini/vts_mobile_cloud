import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/animation.dart';
import 'dart:async';

import 'package:vts_mobile_cloud/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
  final Function setScreen;

  LoginPage({Key key, this.setScreen}) : super(key: key);
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  int _state = 0;
  final _user = new User();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _scaffoldKey = new GlobalKey<FormState>();

  GlobalKey _globalKey = new GlobalKey();

  void submit(BuildContext context) async {
    if (this._formKey.currentState.validate()) {
      animateButton();
      _formKey.currentState.save(); // Save our form now.

      await Provider.of<UsersVM>(context).validateUser(
          3556,
          _user.userName.toUpperCase(),
          _user.password.toUpperCase(),
          _user.pinNumber.toUpperCase());

      if (Provider
          .of<UsersVM>(context)
          .userData[0].errorStatus == true) {
        setState(() {
          _state = 2;
        });
        Timer(Duration(milliseconds: 500), () {
          widget.setScreen("home");
        });
      } else {
        setState(() {
          _state = 0;
          _showDialog(context);
        });
      }
    }
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context).showSnackBar(
        new SnackBar(
            backgroundColor: Colors.lightGreen,
          content: Text(Provider.of<UsersVM>(context).userData[0].errorMessage,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500
        ))));

  }

  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
        key: this._scaffoldKey,
        body: Builder(
        builder: (context) => Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff185695), Colors.black],
            )),
            child: new Form(
              key: this._formKey,
              child: new ListView(
                children: <Widget>[
                  Padding(
                      // padding: new EdgeInsets.symmetric(vertical: 50.0),
                      padding: new EdgeInsets.all(50),
                      child: SizedBox(
                        height: 100.0,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        top: 15,
                        right: 15,
                        bottom: 0,
                      ),
                      child: TextFormField(
                          onEditingComplete: () {
                            this.submit(context);
                            FocusScope.of(context).requestFocus(new FocusNode());
                          },
                          decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.account_circle,
                                color: Color(0XffC4CFDB)),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 3.0)),
                            hintText: 'USERNAME',
                            hintStyle: TextStyle(
                                fontSize: 16.0, color: Color(0XffC4CFDB)),
                          ),
                          style: new TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 18.0,
                              height: 1.5,
                              color: Colors.black54),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _user.userName = value;
                          })),
                  Padding(
                    //padding: EdgeInsets.only(top: 15.0),
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 15,
                      right: 15,
                      bottom: 0,
                    ),
                    child: TextFormField(
                        onEditingComplete: () {
                          this.submit(context);
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        obscureText: true,
                        decoration: new InputDecoration(
                          prefixIcon:
                              Icon(Icons.lock_open, color: Color(0XffC4CFDB)),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 3.0)),
                          hintText: 'PASSWORD',
                          hintStyle: TextStyle(
                              fontSize: 16.0, color: Color(0XffC4CFDB)),
                        ),
                        style: new TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 18.0,
                            height: 1.5,
                            color: Colors.black54),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _user.password = value;
                        }),
                  ),
                  Padding(
                    //padding: EdgeInsets.only(top: 15.0),
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 15,
                      right: 15,
                      bottom: 0,
                    ),
                    child: TextFormField(
                        onEditingComplete: () {
                          this.submit(context);
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
//                        onSubmitted: (value) {},
                        decoration: new InputDecoration(
                          prefixIcon:
                              Icon(Icons.dialpad, color: Color(0XffC4CFDB)),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 3.0)),
                          hintText: 'CUSTOMER PIN',
                          hintStyle: TextStyle(
                              fontSize: 16.0, color: Color(0XffC4CFDB)),
                        ),
                        style: new TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 18.0,
                            height: 1.5,
                            color: Colors.black54),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your customer pin';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _user.pinNumber = value;
                        }),
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Padding(
                          //padding: EdgeInsets.only(top: 25.0),
                          padding: EdgeInsets.only(
                            left: 15,
                            top: 25,
                            right: 15,
                            bottom: 0,
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xff12406f),
                                  Color(0xff698097),
                                ],
                              )),
                              child: PhysicalModel(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(25.0),
                                child: new MaterialButton(
                                  key: _globalKey,
                                  child: setUpButtonChild(),
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    this.submit(context);
                                  },
                                  minWidth: double.infinity,
                                  height: 55.0,
                                  color: Colors.transparent,
                                ),
                              )))
                    ],
                  ),
                ],
              ),
            ))));
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "LOGIN",
        style: const TextStyle(
          letterSpacing: 5,
          color: Colors.white,
          height: 2,
          fontSize: 18.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
      );
    } else {
      return Icon(Icons.check, color: Colors.lightGreen);
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });
  }
}
