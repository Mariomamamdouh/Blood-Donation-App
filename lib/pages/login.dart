import 'package:gpp1/Admin/home.dart';
import 'package:gpp1/Dash.dart';
import 'package:gpp1/provider/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpp1/pages/home.dart';
import 'package:gpp1/pages/forget_password.dart';
import 'package:gpp1/pages/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'BackGraund.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  RegisterState verify = new RegisterState();
  User user;
  bool passordVisible = true;
  var w = Colors.white;
  var gr = Color.fromRGBO(230, 230, 230, 1);
  var b = Colors.black;
  var bl = Colors.blue;
  var r = Colors.red;
  var g = Colors.blueGrey;
  var str = "name";
  int state = 1;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email, _password;
  var loginKey = GlobalKey<ScaffoldState>();
  // getData(){
  //   final u=FirebaseAuth.instance.currentUser;
  //   setState(() {
  //     user=u;
  //   });
  // }
  // void initState(){
  //   getData();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.30;
    return Scaffold(
      key: loginKey,
      body: ListView(
          //like column but support scrolling
          children: <Widget>[
            ClipPath(
              // will draw the wave
              clipper: BezierClipper(state),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                color: Color(0xffe60000),
                height: height,
                child: Container(
                  padding: EdgeInsets.fromLTRB(50, 80, 50, 50),
                  child: Text(
                    "Welcome back!",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Arial",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Color(0xF5F5F5),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 12),
                    SizedBox(height: 70),
                    Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: gr,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: gr),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Email ",
                              hintStyle: TextStyle(
                                  fontSize: 20, color: Color(0xff808080)),
                            ),
                            style: TextStyle(color: b, fontSize: 21),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "this field is required";
                              } else if (!val.contains('@') ||
                                  !val.contains('.com') ||
                                  !val.contains('gmail')) {
                                return "invaled email";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(val)) {
                                return "Please Enter Invalid Email";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              _email = val;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: gr,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: gr),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Enter your Password",
                              hintStyle: TextStyle(
                                  fontSize: 20, color: Color(0xff808080)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xffe60000),
                                ),
                                onPressed: () {
                                  setState(() {
                                    passordVisible = !passordVisible;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(color: b, fontSize: 21),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: passordVisible,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "this field is required";
                              } else if (val.length <= 5) {
                                return "Password is too short";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              _password = val;
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          margin: EdgeInsets.fromLTRB(195, 0, 0, 0),
                          child:
                              //to make the text as a link use Inkwell
                              InkWell(
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                color: Color(0xffCC6E6E),
                                fontSize: 20,
                                fontFamily: "Arial",
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword()));
                            }, //put the next page which appear when click on link
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              login();
                            },
                            child: Text("Login",
                                style: TextStyle(fontSize: 35, color: w)),
                            color: Color(0xffe60000),
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 45),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          // margin: EdgeInsets.fromLTRB(195, 0, 0, 0),
                          child: Text(
                            "Or",
                            style: TextStyle(
                              color: Color(0xff2A2222),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                            // margin: EdgeInsets.fromLTRB(195, 0, 0, 0),
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Color(0xff2A2222),
                                fontSize: 20,
                              ),
                            ),
                            InkWell(
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                  color: Color(0xffE17373),
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                            ),
                          ],
                        )),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Future<void> login() async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      print(_email);
      try {
        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user.uid)
            .get()
            .then((snapshot) {
          if (snapshot.data()['role'] == 'Admin') {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Dash()),
                (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (Route<dynamic> route) => false);
          }
        });
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
  }

  showDialogFun(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
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
                      padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
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
          );
        });
  }
}
