import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpp1/models/comment.dart';
import 'package:gpp1/models/likes.dart';
import 'package:gpp1/models/post.dart';
import 'package:gpp1/services/post.dart';

import 'home.dart';

String comm;
TextEditingController co = TextEditingController();

class Commentt extends StatefulWidget {
  static String id = 'Comment';
  @override
  _CommenttState createState() => _CommenttState();
}

class _CommenttState extends State<Commentt> {
  TextEditingController comment10 = TextEditingController();

  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> postList;
  DocumentSnapshot postid;
  final Query _collectionReference = FirebaseFirestore.instance
      .collection("post")
      .where("appending", isEqualTo: "accept");
  @override
  void initState() {
    super.initState();
    _subscription = _collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        postList = datasnapshot.docs;
        print("Posts List ${postList.length}");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  List<Postt> posts;
  List<LikeModel> likes;
  final _post = Post();
  final _like = Likes();
  String ss = "1";
  String comment11;
  final comments = Comment();
  final uid = FirebaseAuth.instance.currentUser.uid;
  final GlobalKey<FormState> _formKey = GlobalKey();
  MyHomePageState post = new MyHomePageState();
  var userName = Color.fromRGBO(200, 125, 125, 1);
  var postt = Color.fromRGBO(59, 45, 45, 1);
  var react = Color.fromRGBO(222, 24, 24, 1);
  var comment = Color.fromRGBO(213, 68, 68, 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 50.0,
            primary: true,
            title: Row(
              children: [
                SizedBox(width: 40),
                Row(
                  children: [
                    Icon(
                      Icons.sms,
                      color: Colors.white,
                    ),
                    Text(
                      'Comments',
                      style: TextStyle(
                        fontFamily: 'Comic Sans MS',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black87,
                size: 23,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.red,
          ),
          body: Column(children: [
            Flexible(
                child: postList != null
                    ? Container(
                        child: ListView.builder(
                          itemCount: postList.length,
                          itemBuilder: ((context, index) {
                            return Column(children: [
                              TextFormField(
                                controller: comment10,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.send_rounded,
                                      color: Colors.black54,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      comments.AddComment(
                                          postList[index].data()['postid'],
                                          CommentModel(
                                            comment: comment10.text,
                                            postid: postList[index]
                                                .data()['postid'],
                                            userEmail: FirebaseAuth
                                                .instance.currentUser.email,
                                            //    likeID:  FirebaseFirestore.instance.collection("likes").doc().id,
                                          ));
                                    },
                                  ),
                                  hintText: 'Write a Comment',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(199, 179, 179, 1),
                                    fontSize: 27,
                                  ),
                                ),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "this field is required";
                                  }

                                  return null;
                                },
                              ),
                            ]);
                          }),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ])
          // SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       Container(
          //         width: double.infinity,
          //         margin: EdgeInsets.all(8.0),
          //         child: Row(
          //           children: [
          //             new IconButton(
          //               icon: Icon(
          //                 Icons.thumbs_up_down_outlined,
          //                 color: Colors.black,
          //                 size: 27,
          //               ),
          //               onPressed: () {},
          //             ),
          //             new Text(
          //               "11",
          //               style: TextStyle(
          //                 fontSize: 20,
          //                 color: Color.fromRGBO(233, 38, 38, 1),
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             SizedBox(
          //               width: 290,
          //             ),
          //             Expanded(
          //                 child: IconButton(
          //               icon: Icon(Icons.arrow_forward_ios_rounded,
          //                   color: Colors.black),
          //               onPressed: () {
          //                 Navigator.of(context).pop();
          //               },
          //             ))
          //           ],
          //         ),
          //       ),
          //       new Container(
          //         child: Column(
          //           children: [
          //             new Row(
          //               children: [
          //                 // Padding(
          //                 //   padding: const EdgeInsets.all(8.0),
          //                 //   child: CircleAvatar(
          //                 //     radius: 25.0,
          //                 //     backgroundImage: AssetImage(
          //                 //       'images/phoo.jpg',
          //                 //     ),
          //                 //   ),
          //                 // ),
          //                 Container(
          //                   height: 65,
          //                   width: 270,
          //                   decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       borderRadius: BorderRadius.circular(30),
          //                       border: Border.all(
          //                         color: Colors.grey,
          //                         width: 1.5,
          //                       )),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: Column(
          //                       children: [
          //                         Align(
          //                           alignment: Alignment.topLeft,
          //                           child: new Text(
          //                             "Ali Ahmed",
          //                             style: TextStyle(
          //                               color: Color.fromRGBO(101, 95, 95, 1.0),
          //                               fontSize: 20,
          //                               fontFamily: 'Arial',
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                           ),
          //                         ),
          //                         SizedBox(
          //                           height: 3.5,
          //                         ),
          //                         Align(
          //                           alignment: Alignment.bottomLeft,
          //                           child: new Text(
          //                             " I can help you",
          //                             style: TextStyle(
          //                               color: Color.fromRGBO(167, 117, 117, 1.0),
          //                               fontSize: 15,
          //                               fontFamily: 'Comic Sans MS',
          //                               //fontWeight: FontWeight.bold,
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),

          //                   // ],
          //                   // ),
          //                 )
          //               ],
          //             ),
          //             SizedBox(
          //               height: 25,
          //             ),
          //             new Row(
          //               children: [
          //                 // Padding(
          //                 //   padding: const EdgeInsets.all(8.0),
          //                 //   child: CircleAvatar(
          //                 //     radius: 25.0,
          //                 //     backgroundImage: AssetImage(
          //                 //       'images/phoo.jpg',
          //                 //     ),
          //                 //   ),
          //                 // ),
          //                 Container(
          //                   height: 65,
          //                   width: 270,
          //                   decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       borderRadius: BorderRadius.circular(30),
          //                       border: Border.all(
          //                         color: Colors.grey,
          //                         width: 1.5,
          //                       )),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: Column(
          //                       children: [
          //                         Align(
          //                           alignment: Alignment.topLeft,
          //                           child: new Text(
          //                             "Mariam Mahmoud",
          //                             style: TextStyle(
          //                               color: Color.fromRGBO(101, 95, 95, 1.0),
          //                               fontSize: 20,
          //                               fontFamily: 'Arial',
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                           ),
          //                         ),
          //                         SizedBox(
          //                           height: 3.5,
          //                         ),
          //                         Align(
          //                           alignment: Alignment.bottomLeft,
          //                           child: new Text(
          //                             " I can help you too",
          //                             style: TextStyle(
          //                               color: Color.fromRGBO(167, 117, 117, 1.0),
          //                               fontSize: 15,
          //                               fontFamily: 'Comic Sans MS',
          //                               //fontWeight: FontWeight.bold,
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   // SizedBox(height: 5,),

          //                   // ],
          //                   // ),
          //                 )
          //               ],
          //             ),
          //             SizedBox(
          //               height: 25,
          //             ),
          //             new Row(
          //               children: [
          //                 // Padding(
          //                 //   padding: const EdgeInsets.all(8.0),
          //                 //   child: CircleAvatar(
          //                 //     radius: 25.0,
          //                 //     backgroundImage: AssetImage(
          //                 //       'images/phoo.jpg',
          //                 //     ),
          //                 //   ),
          //                 // ),
          //                 Container(
          //                   height: 65,
          //                   width: 270,
          //                   decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       borderRadius: BorderRadius.circular(30),
          //                       border: Border.all(
          //                         color: Colors.grey,
          //                         width: 1.5,
          //                       )),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: Column(
          //                       children: [
          //                         Align(
          //                           alignment: Alignment.topLeft,
          //                           child: Text(
          //                             "Malak Hussein",
          //                             style: TextStyle(
          //                               color: Color.fromRGBO(101, 95, 95, 1.0),
          //                               fontSize: 20,
          //                               fontFamily: 'Arial',
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                           ),
          //                         ),
          //                         SizedBox(
          //                           height: 3.5,
          //                         ),
          //                         Align(
          //                           alignment: Alignment.bottomLeft,
          //                           child: Text(
          //                             " I Have the same blood Type",
          //                             style: TextStyle(
          //                               color: Color.fromRGBO(167, 117, 117, 1.0),
          //                               fontSize: 15,
          //                               fontFamily: 'Comic Sans MS',
          //                               //fontWeight: FontWeight.bold,
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   // SizedBox(height: 5,),

          //                   // ],
          //                   // ),
          //                 )
          //               ],
          //             ),
          //             SizedBox(
          //               height: 25,
          //             ),
          //             SizedBox(
          //               height: 300,
          //             ),
          //             postList != null
          //         ? Container(
          //             child: ListView.builder(
          //               itemCount: postList.length,
          //               itemBuilder: ((context, index) {
          //            return Column(children: [
          //            Form(
          //               key: _formKey,
          //               child: Container(
          //                 padding: EdgeInsets.all(10),
          //                 child: TextFormField(
          //                   controller: co,
          //                   decoration: InputDecoration(
          //                     enabledBorder: OutlineInputBorder(
          //                         borderRadius: BorderRadius.circular(25),
          //                         borderSide: BorderSide(color: Colors.red),
          //                       ),
          //                       focusedBorder: OutlineInputBorder(
          //                         borderSide: BorderSide(
          //                           color: Colors.red,
          //                         ),
          //                         borderRadius: BorderRadius.circular(25),
          //                       ),
          //                       border: OutlineInputBorder(
          //                         borderSide: BorderSide(
          //                           color: Colors.red,
          //                         ),
          //                         borderRadius: BorderRadius.circular(25),
          //                       ),
          //                     hintText: 'Write a Comment',
          //                     filled: true,
          //                     fillColor: Colors.white,
          //                     hintStyle: TextStyle(
          //                       color: Color.fromRGBO(199, 179, 179, 1),
          //                       fontSize: 27,
          //                     ),
          //                     suffixIcon: IconButton(
          //                      icon: Icon(
          //                       Icons.send_rounded,
          //                       color: Colors.black54,
          //                       size: 25,
          //                       ),
          //                       onPressed: (){
          //                        comments.AddComment(
          //                         postList[index].data()['postid'],
          //                         CommentModel(
          //                           comment:
          //                               comment10.text,
          //                           postid:
          //                               postList[index].data()['postid'],
          //                           userEmail:
          //                               FirebaseAuth.instance.currentUser.email,
          //                           //    likeID:  FirebaseFirestore.instance.collection("likes").doc().id,
          //                         ));
          //                       },
          //                     ),
          //                   ),
          //                    validator: (val) {
          //                       if (val.isEmpty) {
          //                         return "this field is required";
          //                       }
          //                       return null;
          //                     },
          //                     // onSaved: (val) {
          //                     //   comm = val;
          //                     // },
          //                 ),
          //               ),
          //             )]);
          //               })))
          //               : Center(
          //             child: CircularProgressIndicator(),
          //           ),
          //             SizedBox(
          //               height: 20,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
