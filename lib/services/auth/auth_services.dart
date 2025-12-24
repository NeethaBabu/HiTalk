import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserCredential> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      throw e;
    }
  }

  Future<UserCredential> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      //createUser
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //save user info in a seperate doc
      _firestore.collection("User").doc(userCredential.user!.uid).set({
        "email": email,
        "uid": userCredential.user!.uid,
      });

      return userCredential;
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }
}
