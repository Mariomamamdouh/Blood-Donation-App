import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'Profile.dart';
import 'drawer.dart';
import 'home.dart';
import 'image.dart';

class EditPost extends StatefulWidget {
  @override
  EditPostState createState() => EditPostState();
}

class EditPostState extends State<EditPost> {
  MyHomePageState po=new MyHomePageState();
  String img, name;
  var text = Color.fromRGBO(213, 209, 209, 1);
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var bar = Color.fromRGBO(255, 255, 255, 1);
  var userName = Color.fromRGBO(200, 125, 125, 1);
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController post_descripition = TextEditingController();
  String contant;
  var lat, long;
  PickedFile _imageFile;
  File _fileImage;
  final ImagePicker _picker = ImagePicker();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  MyHomePageState post = new MyHomePageState();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: backG,
        title: Text(
          "Edit Post",
          style: TextStyle(fontSize: 30, fontFamily: 'Noto Serif', color: bar),
        ),
      ),
      key: _scaffoldkey,
      body: new ListView(
        children: <Widget>[
          Column(
            children: [
              Row(children: [
                Container(
                  padding: EdgeInsets.all(10),
                child:imageProfile(),
                ),
                FutureBuilder(
                  future: _showProfile(),
                  builder: (context, snapshot) {
                    return Text(
                      "$name ",
                      style: TextStyle(fontSize: 20, color: userName),
                    );
                  },
                ),
              ],),
                Form(
                  key: _formKey,
                  child:Column(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      controller: post_descripition,
                      maxLines: 27,
                      decoration: InputDecoration(
                        hintText: "Enter your Phone",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(154, 141, 141, 1),
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      // onChanged: (value) {
                      //   setState(() {
                      //     post.contant = value;
                      //   });
                      // },
                    ),
                  ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.fromLTRB(220, 0, 10, 0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          update();
                        },
                        child: Text("Save",
                            style: TextStyle(fontSize: 30, color: Colors.white)),
                        color: Color(0xffe60000),
                        padding: EdgeInsets.symmetric(
                            vertical: 7, horizontal: 45),
                      ),
                    ),
      ])
                ),
            ],
          ),
        ],
      ),
    );
  }
  Widget imageProfile() {
    return FutureBuilder(
      future: _showProfile(),
      builder: (context, snapshot) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (img != null)
                          ? NetworkImage(img)
                          : NetworkImage(
                          'https://i.pinimg.com/564x/04/28/f5/0428f5706e19f681febc5aa677d7e282.jpg'
                      ),
                      //NetworkImage(_img),
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
          .collection("users")
          .doc(user.uid)
          .get()
          .then((value) {
        name = value.data()['name'];
        img = value.data()['imageurl'];
      }).catchError((e) {
        print(e);
      });
  }
  void update() async {
    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
    FirebaseFirestore.instance.collection('posts').doc();
    ref.update({
      'post_description': post_descripition.text,
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
}
