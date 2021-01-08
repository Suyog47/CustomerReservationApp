import 'dart:io';
import 'package:customerreservationapp/Decoration/loaders.dart';
import 'package:customerreservationapp/Services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  String _email;
  String _pass;
  bool _obscureText = true;
  int ld = 0;
  AuthService _auth = AuthService();

  //Change boolean value to Switch between obscureText and visibleText
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //To Exit Application
        exit(0);
        return Future.value(false);
      },

      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [ Colors.lightGreen, Colors.blue ]
                    )
                ),
                padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 55.0,
                            letterSpacing: 3,
                            fontStyle: FontStyle.italic
                        ),),

                      SizedBox(height: 40.0),

                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Email Id:",
                                  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                onChanged: (val) => _email = val.trim(),
                                validator: (val) {
                                  if(val.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
                                    return null;
                                  }
                                  return "Enter valid email";
                                }
                            ),

                            SizedBox(height: 25.0),

                            Stack(
                              children: <Widget>[
                                SizedBox(
                                  height: 70.0,
                                  child: new TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Password:",
                                      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    validator: (val) => val.length < 6 || val.length > 20 ? 'Password should be between 6 to 20 chars.' : null,
                                    onChanged: (val) => _pass = val,
                                    obscureText: _obscureText,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      color: Colors.black,
                                      onPressed: _toggle,
                                      icon: Icon(_obscureText ? Icons.lock_open : Icons.lock)),
                                )
                              ],
                            ),

                            SizedBox(height: 30.0),

                            SizedBox(
                              height: 45,
                              width: 500,
                              child: RaisedButton(
                                  color: Colors.redAccent,
                                  child: Text("Log In", style: TextStyle(color: Colors.white, fontSize: 18)),
                                  onPressed: () async {
                                    if (_formkey.currentState.validate()) {
                                      setState(() => ld = 1);
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      dynamic res = await _auth.signIn(_email, _pass);
                                      if(res == null){
                                        setState(() => ld = 0);
                                        SweetAlert.show(context, title: "Oops",
                                            subtitle: "Wrong Email and Password!!!",
                                            style: SweetAlertStyle.error);
                                      }
                                    }
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Loader(load: ld),
              ),
            ]
        ),
      ),
    );
  }
}
