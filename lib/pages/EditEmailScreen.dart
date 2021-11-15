import 'package:gpp1/pages/popupverifyemail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'EditAge.dart';
import 'EditEmailScreen.dart';
import 'EditLocation.dart';
import 'EditName.dart';
import 'EditPhone.dart';
import 'Profile.dart';
import 'drawer.dart';
import 'editLoc.dart';
import 'image.dart';

class EditEmail extends StatefulWidget {
  @override
  EditEmailState createState() => EditEmailState();
}

class EditEmailState extends State<EditEmail> {
  TextEditingController email = TextEditingController();
  var backG = Color.fromRGBO(229, 33, 33, 1);
  final GlobalKey<FormState> _formKey = GlobalKey();
  String name,
      phone,
      age,
      addressline,
      country,
      subadmin,
      img,
      adminarea,
      password,
      bloodType;
  var lat, long;
  PickedFile _imageFile;
  File _fileImage;
  final ImagePicker _picker = ImagePicker();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  ProfileWidgetState profile = new ProfileWidgetState();
  photo() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFile = pickedFile;
    });
    var file = File(_imageFile.path);

    final ref1 = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(_imageFile.path);
    await ref1.putFile(file);
    final url = await ref1.getDownloadURL();

    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({'imageurl': url});
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text('Your Picture Updated'),
    ));
  }

  insertimage() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = pickedFile;
    });
    var file = File(_imageFile.path);
    final ref1 = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(_imageFile.path);
    await ref1.putFile(file);
    final url = await ref1.getDownloadURL();
    final user = await FirebaseAuth.instance.currentUser;

    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({'imageurl': url});
    _scaffoldkey.currentState
        .showSnackBar(SnackBar(content: Text('Your Picture Updated')));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Color(0xffe60000),
          elevation: 0.0,
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: profile.floatAction(),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(60),
      ),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      key: _scaffoldkey,
      body: new ListView(
        children: <Widget>[
          new Column(
            children: <Widget>[
              Container(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 150.0,
                            color: backG,
                          ),
                        )
                      ],
                    ),
                    //floatAction(),
                    //userName(),
                    profile.userName(),
                    profile.userimageProfile(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(180, 30, 0, 0),
                child: Container(
                  width: 45,
                  height: 45,
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => bottomSheetImage(context),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: backG,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Icon(Icons.email, color: Colors.red),
              SizedBox(width: 4),
              Text(
                "Email :",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Arial',
                    color: Color.fromRGBO(235, 125, 125, 1)),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Container(
                    // width: 270,
                    //height: 80,
                    child: TextFormField(
                      controller: email,
                      // decoration: InputDecoration(
                      //   hintText: "Enter your Email",
                      //   hintStyle: TextStyle(
                      //     color: Color.fromRGBO(154, 141, 141, 1),
                      //     fontSize: 18,
                      //   ),
                      //   suffixIcon: IconButton(
                      //     icon: Icon(
                      //       Icons.add_box_outlined,
                      //       size: 30,
                      //       color: Colors.red,
                      //     ),
                      //     onPressed: () {
                      //       update();
                      //       //print("update");
                      //     },
                      //   ),
                      //   border: OutlineInputBorder(
                      //     borderSide: BorderSide(
                      //       color: Colors.red,
                      //     ),
                      //     borderRadius: BorderRadius.circular(15),

                      //   ),
                      // ),
                      decoration: InputDecoration(
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.black12),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintText: "Enter your Email",
                        hintStyle:
                            TextStyle(fontSize: 20, color: Color(0xff808080)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.add_box_outlined,
                            size: 30,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            update();
                            //print("update");
                          },
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Enter Your Email";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          profile.user_email = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 30),
            ],
          ),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          profile.userPhone(),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          profile.userLocation(),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          profile.userAge(),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          profile.userBloodType(),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          profile.userBloodDonationValidity(),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheetImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Choose Profile Photo",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(Icons.camera),
                      onPressed: () {
                        photo();
                        //Navigator.of(context).pop();
                      },
                      label: Text("Camera"),
                    ),
                    FlatButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        insertimage();
                      },
                      label: Text("Gallery"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void update() async {
    if (_formKey.currentState.validate()) {
      final user = await FirebaseAuth.instance.currentUser;
      user.verifyBeforeUpdateEmail(email.text).then((_) {
        print("sucess");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AdvanceCustomAlert();
            });
        //_scaffoldkey.currentState
        // .showSnackBar(SnackBar(content: Text("Please Verify Your Email")));
        // Navigator.push(
        //   context, MaterialPageRoute(builder: (context) => Verify()));
      }).catchError((err) {
        print("Email can't be changed");
      });
    }
  }
}
