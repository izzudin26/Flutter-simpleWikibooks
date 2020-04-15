import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class Authservices {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print(result.user);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<FirebaseUser> registerUser(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print(user);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      GoogleSignInAuthentication auth = await account.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: auth.idToken, accessToken: auth.accessToken);
      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      print(user);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<FirebaseUser> getUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      print(user.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  void logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
