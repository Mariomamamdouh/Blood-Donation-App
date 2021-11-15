import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'EditAge.dart';
import 'EditAnswer.dart';
import 'EditEmailScreen.dart';
import 'EditName.dart';
import 'EditPhone.dart';
import 'classtext.dart';
import 'editLoc.dart';
import 'image.dart';
import 'test.dart';

class ProfileWidget extends StatefulWidget {
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
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
      type;
  String tit, tit1;
  int counter = 0;
  var text = Color.fromRGBO(235, 125, 125, 1);
  var builder = Color.fromRGBO(191, 86, 86, 1);
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var g = Color.fromRGBO(211, 211, 211, 1);
  Color g2 = Color.fromRGBO(93, 96, 99, 1);
  Color g3 = Color.fromRGBO(86, 82, 82, 1);
  Color g4 = Color.fromRGBO(64, 61, 61, 1);
  Color w = Colors.white;
  var r = Color.fromRGBO(218, 19, 19, 1);
  String A = 'A';
  String B = 'B';
  String AB = 'AB';
  String O = 'O', minus = '-', plus = '+';
  dynamic user;
  String user_email;
  getCurrentUserInfo() async {
    user = await FirebaseAuth.instance.currentUser;
    user_email = user.email;
  }
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  Widget userName() {
    return FutureBuilder(
      future: _showProfile(),
      builder: (context, snapshot) {
        return Positioned(
          top: 0.0,
          left: 125.0,
          child: Row(children: [
            Center(
              child: Text(
                "$name ",
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Arial',
                  fontSize: 30,
                ),
              ),
            ),
            //SizedBox(width: 20,),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Color.fromRGBO(255, 255, 255, 1),
                size: 22.0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditName()));
              },
            ),
          ]),
        );
      },
    );
  }

  Widget floatAction() {
    return FlatButton(
          child: Text("Test",style: TextStyle(color:Color.fromRGBO(0, 200, 23, 1)),),
          onPressed: () {
            if (counter == 0) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Test()));
              counter++;
            }
            else {
               Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TestEdit2()));
            }
          });
    // Container(
    //   width: 40,
    //   height: 40,
    //   child: InkWell(
    //     onTap: () {},
    //     child: Icon(
    //       Icons.add,
    //       size: 25,
    //       color: Colors.red,
    //     ),
    //   ),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(50.0),
    //     color: Colors.white,
    //   ),
    // );
  }

  Widget userimageProfile() {
    return FutureBuilder(
        future: _showProfile(),
        builder: (context, snapshot) {
          return Positioned(
            top: 50.0,
            child: Container(
              height: 190.0,
              width: 190.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (img != null)
                        ? NetworkImage(img)
                        : NetworkImage(
                            'https://i.pinimg.com/564x/04/28/f5/0428f5706e19f681febc5aa677d7e282.jpg'),
                  ),
                  border: Border.all(
                      color: Color.fromRGBO(213, 209, 209, 1), width: 6.0)),
            ),
          );
        });
  }

  Widget userEmail() {
    return Row(
      children: [
        Icon(Icons.email_rounded, color: Colors.red),
        SizedBox(width: 4),
        Text(
          'Email :',
          style: TextStyle(
              color: Color.fromRGBO(235, 125, 125, 1),
              fontFamily: 'Arial',
              fontSize: 20),
        ),
        SizedBox(width: 35),
        FutureBuilder(
          future: getCurrentUserInfo(),
          builder: (context, snapshot) {
            return Expanded(
              child: Row(children: [
                Expanded(
                  child: Text(
                    "$user_email ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      color: builder,
                    ),
                  ),
                ),
                //SizedBox(width: 50,),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditEmail()));
                  },
                ),
              ]),
            );
          },
        ),
      ],
    );
  }

  Widget userPhone() {
    return Row(
      children: [
        Icon(Icons.phone, color: Colors.red),
        SizedBox(width: 4),
        Text(
          'Phone :',
          style: TextStyle(
              color: Color.fromRGBO(235, 125, 125, 1),
              fontFamily: 'Arial',
              fontSize: 20),
        ),
        SizedBox(width: 35),
        FutureBuilder(
          future: _showProfile(),
          builder: (context, snapshot) {
            return Expanded(
              child: Row(children: [
                Expanded(
                  child: Text(
                    "$phone ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      color: builder,
                    ),
                  ),
                ),
                //SizedBox(width: 50,),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditPhone()));
                  },
                ),
              ]),
            );
          },
        ),
      ],
    );
  }

  Widget userLocation() {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.red),
        SizedBox(width: 4),
        Text(
          'Location :',
          style: TextStyle(
              color: Color.fromRGBO(235, 125, 125, 1),
              fontFamily: 'Arial',
              fontSize: 20),
        ),
        SizedBox(width: 20),
        FutureBuilder(
          future: _showProfile(),
          builder: (context, snapshot) {
            return Expanded(
              child: Row(children: [
                Expanded(
                  child: Text(
                    "$addressline ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      color: builder,
                    ),
                  ),
                ),
                //SizedBox(width: 50,),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditLoc()));
                  },
                ),
              ]),
            );
          },
        ),
      ],
    );
  }

  Widget userAge() {
    return Row(
      children: [
        Icon(Icons.perm_contact_calendar, color: Colors.red),
        SizedBox(width: 4),
        Text(
          'Age :',
          style: TextStyle(
              color: Color.fromRGBO(235, 125, 125, 1),
              fontFamily: 'Arial',
              fontSize: 20),
        ),
        SizedBox(width: 70),
        FutureBuilder(
          future: _showProfile(),
          builder: (context, snapshot) {
            return Expanded(
              child: Row(children: [
                Expanded(
                  child: Text(
                    "$age ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      color: builder,
                    ),
                  ),
                ),
                //SizedBox(width: 50,),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditAge()));
                  },
                ),
              ]),
            );
          },
        ),
      ],
    );
  }

  Widget userBloodType() {
    return Row(
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
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () {
                    _bottomSheet(context);
                  },
                ),
              ]),
            );
          },
        ),
      ],
    );
  }

  Widget userBloodDonationValidity() {
    return Row(
      children: [
        Icon(Icons.event_note, color: Colors.red),
        SizedBox(width: 4),
        Text(
          'Blood Donation Validity :',
          style: TextStyle(
              color: Color.fromRGBO(235, 125, 125, 1),
              fontFamily: 'Arial',
              fontSize: 20),
        ),
        SizedBox(width: 35),
        FutureBuilder(
          future: _showProfile(),
          builder: (context, snapshot) {
            return Expanded(
              child: Row(children: [
                Expanded(
                  child: Text(
                    " ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      color: builder,
                    ),
                  ),
                ),
              ]),
            );
          },
        ),
      ],
    );
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
  // _bottomSheet(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext c) {
  //         return Wrap(
  //           children: <Widget>[
  //             Container(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   Container(
  //                     color: r,
  //                     width: double.infinity,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         IconButton(
  //                           icon: Icon(
  //                             Icons.close,
  //                             color: w,
  //                             size: 35,
  //                           ),
  //                           onPressed: () => Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                   builder: (context) => Imagee())),
  //                         ),
  //                         SizedBox(
  //                           width: 25,
  //                         ),
  //                         Container(
  //                           alignment: Alignment.center,
  //                           margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
  //                           child: Text(
  //                             'Chooes blood type',
  //                             style: TextStyle(
  //                               fontSize: 30,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.white,
  //                               fontFamily: 'Microsoft JhengHei',
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Divider(
  //                     height: 5,
  //                   ),
  //                   ListTile(
  //                     title: new Simple('A'),
  //                     onTap: () {
  //                       setState(() {
  //                         tit = 'A';
  //                       });
  //                       _bottomSheet2(context);
  //                     },
  //                     trailing: IconButton(
  //                       icon: Icon(
  //                         Icons.keyboard_arrow_down,
  //                         color: g3,
  //                         size: 60,
  //                       ),
  //                       onPressed: () => // update(),
  //                       _bottomSheet2(context),
  //                     ),
  //                   ),
  //                   Divider(
  //                     color: Colors.black,
  //                   ),
  //                   ListTile(
  //                     title: new Simple("B"),
  //                     onTap: () {
  //                       setState(() {
  //                         tit = 'B';
  //                       });
  //
  //                       _bottomSheet2(context);
  //                     },
  //                     trailing: IconButton(
  //                       icon: Icon(
  //                         Icons.keyboard_arrow_down,
  //                         color: g3,
  //                         size: 60,
  //                       ),
  //                       onPressed: () => //update(),
  //                       _bottomSheet2(context),
  //                     ),
  //                   ),
  //                   Divider(
  //                     color: Colors.black,
  //                   ),
  //                   ListTile(
  //                     title: new Simple("AB"),
  //                     onTap: () {
  //                       //Update();
  //                       setState(() {
  //                         tit = 'AB';
  //                       });
  //
  //                       _bottomSheet2(context);
  //                     },
  //                     trailing: IconButton(
  //                       icon: Icon(
  //                         Icons.keyboard_arrow_down,
  //                         color: g3,
  //                         size: 60,
  //                       ),
  //                       onPressed: () => _bottomSheet2(context),
  //                     ),
  //                   ),
  //                   Divider(
  //                     color: Colors.black,
  //                   ),
  //                   ListTile(
  //                     title: new Simple("O"),
  //                     onTap: () {
  //                       _bottomSheet2(context);
  //                       setState(() {
  //                         tit = 'O';
  //                       });
  //                     },
  //                     trailing: IconButton(
  //                       icon: Icon(
  //                         Icons.keyboard_arrow_down,
  //                         color: g3,
  //                         size: 60,
  //                       ),
  //                       onPressed: () => _bottomSheet2(context),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }
  //
  // _bottomSheet2(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext c) {
  //         return Container(
  //           height: 400,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               Container(
  //                 color: r,
  //                 width: double.infinity,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     IconButton(
  //                       icon: Icon(
  //                         Icons.arrow_back_ios,
  //                         color: g4,
  //                         size: 40,
  //                       ),
  //                       onPressed: () => Navigator.pop(context),
  //                     ),
  //                     //  SizedBox(
  //                     //height : 20,
  //                     //),
  //                     Container(
  //                       alignment: Alignment.center,
  //                       margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
  //                       child: Text(
  //                         'Chooes blood type',
  //                         style: TextStyle(
  //                           fontSize: 30,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.white,
  //                           fontFamily: 'Microsoft JhengHei',
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Divider(
  //                 height: 5,
  //               ),
  //               ListTile(
  //                 title: Text(
  //                   plus,
  //                   style: TextStyle(
  //                     fontSize: 40,
  //                     fontFamily: 'Arial',
  //                     fontWeight: FontWeight.normal,
  //                     color: r,
  //                   ),
  //                 ),
  //                 onTap: () {
  //                   setState(() {
  //                     tit1 = '+';
  //                   });
  //                   update(tit, tit1);
  //                 },
  //               ),
  //               Divider(
  //                 color: Colors.black,
  //               ),
  //               ListTile(
  //                 title: Text(
  //                   minus,
  //                   style: TextStyle(
  //                     fontSize: 40,
  //                     fontFamily: 'Arial',
  //                     fontWeight: FontWeight.normal,
  //                     color: r,
  //                   ),
  //                 ),
  //                 onTap: () {
  //                   setState(() {
  //                     tit1 = '-';
  //                   });
  //                   update(tit, tit1);
  //                 },
  //               ),
  //             ],
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
        name = value.data()['name'];
        age = value.data()['age'];
        phone = value.data()['phone'];
        email = value.data()['email'];
        password = value.data()['password'];
        addressline = value.data()['addressline'];
        country = value.data()['country'];
        subadmin = value.data()['subadminarea'];
        adminarea = value.data()['adminarea'];
        img = value.data()['imageurl'];
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
