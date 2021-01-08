import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerreservationapp/ReadReservation/reservation_list.dart';
import 'package:customerreservationapp/Services/database.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadReservation extends StatefulWidget {
  @override
  _ReadReservationState createState() => _ReadReservationState();
}

class _ReadReservationState extends State<ReadReservation> {

  String _date;
  bool _bol = true;
  List<String> items = ["From Oldest to Newest", "From Newest to Oldest"];


  //Function to show bottomSheets for fetching or sorting the Reservations
  void setBottomSheet(){
   showModalBottomSheet(context: context, builder: (context) {
     return Container(
       padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
       child: Column(
         children: [
           Text("Reservations strating from date:- ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
           SizedBox(height: 10),
           DateTimePicker(
             type: DateTimePickerType.date,
             dateMask: 'd MMM, yyyy',
             use24HourFormat: false,
             firstDate: DateTime(2000),
             lastDate: DateTime(2100),
             dateLabelText: 'Date',
             onChanged: (val) {
               setState(() {
                 _date = val;
                 Navigator.pop(context);
               });
             },
             validator: (val) => val.isEmpty ? "Select Date" : null,
           ),

           SizedBox(height: 40),

           Text("Sort from:- ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
           SizedBox(height: 10),
           DropdownButtonFormField(
             value: _bol ? items[1] : items[0],
             items: items.map((val) {
               return DropdownMenuItem(
                 value: val,
                 child: Text(val),
               );
             }).toList(),
             onChanged: (val){
               setState(() {
                 _bol = !_bol;
               });
               Navigator.pop(context);
             },
           ),
         ],
       ),
     );
   });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService(date : _date, bol: _bol).database,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
         title: Text("Reservations",
           style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 24)),
           centerTitle: true,
           actions: [
             IconButton(icon: Icon(Icons.filter_list),
                 onPressed: () => setBottomSheet()),
           ],
      ),

        body: ReservationList(),
      ),
    );
  }
}
