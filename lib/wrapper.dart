import 'package:customerreservationapp/Authentication/login.dart';
import 'package:customerreservationapp/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //get user auth data
    final user  = Provider.of<FirebaseUser>(context);

    if(user == null) {
      return Login();
    }
    else{
      return Home();
    }
  }
}
