import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AuthStatus { unAuthenticated, authentecating, authenticated }

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  AuthStatus _authStatus = AuthStatus.unAuthenticated;
  String errorMessage;

Future <String> getCurrentUid() async{
  return (await _auth.currentUser).uid;
}
Future getCurrent() async{
  return await _auth.currentUser ;
}
  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        _authStatus = AuthStatus.unAuthenticated;
      } else {
        _user = user;
      }
      notifyListeners();
    });
  }
  AuthStatus get authStatus => _authStatus;
  User get user => _user;

  // Future<bool> register(String email, String password) async {
  //   try {
  //     UserCredential credential = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       //shwo snackbar
  //       errorMessage = "Weak Password";
  //     } else if (e.code == 'email-already-in-use') {
  //       //shwo snackbar
  //       errorMessage = "Email Is Found";
  //     } else if (e.code == 'invalid-email') {
  //       //shwo snackbar
  //       errorMessage = "Invalid Email";
  //     }
  //     return false;
  //   }
  // }

  Future<bool> login(String email, String password) async {
    try {
      _authStatus = AuthStatus.authentecating;
      notifyListeners();
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //shwo snackbar
        errorMessage = "User Not Found";
      } else if (e.code == 'wrong-password') {
        //shwo snackbar
        errorMessage = "Your Password Is Wrong";
      } else if (e.code == 'invalid-email') {
        //shwo snackbar
        errorMessage = "Invalid Email";
      } else if (e.code == 'user-disabled') {
        //shwo snackbar
        errorMessage = "User Disabled";
      }
      _authStatus = AuthStatus.authentecating;
      notifyListeners();
      return false;
    } catch (e) {
      print(e.code);
    }
  }
  //  Future userInfo() async{
  //    List itemList = [];
  //    try{
  //      await FirebaseFirestore.instance.collection('users').get().then((querySnapshot) 
  //      {
  //       querySnapshot.docs.forEach((element) {
  //         itemList.add(element.data);
  //       });
  //      });
  //      return itemList;
  //    }catch(e){
  //      print(e.code);
  //      return null;
  //    }
  //  }
  logout() async {
    await _auth.signOut();
    _authStatus = AuthStatus.unAuthenticated;
    notifyListeners();
  }
}
