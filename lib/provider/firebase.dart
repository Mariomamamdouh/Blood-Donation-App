import 'package:gpp1/pages/home.dart';
import 'package:gpp1/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Database extends StatefulWidget {
  DatabaseState createState() => DatabaseState();
}

class DatabaseState extends State<Database> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email, _password, _name, _phone, _location, _age;
  User user;
  var loginKey = GlobalKey<ScaffoldState>();
  var lat, long, country, adminarea, addressline, subadmin;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> login() async {
    // final formData= _formKey.currentState;
    // if(formData.validate()) {
    //   formData.save();
    //   print(_email);
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      if (user.emailVerified) {
        Navigator.of(context).pushAndRemoveUntil(
            // عشان لما يلوجن يشيل علامة الباك
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (Route<dynamic> route) => false);
      } else {
        showDialogFunLog(context);
        print("please");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //shwo snackbar
        loginKey.currentState.showSnackBar(SnackBar(
          content: Text("User Not Found"),
        ));
      } else if (e.code == 'wrong-password') {
        //shwo snackbar
        loginKey.currentState.showSnackBar(SnackBar(
          content: Text("Your Password Is Wrong"),
        ));
      } else if (e.code == 'invalid-email') {
        //shwo snackbar
        loginKey.currentState.showSnackBar(SnackBar(
          content: Text("Invalid Email"),
        ));
      } else if (e.code == 'user-disabled') {
        //shwo snackbar
        loginKey.currentState.showSnackBar(SnackBar(
          content: Text("User Disabled"),
        ));
      }
    } catch (e) {
      print(e.code);
    }
  }

  showDialogFunLog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Expanded(
              child: Container(
                height: 200,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Text(
                          "Please verify your email.",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(85, 0, 0, 0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text("OK",
                              style: TextStyle(
                                  fontSize: 35, color: Color(0xFFFFFFFF))),
                          color: Color(0xffe60000),
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 45),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<void> register() async {
    // final formData = _formKey.currentState;
    // if (formData.validate()) {
    //   formData.save();
    //print(_email);
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user.uid)
          .set({
        'email': this._email,
        'name': this._name,
        'age': this._age,
        'phone': this._phone,
        'long': long,
        'lat': lat,
        'adminarea': adminarea,
        'addressline': addressline,
        'subadminarea': subadmin,
        'country': country,
      });

      sendVerificationEmail();
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => SendCode()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        //shwo snackbar
        loginKey.currentState.showSnackBar(SnackBar(
          content: Text("Email Not Found"),
        ));
      } else if (e.code == 'weak-password') {
        //shwo snackbar
        loginKey.currentState.showSnackBar(SnackBar(
          content: Text("Your Password Is weak"),
        ));
      } else if (e.code == 'invalid-email') {
        //shwo snackbar
        loginKey.currentState.showSnackBar(SnackBar(
          content: Text("Invalid Email"),
        ));
      }
    } catch (e) {
      print(e.code);
    }
  }
  // void verificationEmail()async{
  //   EmailAuth.sessionName="Blood Donation";
  //   var ref=await EmailAuth.sendOtp(receiverMail: email);
  //   if(ref){
  //     print("code send");
  //   }else{
  //     print("code not send");
  //   }
  // }

  void sendVerificationEmail() async {
    user = await FirebaseAuth.instance.currentUser;
    await user.sendEmailVerification();
    showDialogFun(context);
  }

  showDialogFun(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Expanded(
              child: Container(
                height: 200,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Text(
                          "Email Verification link has sent to your email!\nPlease verify your email.",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(85, 0, 0, 0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text("OK",
                              style: TextStyle(
                                  fontSize: 35, color: Color(0xFFFFFFFF))),
                          color: Color(0xffe60000),
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 45),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
