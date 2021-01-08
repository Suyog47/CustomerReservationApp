import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {

  final CollectionReference collection = Firestore.instance.collection("reserved");

  dynamic did, date;
  bool bol = true;
  DatabaseService({this.did, this.date, this.bol});

  //Function to Insert or Update Reservations
  Future insertOrUpdateData(String name, String email, String phone, String dt) async {
      String code = "", id;

      if(did == null) {
        String randomString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvxyz";

        for (int i = 0; i < 15; i++) {
          int rd = new Random().nextInt(randomString.length - 1);
          code += randomString[rd].toString();
        }
        id = code;
      }else{
        id = did;
      }


    return await collection.document(id).setData({
      "id" : id,
      "name" : name,
      "phone" : phone,
      "email" : email,
      "DateTime" : dt,
    });
  }


  //Setting Stream to get reservation
  Stream<QuerySnapshot> get database {
    return (date == null) ?
    collection.orderBy("DateTime", descending: bol).snapshots() :
    collection.where("DateTime", isGreaterThanOrEqualTo: date).orderBy("DateTime", descending: bol).snapshots();
  }

  //Function to delete reservation
  Future deleteReserve() async {
    return await collection.document(did).delete();
  }

  //Setting Stream to get data of selected reservation
  Stream<DocumentSnapshot> get data{
  return collection.document(did).snapshots();
  }

}