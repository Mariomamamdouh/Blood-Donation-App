import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'donorList.dart';

class Marwa extends StatefulWidget {
  static String id = '';
  @override
  _MarwaState createState() => _MarwaState();
}

class _MarwaState extends State<Marwa> {
  var countA, countA1, countB1, countB2, countAB1, countAB2, countO1, countO2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.0,
        primary: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.red,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 320,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Search",
                      hintStyle: TextStyle(
                        color: Colors.red.shade200,
                        fontSize: 20.0,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 30,
                          )), //TextStyle
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    keyboardType: TextInputType.streetAddress,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, top: 0.0, right: 0.0, bottom: 0.0),
                    child: Expanded(
                        child: Row(
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          color: Color.fromRGBO(227, 152, 152, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                                color: Color.fromRGBO(152, 151, 151, 1)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Marwa()));
                          },
                          child: Text(
                            "DashBoard",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Flexible(
                            child: Row(children: [
                          Flexible(
                              child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Color.fromRGBO(152, 151, 151, 1),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DonorList()));
                            },
                            child: Text(
                              "Donor List",
                              style: TextStyle(
                                  color: Color.fromRGBO(222, 144, 144, 1),
                                  fontSize: 20),
                            ),
                          ))
                        ])),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Row(children: [
                      Container(
                          height: 70,
                          width: 185,
                          margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          color: Color.fromRGBO(236, 118, 118, 1),
                          child: Row(children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  " A+",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontFamily: 'Arial',
                                    // fontWeight: FontWeight.bold,
                                  ),
                                )),
                            SizedBox(
                              width: 90,
                            ),
                            FutureBuilder(
                                future: counta(),
                                builder: (context, snapshot) {
                                  return Expanded(
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(
                                          "$countA",
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontFamily: 'Arial',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
                                })
                          ])),
                      SizedBox(
                        width: 7,
                      ),
                      Flexible(
                          child: Row(children: [
                        Flexible(
                            child: Container(
                                height: 70,
                                width: 185,
                                margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                color: Color.fromRGBO(236, 118, 118, 1),
                                child: Row(children: [
                                  Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        " A-",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontFamily: 'Arial',
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  FutureBuilder(
                                      future: countaminus(),
                                      builder: (context, snapshot) {
                                        return Expanded(
                                          child: Row(children: [
                                            Expanded(
                                              child: Text(
                                                "$countA1",
                                                style: TextStyle(
                                                  fontSize: 26,
                                                  fontFamily: 'Arial',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        );
                                      })
                                ])))
                      ])),
                    ]),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Row(children: [
                      Container(
                          height: 70,
                          width: 185,
                          margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          color: Color.fromRGBO(236, 118, 118, 1),
                          child: Row(children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  " B+",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontFamily: 'Arial',
                                    // fontWeight: FontWeight.bold,
                                  ),
                                )),
                            SizedBox(
                              width: 90,
                            ),
                            FutureBuilder(
                                future: countBplus(),
                                builder: (context, snapshot) {
                                  return Expanded(
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(
                                          "$countB1",
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontFamily: 'Arial',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
                                })
                          ])),
                      SizedBox(
                        width: 7,
                      ),
                      Flexible(
                          child: Row(children: [
                        Flexible(
                            child: Container(
                                height: 70,
                                width: 185,
                                margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                color: Color.fromRGBO(236, 118, 118, 1),
                                child: Row(children: [
                                  Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        " B-",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontFamily: 'Arial',
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  FutureBuilder(
                                      future: countBMINUS(),
                                      builder: (context, snapshot) {
                                        return Expanded(
                                          child: Row(children: [
                                            Expanded(
                                              child: Text(
                                                "$countB2",
                                                style: TextStyle(
                                                  fontSize: 26,
                                                  fontFamily: 'Arial',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        );
                                      })
                                ])))
                      ])),
                    ]),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Row(children: [
                      Container(
                          height: 70,
                          width: 185,
                          margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          color: Color.fromRGBO(236, 118, 118, 1),
                          child: Row(children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  " AB+",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontFamily: 'Arial',
                                    // fontWeight: FontWeight.bold,
                                  ),
                                )),
                            SizedBox(
                              width: 75,
                            ),
                            FutureBuilder(
                                future: countABplus(),
                                builder: (context, snapshot) {
                                  return Expanded(
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(
                                          "$countAB1",
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontFamily: 'Arial',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
                                })
                          ])),
                      SizedBox(
                        width: 7,
                      ),
                      Flexible(
                          child: Row(children: [
                        Flexible(
                            child: Container(
                                height: 70,
                                width: 185,
                                margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                color: Color.fromRGBO(236, 118, 118, 1),
                                child: Row(children: [
                                  Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        " AB-",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontFamily: 'Arial',
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 83,
                                  ),
                                  FutureBuilder(
                                      future: countABminus(),
                                      builder: (context, snapshot) {
                                        return Expanded(
                                          child: Row(children: [
                                            Expanded(
                                              child: Text(
                                                "$countAB2",
                                                style: TextStyle(
                                                  fontSize: 26,
                                                  fontFamily: 'Arial',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        );
                                      })
                                ])))
                      ])),
                    ]),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Row(children: [
                      Container(
                          height: 70,
                          width: 185,
                          margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          color: Color.fromRGBO(236, 118, 118, 1),
                          child: Row(children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  " O+",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontFamily: 'Arial',
                                  ),
                                )),
                            SizedBox(
                              width: 90,
                            ),
                            FutureBuilder(
                                future: countOplus(),
                                builder: (context, snapshot) {
                                  return Expanded(
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(
                                          "$countO1",
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontFamily: 'Arial',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
                                })
                          ])),
                      SizedBox(
                        width: 7,
                      ),
                      Flexible(
                          child: Row(children: [
                        Flexible(
                            child: Container(
                                height: 70,
                                width: 185,
                                margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                color: Color.fromRGBO(236, 118, 118, 1),
                                child: Row(children: [
                                  Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        " O-",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontFamily: 'Arial',
                                        ),
                                      )),
                                  SizedBox(
                                    width: 97,
                                  ),
                                  FutureBuilder(
                                      future: countOminus(),
                                      builder: (context, snapshot) {
                                        return Expanded(
                                          child: Row(children: [
                                            Expanded(
                                              child: Text(
                                                "$countO2",
                                                style: TextStyle(
                                                  fontSize: 26,
                                                  fontFamily: 'Arial',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        );
                                      })
                                ])))
                      ])),
                    ]),
                  ),
                ])
              ]),
        ),
      ),
    ));
  }

  counta() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "A+")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countA = myDocCount.length;
    print(countA);
  }

  countaminus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "A-")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countA1 = myDocCount.length;
    print(countA1);
  }

  countBplus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "B+")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countB1 = myDocCount.length;
    print(countB1);
  }

  countBMINUS() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "B-")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countB2 = myDocCount.length;
    print(countB2);
  }

  countABplus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "AB+")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countAB1 = myDocCount.length;
    print(countAB1);
  }

  countABminus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "AB-")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countAB2 = myDocCount.length;
    print(countAB2);
  }

  countOplus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "O+")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countO1 = myDocCount.length;
    print(countO1);
  }

  countOminus() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('BloodType', isEqualTo: "O-")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    countO2 = myDocCount.length;
    print(countO2);
  }
}
