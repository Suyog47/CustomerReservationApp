import 'dart:async';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    //Placing timer to change screen after 4 seconds
    Timer(Duration(seconds: 4), () {
      if(!mounted) return;
      Navigator.pushReplacementNamed(context, "/wrapper");
    });

    return Scaffold(
      body: Container(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage("assets/customers-icon.jpg"),
                            height: 45,
                            width: 45,),
                          SizedBox(width: 10),
                          Text("Customer Reservation App", style: TextStyle(color: Colors.red, letterSpacing: 2, fontSize: 19, fontFamily: 'NerkoOne', fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                ),
              ],
            ),
          )
      ),
    );
  }
}

