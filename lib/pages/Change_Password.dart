import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'drawer.dart';

class Change extends StatefulWidget {
  //static String id = 'changePassword';
  @override
  _ChangeState createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  FirebaseAuth instance = FirebaseAuth.instance;

  bool passordVisible = true;
  bool CheckCurrentUserValid = true;
  String _password, _new, _confirm, _oldpassword;
  String Userid = "";
  var user = FirebaseAuth.instance.currentUser;
  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController _confirmcontroller = TextEditingController();
  TextEditingController newcontroller = TextEditingController();
  String _img;
  Widget imageProfile() {
    return FutureBuilder(
      future: _showProfile(),
      builder: (context, snapshot) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 190.0,
                width: 190.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (_img != null)
                          ? NetworkImage(_img)
                          : NetworkImage(
                          'https://www.materialui.co/materialIcons/image/add_a_photo_black_36x36.png'),
                      //NetworkImage(_img),
                    ),
                    border: Border.all(color:Color.fromRGBO(213, 209, 209, 1), width: 6.0)),
              ),
            ]);
      },
    );
  }

  _showProfile() async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        _img = value.data()['imageurl'];
      }).catchError((e) {
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red,
        ),
       // drawer: DrawerScreen(),
        key: _scaffoldkey,
      drawer:Drawer(
        child: DrawerScreen(),
      ),
        body: Form(
          key: _formkey,
          child: ListView(
            children: [
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(
                      color: Color.fromRGBO(249, 24, 24, 1),
                      //color : Color(0xFF),
                      fontSize: 40,
                      fontFamily: 'Comic Sans MS',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              imageProfile(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          //color: Color(0xFF),
                        ),
                        borderRadius: BorderRadius.circular(25)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(25)),
                    hintText: 'Current Password',
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(178, 157, 157, 1),
                      fontSize: 20,
                      // fontSize: 20,
                    ),
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
                      )),
                keyboardType: TextInputType.visiblePassword,
                obscureText: passordVisible,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please re-enter password';
                    }
                  },
              ),
                ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    controller: newcontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(25)),
                        hintText: 'New Password',
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(178, 157, 157, 1),
                          fontSize: 20,
                          //fontSize: 20,
                        ),
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
                        )),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: passordVisible,
                    onChanged: (value) {
                      setState(() {
                        this._new = value;
                      });
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please re-enter password';
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _confirmcontroller,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      hintText: 'Confirm Password',
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(178, 157, 157, 1),
                        fontSize: 20,
                      ),
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
                      )),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: passordVisible,
                    onChanged: (value) {
                      setState(() {
                        this._confirm = value;
                      });
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please re-enter password';
                      }
                      print(newcontroller.text);

                      print(_confirmcontroller.text);

                      if (newcontroller.text != _confirmcontroller.text) {
                        return "Password does not match";
                      }
                    }
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () async{
                    if (_formkey.currentState.validate()) {
                      final user =
                          await FirebaseAuth.instance.currentUser;
                      user.updatePassword(newcontroller.text).then((_) {
                        print("sucess");
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text('Password Change successful'),
    ));
                      }).catchError((err) {
                        print("Password can't be changed");
                      });
                    }
                  },
                  child: Text("Change",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color.fromRGBO(255, 255, 255, 1))),
                  color: Color.fromRGBO(229, 33, 33, 1),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 80),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
    );
  }
}
