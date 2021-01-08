import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //Setting Stream for auth change check
  Stream<FirebaseUser> get user{
    return _auth.onAuthStateChanged;
  }

  //Sign-in with email and password
  Future signIn(String email,  String pass) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return user;
    }
    catch(e) {
     print(e.toString());
     return null;
    }
  }

  //Sign out
   Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
   }
}