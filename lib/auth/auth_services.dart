import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailPassword(String email, String password)async{
    try{
      UserCredential userCredential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }catch(e){
      throw e;
    }
  }
Future<UserCredential> signUpWithEmailPassword(String email, String password)async{
    try{
      UserCredential userCredential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }catch(e){
      throw e;
    }
  }

  Future<void>signOut()async{
    return _auth.signOut();
  }
}