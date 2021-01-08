import 'package:customerreservationapp/Decoration/loaders.dart';
import 'package:customerreservationapp/Services/database.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ReservationList extends StatefulWidget {
  @override
  _ReservationListState createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {

  int count;
  final _formkey = GlobalKey<FormState>();
  String _fullnm, _email, _num, _date;


  @override
  Widget build(BuildContext context) {
    count = 0;

    //Function to show bottomSheets for updating data
    void showBottomSheet(String id){
      showModalBottomSheet(context: context, builder: (context) {
        return StreamBuilder<DocumentSnapshot>(
          stream: DatabaseService(did: id).data,
          builder: (context, snapshot) {

            if(snapshot.hasData){
              DocumentSnapshot userData = snapshot.data;

              return Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: userData["name"],
                          decoration: InputDecoration(
                              labelText: 'Full Name'
                          ),
                          onChanged: (val) => _fullnm = val,
                          validator: (val) => val.isEmpty ? "Enter Name" : null,
                        ),

                        SizedBox(height: 7.0),

                        TextFormField(
                          initialValue: userData["email"],
                          decoration: InputDecoration(
                              labelText: 'Email'
                          ),
                          onChanged: (val) => _email = val,
                          validator: (val) {
                            if(val.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
                              return null;
                            }
                            return "Enter valid email";
                          },
                        ),

                        SizedBox(height: 7.0),

                        TextFormField(
                          initialValue: userData["phone"],
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                              labelText: 'Phone Number'
                          ),
                          onChanged: (val) => _num = val,
                          validator: (val) {
                            if(val.length == 10 && int.parse(val[0]) >= 7 ){
                              return null;
                            }
                            return "Enter valid phone number";
                          },
                        ),

                        SizedBox(height: 7.0),

                        DateTimePicker(
                          type: DateTimePickerType.dateTimeSeparate,
                          dateMask: 'd MMM, yyyy',
                          use24HourFormat: false,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Date',
                          timeLabelText: 'Time',
                          onChanged: (val) => _date = val,
                        ),

                        SizedBox(height: 10.0),

                        RaisedButton(
                          color: Colors.redAccent,
                          child: Text("Update",style: TextStyle(color: Colors.white),),
                          onPressed: () async {
                            if(_formkey.currentState.validate()) {
                              await DatabaseService(did : id).insertOrUpdateData(
                                  _fullnm ?? userData["name"],
                                  _email ?? userData["email"],
                                  _num ?? userData["phone"],
                                  _date ?? userData["DateTime"]);
                              Navigator.pop(context);
                            }
                            }),
                      ],
                    ),
                  )
              );
            }
            else{
              return Form(
                  child: Text("Please Wait")
              );
            }
          }
        );
      });
    }

    //Function to handle the popUpMenuButton's onClick action
    void handleClick(String val) async {
      var value = val.split(" ");
      if(value[0] == "Edit"){
        showBottomSheet(value[1]);
      } else{
        await DatabaseService(did: value[1]).deleteReserve();
        Fluttertoast.showToast(msg: "${value[2]}'s Reservation deleted", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.blue, textColor: Colors.white);
      }
    }

    final data = Provider.of<QuerySnapshot>(context);

    //To get document count
    if (data != null && data.documents != null) {
      for (var doc in data.documents) {
        count++;
      }
    }

    return (data == null) ?

        //show loading if data is not yet ready
    Center(
      child: Loader(load: 1),
    )
        :

        //show default text if no data present
    (data.documents.isEmpty) ?
    Container(
        child: Center(
          child: Text("No Reservations",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2)),
        )
    )
        :

        //show data if present
    Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: Column(
      children: [
        Flexible(
          child: ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    child: ListTile(
                      title: Center(child: Text(data.documents[index]["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))),
                      subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 10),
                            Row(
                             children: [
                              Icon(Icons.email, size: 21),
                              SizedBox(width: 4),
                              Text(data.documents[index]["email"], style: TextStyle(fontSize: 14, color: Colors.black),),
                             ],
                            ),

                            SizedBox(height: 8),

                            Row(
                              children: [
                                Icon(Icons.phone, size: 21),
                                SizedBox(width: 4,),
                                Text(data.documents[index]["phone"], style: TextStyle(fontSize: 14, color: Colors.black),),
                              ],
                            ),

                            SizedBox(height: 8),

                            Row(
                              children: [
                                Icon(Icons.access_time, size: 21),
                                SizedBox(width: 4,),
                                Text(data.documents[index]["DateTime"], style: TextStyle(fontSize: 15, color: Colors.black),),
                              ],
                            ),
                    ]),
                      isThreeLine: true,
                      trailing: PopupMenuButton<String>(
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          return ['Edit', 'Delete'].map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice+" "+data.documents[index]["id"]+" "+data.documents[index]["name"],
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    ),
      );
  }
}
