import 'package:flutter/material.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gpp1/pages/registration.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'drawer.dart';

class imgprofile extends StatefulWidget {
  _imgprofileState createState() => _imgprofileState();
}

class _imgprofileState extends State<imgprofile> {
  var Register = new RegisterState();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  var g = Color.fromRGBO(211, 211, 211, 1);
  var r = Color.fromRGBO(218, 19, 19, 1);
  var text = Color.fromRGBO(235, 125, 125, 1);
  var builder = Color.fromRGBO(191, 86, 86, 1);
  Position _currentPosition;
  String _currentAddress;
  String _name,
      _phone,
      _age,
      _email,
      _addressline,
      _country,
      _subadmin,
      _img,
      _adminarea,
      _password;
  var lat, long;
  PickedFile _imageFile;
  File _fileImage;
  final ImagePicker _picker = ImagePicker();
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
                    border: Border.all(color: Colors.white, width: 6.0)),
              ),
            ]);
      },
    );
  }

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
    _scaffoldkey.currentState
        .showSnackBar(SnackBar(content: Text('Your Picture Updated')));
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

  Widget bottomSheet() {
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
  }

  Widget build(BuildContext cx) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          FloatingActionButton(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Color.fromRGBO(229, 33, 33, 1),
                size: 30.0,
              ),
              // alignment:  Alignment.topRight,
              onPressed: () {},
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
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
                            color: Color.fromRGBO(229, 33, 33, 1),
                            height: 250,
                            width: double.infinity,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.,
                              children: [
                                Row(children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          150, 0, 100, 100)),
                                  FutureBuilder(
                                    future: _showProfile(),
                                    builder: (context, snapshot) {
                                      return Text(
                                        "$_name ",
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontFamily: 'Arial',
                                          fontSize: 25,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 5.0),
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 22.0,
                                    ),
                                    onPressed: () {},
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 100, 0)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          imageProfile(),
                        ]),

                    // Positioned(
                    //   top: 150.0,
                    //   child: Container(
                    //     height: 190.0,
                    //     width: 190.0,
                    //     decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         image: DecorationImage(
                    //           fit: BoxFit.cover,
                    //           image: (_img != null)
                    //               ? NetworkImage(_img)
                    //               : NetworkImage(
                    //                   'https://www.materialui.co/materialIcons/image/add_a_photo_black_36x36.png'),
                    //           //NetworkImage(_img),
                    //         ),
                    //         border:
                    //             Border.all(color: Colors.white, width: 6.0)),
                    //   ),
                    // ),
                    //SizedBox(height: 100,),
                    // Positioned(
                    //   //bottom: 10.0,
                    //   //top: 10,
                    //   right: 100.0,
                    //   child: InkWell(
                    //     onTap: () {
                    //       showModalBottomSheet(
                    //         context: context,
                    //         builder: ((builder) => bottomSheet()),
                    //       );
                    //     },
                    //     child: Icon(
                    //       Icons.camera_alt,
                    //       color: Colors.black,
                    //       size: 28.0,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Icon(Icons.email, color: Colors.red),
              SizedBox(width: 4),
              Text(
                "Email :",
                style:
                    TextStyle(fontSize: 20, fontFamily: 'Arial', color: text),
              ),
              SizedBox(
                width: 40,
              ),
              FutureBuilder(
                future: _showProfile(),
                builder: (context, snapshot) {
                  return Text(
                    " $_email",
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Arial', color: builder),
                  );
                },
              ),
              SizedBox(width: 50),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.black),
                onPressed: () {},
              ),
              //IconButton(icon: Icon(Icons.edit, color: Colors.grey,), onPressed: () {  },),
            ],
          ),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.red),
              SizedBox(width: 4),
              Text(
                'Phone :',
                style:
                    TextStyle(color: text, fontFamily: 'Arial', fontSize: 20),
              ),
              SizedBox(width: 50),
              FutureBuilder(
                future: _showProfile(),
                builder: (context, snapshot) {
                  return Text(
                    " $_phone ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      color: builder,
                    ),
                  );
                },
              ),
              SizedBox(width: 80),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.red),
              SizedBox(width: 4),
              Text(
                'Location :',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                  color: text,
                ),
              ),
              SizedBox(width: 40),
              FutureBuilder(
                future: _showProfile(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: Text(
                      '$_addressline ',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Arial',
                        color: builder,
                      ),
                    ),
                  );
                  // );
                },
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.black),
                onPressed: () {},
              ),
              //Icon(Icons.edit, color: Colors.grey),
            ],
          ),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.perm_contact_calendar, color: Colors.red),
              SizedBox(width: 4),
              Text(
                'Age :',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                  color: text,
                ),
              ),
              SizedBox(width: 130),
              FutureBuilder(
                future: _showProfile(),
                builder: (context, snapshot) {
                  return Text(
                    "$_age ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      color: builder,
                    ),
                  );
                },
              ),
              SizedBox(width: 130),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.black),
                onPressed: () {},
              ),
              // Icon(Icons.edit, color: Colors.grey),
            ],
          ),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.local_fire_department_rounded, color: Colors.red),
              SizedBox(width: 4),
              Text(
                'Blood Type :',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                  color: text,
                ),
              ),
              SizedBox(width: 70),
              FutureBuilder(
                future: _showProfile(),
                builder: (context, snapshot) {
                  return Text(
                    "  ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      color: builder,
                    ),
                  );
                },
              ),
              SizedBox(width: 150),
              Icon(Icons.edit, color: Colors.black),
            ],
          ),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.event_note, color: Colors.red),
              SizedBox(width: 4),
              Text(
                'Blood Donation Validity :',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                  color: text,
                ),
              ),
              SizedBox(width: 10),
              FutureBuilder(
                future: _showProfile(),
                builder: (context, snapshot) {
                  return Text(
                    " ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      color: builder,
                    ),
                  );
                },
              ),
              SizedBox(width: 100),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.black),
                onPressed: () {},
              ),
              //Icon(Icons.edit, color: Colors.grey),
            ],
          ),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Widget imageProfile() {
  //   return FutureBuilder(
  //     future: _showProfile(),
  //     builder: (context, snapshot) {
  //       return Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Positioned(
  //               top: 100.0,
  //               child: Container(
  //                 height: 190.0,
  //                 width: 190.0,
  //                 decoration: BoxDecoration(
  //                     shape: BoxShape.circle,
  //                     image: DecorationImage(
  //                       fit: BoxFit.cover,
  //                       image: (_img != null)
  //                           ? NetworkImage(_img)
  //                           : NetworkImage(
  //                               'https://www.materialui.co/materialIcons/image/add_a_photo_black_36x36.png'),
  //                       //NetworkImage(_img),
  //                     ),
  //                     border: Border.all(color: Colors.white, width: 6.0)),
  //               ),
  //             ),
  //             Positioned(
  //               bottom: 20.0,
  //               right: 5.0,
  //               child: InkWell(
  //                 onTap: () {
  //                   showModalBottomSheet(
  //                     context: context,
  //                     builder: ((builder) => bottomSheet()),
  //                   );
  //                 },
  //                 child: Icon(
  //                   Icons.camera_alt,
  //                   color: Colors.black,
  //                   size: 28.0,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //           ]);
  //     },
  //   );
  // }
  // Widget imageProfile() {
  //   return FutureBuilder(
  //       future: _showProfile(),
  //       builder: (context, snapshot) {
  //         return Positioned(
  //           bottom: 50.0,
  //           left: 120.0,
  //           child: Container(
  //             width: 160.0,
  //             height: 160.0,
  //             decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 image: DecorationImage(
  //                   fit: BoxFit.cover,
  //                   image: (_img != null)
  //                       ? NetworkImage(_img)
  //                       : NetworkImage(
  //                       'https://www.materialui.co/materialIcons/image/add_a_photo_black_36x36.png'),
  //                   //NetworkImage(_img),
  //                 ),
  //                 border: Border.all(color: text, width: 6.0)),
  //           ),
  //         );
  //       });
  // }
  _showProfile() async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        _name = value.data()['name'];
        _age = value.data()['age'];
        _phone = value.data()['phone'];
        _email = value.data()['email'];
        _password = value.data()['password'];
        _addressline = value.data()['addressline'];
        _country = value.data()['country'];
        _subadmin = value.data()['subadminarea'];
        _adminarea = value.data()['adminarea'];
        _img = value.data()['imageurl'];
      }).catchError((e) {
        print(e);
      });
  }
}
