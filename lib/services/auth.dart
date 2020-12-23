import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_trying/models/user.dart';
import 'package:firebase_auth_trying/services/database.dart';
import 'package:firebase_auth_trying/widgets/exception.dart';
import 'package:flutter/material.dart';

class AuthService {
  // property to get us firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // TODO: Create AnonUser object based on User
  AnonUser _userFromUser(User user) {
    return user != null ? AnonUser(uid: user.uid): null;
  }
  // TODO: Auth change user stream
  // Every time a user sign-in or out, we will get a response down the stream
  Stream<AnonUser> get user {
    return _auth.authStateChanges().map(_userFromUser);
    //.map((User user) => _userFromUser(user)); This is the same w/ the one above

  }
  // TODO: sign in anonymously
  Future signInAnon(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;

      // create a new doc
      await DatabaseService(uid: user.uid).updateUserData('anonymous member', '', '');

      return _userFromUser(user);
    } catch(e) {
      showException(context, message: e.message);
      return null;
    }
  }

  // TODO: s.in w/ email and password
  Future signIn(BuildContext context, {String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch(e) {
      showException(context, message: e.message);
      return null;
    }
  }

  // TODO: s.up w/ email and password
  Future signUp(BuildContext context, {String email, String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      // create a new doc
      await DatabaseService(uid: user.uid).updateUserData('new member', email, password);

      return _userFromUser(user);
    } on FirebaseAuthException catch(e) {
      print('(error) -> (signUp) -> ${e.message}');
      showException(context, message: e.message);
      return null;
    }
  }
  // TODO: s.out
  Future signOut(BuildContext context) async {
    try {
      return await _auth.signOut(); // This is ready to use method built in Firebase
    } catch(e) {
      showException(context, message: e.message);
      return null;
    }
  }

  Future ForgotPassword(BuildContext context, {String email}) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e)  {
      showException(context, message: e.message);
      return null;
    }
  }

}

class ChangeViewProvider with ChangeNotifier {
  String _formState = "in";

  void changeView(String newFormState) {
    if(newFormState == "up") {
      _formState = "up";
    } else if(newFormState == "in") {
      _formState = "in";
    } else if(newFormState == "forgot") {
      _formState = "forgot";
    }
    notifyListeners();
  }
  String returnView() {
    return _formState;
  }
}