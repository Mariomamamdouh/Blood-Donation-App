import 'dart:async';
import 'package:gpp1/models/approve.dart';
import "package:gpp1/models/getpost.dart";
import 'package:gpp1/models/getpost.dart';
import 'package:gpp1/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:gpp1/services/service.dart";

class PostAdmin extends StatefulWidget {
  PostAdminState createState() => PostAdminState();
}

class PostAdminState extends State<PostAdmin> {
  final _post = ApprovePost();
  var text = Color.fromRGBO(213, 209, 209, 1);
  var r = Color.fromRGBO(218, 19, 19, 1);
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var bar = Color.fromRGBO(255, 255, 255, 1);
  var userName = Color.fromRGBO(200, 125, 125, 1);
  var post = Color.fromRGBO(59, 45, 45, 1);
  var react = Color.fromRGBO(222, 24, 24, 1);
  var comment = Color.fromRGBO(213, 68, 68, 1);
  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> postList;
  final Query _collectionReference = Firestore.instance
      .collection("post")
      .where("appending", isEqualTo: "pending");

  @override
  void initState() {
    super.initState();
    _subscription = _collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        postList = datasnapshot.documents;
        print("Posts List ${postList.length}");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: 50.0,
        //   primary: true,
        //   title: Row(
        //     children: [
        //       SizedBox(width: 40),
        //       Row(
        //         children: [
        //           Text(
        //             'Posts\'s Requests',
        //             style: TextStyle(
        //               fontFamily: 'Comic Sans MS',
        //               fontWeight: FontWeight.bold,
        //               fontSize: 25,
        //               color: Colors.black,
        //               // fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        //   leading: IconButton(
        //     icon: Icon(
        //       Icons.arrow_back_ios_rounded,
        //       color: Colors.black,
        //       size: 23,
        //     ),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        //   actions: [
        //     IconButton(
        //         icon: Icon(Icons.logout,color: Colors.black),
        //         onPressed: () async {
        //           await FirebaseAuth.instance
        //               .signOut(); // دي هنا عشان ال يوزر يخرج وهيرجع علي اللوجين
        //           Navigator.pushReplacement(context,
        //               MaterialPageRoute(builder: (context) => LoginPage()));
        //         })
        //   ],
        //   backgroundColor: Colors.white,
        // ),
        body: Column(children: [
      Container(
          padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Row(children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color.fromRGBO(233, 101, 101, 1),
                size: 23,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Container(
                padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                child: Text('Posts\'s Requests',
                    style: TextStyle(
                      fontFamily: 'Comic Sans MS',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromRGBO(233, 101, 101, 1),
                      fontStyle: FontStyle.italic,
                    ))),
          ])),
      Flexible(
          child: postList != null
              ? Card(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  color: Color.fromRGBO(254, 199, 199, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                  child: ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: ((context, index) {
                        return Card(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            color: Colors.white,
                            //elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: Colors.black26,
                              ),
                            ),
                            child: Column(children: [
                              FlatButton(
                                onPressed: () async {},
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: ListTile(
                                  leading: Container(
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            postList[index].data()['img']),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    postList[index].data()['name'],
                                    style: TextStyle(
                                        fontSize: 20, color: userName),
                                  ),
                                ),
                              ),
                              Container(
                                  child: Column(children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(
                                          postList[index]
                                              .data()['postdescribtion'],
                                          style: TextStyle(
                                              fontSize: 25, color: post),
                                        ),
                                      ),
                                    ])),
                                Row(children: [
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 20, 20, 10),
                                      child: RaisedButton(
                                        onPressed: () async {
                                          Approve(
                                              postList[index].data()['postid']);
                                        },
                                        child: Text(
                                          "Approve",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  204, 143, 143, 1),
                                              fontSize: 18),
                                        ),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          side: BorderSide(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      )),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 20, 20, 10),
                                      child: RaisedButton(
                                        onPressed: () {
                                          Reject(
                                              postList[index].data()['postid']);
                                        },
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  204, 143, 143, 1),
                                              fontSize: 18),
                                        ),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          side: BorderSide(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      )),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 20, 0, 10),
                                      child: RaisedButton(
                                        onPressed: () async {
                                          approveall();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PostAdmin()));
                                        },
                                        child: Text(
                                          "Approve ALL",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  204, 143, 143, 1),
                                              fontSize: 18),
                                        ),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          side: BorderSide(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      )),
                                ]),
                              ]))
                            ]));
                      })))
              : Center(
                  child: CircularProgressIndicator(),
                ))
    ]));
  }

  void approveall() async {
    var collection = FirebaseFirestore.instance.collection('post');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      print(documentID);
      DocumentReference ref =
          FirebaseFirestore.instance.collection('post').doc(documentID);
      ref.update({
        'appending': "accept",
      });
    }
  }

  Approve(var post) {
    _post.Approve(
        post,
        PostApprove1(
          appending1: "accept",
        ));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostAdmin()));
  }

  Reject(var post) {
    _post.Approve(
        post,
        PostApprove1(
          appending1: "Reject",
        ));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostAdmin()));
  }

  void rejectall() async {
    var collection = FirebaseFirestore.instance.collection('post');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      print(documentID);
      DocumentReference ref =
          FirebaseFirestore.instance.collection('post').doc(documentID);
      ref.update({
        'appending': "Reject",
      });
    }
  }
}
