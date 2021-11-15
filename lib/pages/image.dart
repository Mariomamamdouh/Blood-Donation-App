import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../result3.dart';
import 'EditAge.dart';
import 'EditAnswer.dart';
import 'EditEmailScreen.dart';
import 'EditLocation.dart';
import 'EditName.dart';
import 'EditPhone.dart';
import 'Profile.dart';
import 'Result2.dart';
import 'drawer.dart';
import 'test.dart';

class Imagee extends StatefulWidget {
  @override
  ImageeState createState() => ImageeState();
}

class ImageeState extends State<Imagee> {
  var backG = Color.fromRGBO(229, 33, 33, 1);
  String name,
      phone,
      age,
      email,
      addressline,
      country,
      subadmin,
      img,
      adminarea,
      password,
      bloodType,
      type,
      tit,
      tit1;
  var builder = Color.fromRGBO(191, 86, 86, 1);
  Color g2 = Color.fromRGBO(93, 96, 99, 1);
  Color g3 = Color.fromRGBO(86, 82, 82, 1);
  Color g4 = Color.fromRGBO(64, 61, 61, 1);
  Color w = Colors.white;
  var r = Color.fromRGBO(218, 19, 19, 1);
  String O = 'O', minus = '-', plus = '+';
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
              child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  //child: Text("Test",style: TextStyle(color:Color.fromRGBO(0, 200, 23, 1)),),
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    //   if(counter3!=0){
                    // null;
                    //  }else{

                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .get()
                        .then((snapshot) {
                      if (snapshot.data()['flag'] == '0') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Test()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestEdit2()));
                      }
                    });

                    //}
                  }
                  // if(counter2!=0){
                  // null,
                  //  }
                  //() {
                  // else {
                  //   Navigator.push(
                  //         context, MaterialPageRoute(builder: (context) => Test()));
                  //         if (counter==2){
                  //            Navigator.push(
                  //         context, MaterialPageRoute(builder: (context) => TestEdit2()));
                  //         }

                  // }
                  // }
                  ),
              //profile.floatAction(),
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
          profile.userEmail(),
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
          // profile.userBloodType(),
          Row(
            children: [
              Icon(Icons.local_fire_department_rounded, color: Colors.red),
              SizedBox(width: 4),
              Text(
                'Blood Type :',
                style: TextStyle(
                    color: Color.fromRGBO(235, 125, 125, 1),
                    fontFamily: 'Arial',
                    fontSize: 20),
              ),
              SizedBox(width: 15),
              FutureBuilder(
                future: _showProfile(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          "$type ",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Arial',
                            color: builder,
                          ),
                        ),
                      ),
                      //SizedBox(width: 50,),
                      // IconButton(
                      //   icon: Icon(Icons.edit, color: Colors.black),
                      //   onPressed: () {
                      //     _bottomSheet(context);
                      //   },
                      // ),
                    ]),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          profile.userBloodDonationValidity(),
          // SizedBox(
          //   child: Divider(
          //     color: Colors.grey,
          //   ),
          // )
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

  _bottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Wrap(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: r,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: w,
                              size: 35,
                            ),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Imagee())),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                            child: Text(
                              'Chooes blood type',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Microsoft JhengHei',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    ListTile(
                      title: Text(
                        'A',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.normal,
                          color: g2,
                        ),
                      ),
                      onTap: () {
                        _bottomSheet2(context);
                        setState(() {
                          tit = 'A';
                        });
                      },
                      trailing: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: g3,
                          size: 60,
                        ),
                        onPressed: () => _bottomSheet2(context),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      title: Text(
                        'B',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.normal,
                          color: g2,
                        ),
                      ),
                      onTap: () {
                        _bottomSheet2(context);
                        setState(() {
                          tit = 'B';
                        });
                      },
                      trailing: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: g3,
                          size: 60,
                        ),
                        onPressed: () => _bottomSheet2(context),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      title: Text(
                        'AB',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.normal,
                          color: g2,
                        ),
                      ),
                      onTap: () {
                        _bottomSheet2(context);
                        setState(() {
                          tit = 'AB';
                        });
                      },
                      trailing: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: g3,
                          size: 60,
                        ),
                        onPressed: () => _bottomSheet2(context),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      title: Text(
                        'O',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.normal,
                          color: g2,
                        ),
                      ),
                      onTap: () {
                        _bottomSheet2(context);
                        setState(() {
                          tit = 'O';
                        });
                        _bottomSheet2(context);
                      },
                      trailing: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: g3,
                          size: 60,
                        ),
                        onPressed: () => _bottomSheet2(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  _bottomSheet2(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Container(
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: r,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: g4,
                          size: 40,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      //  SizedBox(
                      //height : 20,
                      //),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: Text(
                          'Chooes blood type',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Microsoft JhengHei',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 5,
                ),
                ListTile(
                  title: Text(
                    plus,
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.normal,
                      color: r,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      tit1 = '+';
                    });
                    update(tit, tit1);
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: Text(
                    minus,
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.normal,
                      color: r,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      tit1 = '-';
                    });
                    update(tit, tit1);
                  },
                ),
              ],
            ),
          );
        });
  }

  _showProfile() async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        type = value.data()['BloodType'];
      }).catchError((e) {
        print(e);
      });
  }

  void update(tit, tit1) async {
    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({
      'BloodType': tit + tit1,
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Imagee()));
  }
}
