import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gpp1/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gpp1/pages/registration.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var Register = new RegisterState();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  var g = Color.fromRGBO(211, 211, 211, 1);
  var r = Color.fromRGBO(218, 19, 19, 1);
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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Edit Profile'),
      ),
      key: _scaffoldkey,
      body: Container(
        height: double.infinity,
        //margin: EdgeInsets.fromLTRB(30, 230, 30, 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.red,
                height: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 100)),
                    imageProfile(),

                    // FutureBuilder(
                    //   future: _showProfile(),
                    //   builder: (context, snapshot) {
                    //     return Text(
                    //       "$_name ",
                    //       style: TextStyle(
                    //         color: Color.fromRGBO(255, 255, 255, 1),
                    //         fontFamily: 'Arial',
                    //         fontSize: 25,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: Colors.red,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 28.0,
                      ),
                      onPressed: () async {
                        final user = await FirebaseAuth.instance.currentUser;
                        print(await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid));
                      }),
                  FutureBuilder(
                    future: _showProfile(),
                    builder: (context, snapshot) {
                      return Text(
                        " Email : $_email",
                        style: TextStyle(fontSize: 25),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone_android_outlined,
                    size: 20,
                    color: Colors.red,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 28.0,
                      ),
                      onPressed: () async {
                        final user = await FirebaseAuth.instance.currentUser;
                        print(await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid));
                      }),
                  FutureBuilder(
                    future: _showProfile(),
                    builder: (context, snapshot) {
                      return Text(
                        " Phone : $_phone ",
                        style: TextStyle(fontSize: 25),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: Colors.red,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 28.0,
                    ),
                    onPressed: () {
                      // final user =await FirebaseAuth.instance.currentUser;
                      // print(await FirebaseFirestore.instance.collection('users').doc(user.uid));
                    },
                  ),
                  FutureBuilder(
                    future: _showProfile(),
                    builder: (context, snapshot) {
                      return Text(
                        "AdminArea : $_adminarea \n Country : $_country \n addressline: $_addressline \n subadminarea : $_subadmin  ",
                        style: TextStyle(fontSize: 25),
                      );
                      style:
                      TextStyle(
                        fontSize: 25,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Colors.red,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 28.0,
                      ),
                      onPressed: () {
                        //   final user =await FirebaseAuth.instance.currentUser;
                        //   final id=await FirebaseFirestore.instance.collection('users').doc(user.uid);
                        // print(id);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Update()));
                      }),
                  FutureBuilder(
                    future: _showProfile(),
                    builder: (context, snapshot) {
                      return Text(
                        " Age : $_age ",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      );
                    },
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     showModalBottomSheet(
                  //       context:context,
                  //       builder:((builder) => textFiled()),
                  //     );
                  //   },
                  //   child: Icon(
                  //     Icons.edit,
                  //     color:Colors.black,
                  //     size: 28.0,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Colors.red,
                  ),
                  FutureBuilder(
                    future: _showProfile(),
                    builder: (context, snapshot) {
                      return Text(
                        " Blood Type : ",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Colors.red,
                  ),
                  FutureBuilder(
                    future: _showProfile(),
                    builder: (context, snapshot) {
                      return Text(
                        " Blood Donation Validity : ",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFiled() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                fillColor: g,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: g),
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              child: RaisedButton(
                child: Column(
                  children: [
                    Text(
                      "Edit",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                onPressed: () async {},
                color: r,
                padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return FutureBuilder(
      future: _showProfile(),
      builder: (context, snapshot) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // _showProfile(),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: new SizedBox(
                      width: 200.0,
                      height: 200.0,
                      child: (_img != null)
                          ? Image.network(_img)
                          : Image.network(
                              'https://www.materialui.co/materialIcons/image/add_a_photo_black_36x36.png'),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20.0,
                right: 5.0,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 28.0,
                  ),
                ),
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
