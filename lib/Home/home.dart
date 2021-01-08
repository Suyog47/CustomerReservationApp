import 'package:customerreservationapp/Services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home",
            style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 22)),
            centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.power_settings_new, color: Colors.red,),
              onPressed: () async {
               _auth.signOut();
              }),
        ],
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),

        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  border: Border.all(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, "/addReserve");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [ Colors.blue, Colors.red]
                              )
                          ),
                          child: Text("Add Reservation",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 22)),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueAccent, width: 2.0),
                ),

                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                         Navigator.pushNamed(context, "/readReserve");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [ Colors.yellow, Colors.red]
                              )
                          ),
                          child: Text("Read Reservations",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 22)),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]
        ),

      ),
    );
  }
}
