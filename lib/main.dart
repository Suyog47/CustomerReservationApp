import 'package:customerreservationapp/AddReservation/add_reservation.dart';
import 'package:customerreservationapp/Home/home.dart';
import 'package:customerreservationapp/ReadReservation/read_all_reservation.dart';
import 'package:customerreservationapp/Services/auth.dart';
import 'package:customerreservationapp/splash_screen.dart';
import 'package:customerreservationapp/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Authentication/login.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Allow Portrait screen mode only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: "/splash",
          routes: {
          "/splash" : (context) => SplashScreen(),
          "/wrapper" : (context) => Wrapper(),
          "/login" : (context) => Login(),
          "/home" : (context) => Home(),
          "/addReserve": (context) => AddReserve(),
          "/readReserve" :(context) => ReadReservation(),
      },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}



