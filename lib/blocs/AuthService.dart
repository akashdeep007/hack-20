import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:the_robin_app/blocs/DatabaseService.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? user : null;
  }

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return (_userFromFirebaseUser(user));
    } catch (e) {
      PlatformException error = e;
      return (error.message.toString());
    }
  }

  Future registerWithEmailAndPassword(
      String name, String email, String phone, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUser(name, email, phone);
      return (_userFromFirebaseUser(user));
    } catch (e) {
      PlatformException error = e;
      return (error.message.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
