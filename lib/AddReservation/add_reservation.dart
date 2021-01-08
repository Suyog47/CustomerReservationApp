import 'package:customerreservationapp/Decoration/loaders.dart';
import 'package:customerreservationapp/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sweetalert/sweetalert.dart';


class AddReserve extends StatefulWidget {
  @override
  _AddReserveState createState() => _AddReserveState();
}

class _AddReserveState extends State<AddReserve> {
  final _formkey = GlobalKey<FormState>();
  String _fullnm, _email, _num, _date = DateTime.now().toString().split(".")[0];
  int ld = 0;
  var txt = TextEditingController();

  final nameField = TextEditingController();
  final emailField = TextEditingController();
  final phoneField = TextEditingController();

  void clearText() {
    nameField.clear(); emailField.clear(); phoneField.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            resizeToAvoidBottomPadding: false,
           appBar: AppBar(
             title: Text("Add Reservations",
                 style: TextStyle(fontFamily: 'BigShoulders', letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 22)),
             centerTitle: true,
           ),

            body: SafeArea(
              child: Stack(
                  children : [
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      child: Column(
                        children: [
                          Flexible(
                            child: Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        labelStyle: TextStyle(color: Colors.black),
                                    ),
                                    onChanged: (val) => _fullnm = val.trim(),
                                    validator: (val) => val.isEmpty ? "Enter full name" : null,
                                    textCapitalization: TextCapitalization.words,
                                    controller: nameField,
                                  ),


                                  TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Email Id',
                                          labelStyle: TextStyle(color: Colors.black),
                                      ),
                                      onChanged: (val) => _email = val.trim(),
                                      validator: (val) {
                                        if(val.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
                                          return null;
                                        }
                                        return "Enter valid email";
                                      },
                                    controller: emailField,
                                  ),

                                  TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Phone Number',
                                          labelStyle: TextStyle(color: Colors.black),
                                      ),
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      onChanged: (val) => _num = val.trim(),
                                      validator: (val) {
                                        if(val.length == 10 && int.parse(val[0]) >= 7 ){
                                          return null;
                                        }
                                        return "Enter valid phone number";
                                      },
                                    controller: phoneField,
                                  ),

                                  DateTimePicker(
                                    initialValue: _date,
                                    type: DateTimePickerType.dateTimeSeparate,
                                    dateMask: 'd MMM, yyyy',
                                    use24HourFormat: false,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    dateLabelText: 'Date',
                                    timeLabelText: 'Time',
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (val) => _date = val,
                                    validator: (val) => null,
                                  ),

                                  SizedBox(
                                    height: 55,
                                    width: 500,
                                    child: RaisedButton(
                                      color: Colors.green,
                                      child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 18)),
                                      onPressed: () async {
                                        if(_formkey.currentState.validate()) {
                                          setState(() => ld = 1);
                                           await DatabaseService().insertOrUpdateData(_fullnm, _email, _num, _date);
                                          setState(() => ld = 0);
                                          SweetAlert.show(context, title: "Success",
                                              subtitle: "Reservation Created",
                                              style: SweetAlertStyle.success,
                                              onPress: (bool isConfirm){
                                                return true;
                                              });
                                             clearText();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Loader(load: ld),
                    ),
                  ]
              ),
            )
        );
  }
}
