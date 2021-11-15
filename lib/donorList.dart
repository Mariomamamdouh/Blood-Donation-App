import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DashBoard.dart';

class DonorList extends StatefulWidget {
  DonorListState createState() => DonorListState();
}

class DonorListState extends State<DonorList> {
  var img, name, contant,search;
  bool flag1 = true, flag2 = true;
  var text = Color.fromRGBO(213, 209, 209, 1);
  var r = Color.fromRGBO(218, 19, 19, 1);
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var bar = Color.fromRGBO(255, 255, 255, 1);
  var userName = Color.fromRGBO(167, 117, 117, 1);
  var post = Color.fromRGBO(59, 45, 45, 1);
  var react = Color.fromRGBO(222, 24, 24, 1);
  var comment = Color.fromRGBO(213, 68, 68, 1);
  int _counter = 0;
  String owner;
  //var bouttom = Color.fromRGBO(255, 255, 255, 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
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
      body: Column(children: [
    //    TextFormField(
    //   decoration: InputDecoration(
    //     enabledBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //         color: Colors.black12,
    //       ),
    //       borderRadius: BorderRadius.circular(50),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //         color: Colors.black12,
    //       ),
    //       borderRadius: BorderRadius.circular(50),
    //     ),
    //     border: OutlineInputBorder(
    //       borderSide: BorderSide(
    //         color: Colors.black12,
    //       ),
    //       borderRadius: BorderRadius.circular(50),
    //     ),
    //     filled: true,
    //     fillColor: Colors.grey[200],
    //     hintText: 'Search',
    //     hintStyle: TextStyle(
    //       color: Colors.grey,
    //       fontFamily: 'Arial',
    //       fontSize: 20,
    //     ),
    //     suffixIcon: Icon(Icons.phone_enabled, color: Colors.black54),
    //   ),
    //   keyboardType: TextInputType.text,
      
    //   onSaved: (String value) {
    //     search = value;
    //   },
    // ),
         SizedBox(
          height: 20,
         ),
        Padding(
          padding:
              EdgeInsets.only(left: 20.0, top: 0.0, right: 0.0, bottom: 0.0),
          child: Row(
            children: [
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Color.fromRGBO(152, 151, 151, 1),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Marwa()));
                },
                child: Text(
                  "DashBoard",
                  style: TextStyle(
                      color: Color.fromRGBO(222, 144, 144, 1), fontSize: 20),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                color: Color.fromRGBO(227, 152, 152, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Color.fromRGBO(152, 151, 151, 1),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Donor List",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height:10),
        Flexible(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView(
                children: snapshot.data.docs.map((e) {
                  return Card(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    color: Colors.white,
                    //elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: Colors.black26,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: ListTile(
                            leading: Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(e['imageurl']),
                                ),
                              ),
                            ),
                            title: Text(
                              e["name"],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(167, 117, 117, 1)),
                            ),
                            subtitle: Text(
                              e["adminarea"],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(167, 130, 130, 1)),
                            ),
                            trailing: RaisedButton(
                              color: Color.fromRGBO(201, 124, 124, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPressed: () {},
                              child: Text(
                                e["BloodType"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ]),
    ));
  }
}
