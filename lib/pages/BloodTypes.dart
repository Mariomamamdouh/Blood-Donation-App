import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

import 'drawer.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  String title = "";
  Color g = Color.fromRGBO(105, 100, 100, 1);
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var bar = Color.fromRGBO(255, 255, 255, 1);
  var userName = Color.fromRGBO(167, 120, 120, 1);
  var titlee = Color.fromRGBO(187, 166, 166, 1);
  Color w = Colors.white;
  Color b = Colors.black;
  String search1, search2;
  var lat, long, adminarea;
  String location = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final ReuseableCardState t = new ReuseableCardState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backG,
        title: Text(
          "Search",
          style: TextStyle(fontSize: 30, fontFamily: 'Noto Serif', color: bar),
        ),
      ),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 190, 0),
              child: Text(
                "Find Doner",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromRGBO(230, 23, 23, 1),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 16, 0, 0),
              child: Text(
                "By Blood Type and Location  ",
                style: TextStyle(
                  color: Color.fromRGBO(163, 109, 109, 1),
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 165, 0),
              child: Text(
                "Choose Blood Type  ",
                style: TextStyle(
                  color: Color.fromRGBO(150, 137, 137, 1),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              //عشان عندى كذا كار فبعمل كلاس لكارد واحده واشوف ايه اللى بيتغير اللى هو التيكست احط قيمته
              height: 180,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: w,
                        onPressed: () {
                          setState(() {
                            search1 = "A+";
                          });
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.black12)),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text("A+",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: g,
                                ))),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: w,
                        onPressed: () {
                          setState(() {
                            search1 = "A-";
                          });
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.black12)),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text("A-",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: g,
                                ))),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: w,
                        onPressed: () {
                          setState(() {
                            search1 = "B+";
                          });
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.black12)),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text("B+",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: g,
                                ))),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: w,
                        onPressed: () {
                          setState(() {
                            search1 = "B-";
                          });
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.black12)),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text("B-",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: g,
                                ))),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: w,
                        onPressed: () {
                          setState(() {
                            search1 = "O+";
                          });
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.black12)),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text("O+",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: g,
                                ))),
                      ),

                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: w,
                        onPressed: () {
                          setState(() {
                            search1 = "O-";
                          });
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.black12)),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text("O-",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: g,
                                ))),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: w,
                        onPressed: () {
                          setState(() {
                            search1 = "AB+";
                          });
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.black12)),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text("AB+",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: g,
                                ))),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: w,
                        onPressed: () {
                          setState(() {
                            search1 = "AB-";
                          });
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.black12)),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text("AB-",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: g,
                                ))),
                      ),

                      //      new ReuseableCard('A-','d'),
                      //    new ReuseableCard(text:'B-'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Form(
                key: formKey,
                child: Container(
                  width: 350,
                  height: 60,
                  child: TextFormField(
                    showCursor: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: location,
                      hintStyle: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.black54,
                            size: 30,
                          ),
                          onPressed: () {
                            getLocation();
                          }), //TextStyle
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (location.isEmpty) {
                        return "Please Enter Your Location";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        location = value;
                      });
                    },
                  ),
                )),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 2, 20, 0),
              child: FloatingActionButton.extended(
                backgroundColor: Color(0xffe60000),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => search(search1, location)));
                  }
                },
                icon: Icon(
                  Icons.search,
                  color: w,
                  size: 43,
                ),
                label: Text(
                  "Search",
                  style: TextStyle(fontSize: 35, color: w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLocation() async {
    var lat, long, country;
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
    final coordinates = new Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    adminarea = addresses.first.adminArea;
    setState(() {
      location = "$adminarea";
    });
  }

  Widget search(String bloodtype, location) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backG,
          title: Text(
            "Doner List",
            style:
                TextStyle(fontSize: 30, fontFamily: 'Noto Serif', color: bar),
          ),
        ),
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        body: Column(children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('BloodType', isEqualTo: bloodtype)
                  .where('adminarea', isEqualTo: location)
                  .snapshots(),
              builder: (context, snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.docs[index];
                          if (snapshot.hasData) {
                            return Text(
                              "No Donor is found with blood type " +
                                  data["BloodType"],
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromRGBO(183, 129, 129, 1)),
                            );
                          }
                          return Card(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              color: Colors.white,
                              //elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.black26,
                                ),
                              ),
                              child: Column(children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  child: ListTile(
                                    leading: Container(
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(data['imageurl']),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      data["name"],
                                      style: TextStyle(
                                          fontSize: 23, color: userName),
                                    ),
                                    subtitle: Text(
                                      data["adminarea"],
                                      style: TextStyle(
                                          fontSize: 20, color: titlee),
                                    ),
                                    onTap: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  finalsearch(data["userid"])));
                                    },
                                  ),
                                ),
                              ]));
                        },
                      );
              },
            ),
          ),
        ]));
  }
}

Widget finalsearch(finall) {
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var userName = Color.fromRGBO(191, 49, 49, 1);
  var builder = Color.fromRGBO(191, 86, 86, 1);
  return Scaffold(
    appBar: PreferredSize(
      child: AppBar(
        backgroundColor: Color(0xffe60000),
        elevation: 0.0,
      ),
      preferredSize: Size.fromHeight(60),
    ),
    drawer: Drawer(
      child: DrawerScreen(),
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .where('userid', isEqualTo: finall)
          .snapshots(),
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.documents[index];
                  return Column(
                    children: <Widget>[
                      Column(
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
                                Positioned(
                                  top: 60.0,
                                  child: Container(
                                    //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    height: 170.0,
                                    width: 170.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(data['imageurl']),
                                      ),
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(213, 209, 209, 1),
                                          width: 6.0),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 230.0,
                                  child: Text(
                                    data["name"],
                                    style: TextStyle(
                                        fontSize: 27, color: userName),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 130,
                          ),
                          ListTile(
                            leading: Icon(Icons.phone, color: Colors.red),
                            title: Text(
                              'Phone ',
                              style: TextStyle(
                                  color: Color.fromRGBO(235, 125, 125, 1),
                                  fontFamily: 'Arial',
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              data["phone"],
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Arial',
                                color: builder,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on, color: Colors.red),
                            title: Text(
                              'Location ',
                              style: TextStyle(
                                  color: Color.fromRGBO(235, 125, 125, 1),
                                  fontFamily: 'Arial',
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              data["adminarea"],
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Arial',
                                color: builder,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          ListTile(
                            leading: Icon(Icons.perm_contact_calendar,
                                color: Colors.red),
                            title: Text(
                              'Age ',
                              style: TextStyle(
                                  color: Color.fromRGBO(235, 125, 125, 1),
                                  fontFamily: 'Arial',
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              data["age"],
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Arial',
                                color: builder,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          ListTile(
                            leading: Icon(Icons.local_fire_department_rounded,
                                color: Colors.red),
                            title: Text(
                              'Blood Type ',
                              style: TextStyle(
                                  color: Color.fromRGBO(235, 125, 125, 1),
                                  fontFamily: 'Arial',
                                  fontSize: 20),
                            ),
                            trailing: Text(
                              data["BloodType"],
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Arial',
                                color: builder,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          ListTile(
                            leading: Icon(Icons.event_note, color: Colors.red),
                            title: Text(
                              'Blood Donation Validity :',
                              style: TextStyle(
                                  color: Color.fromRGBO(235, 125, 125, 1),
                                  fontFamily: 'Arial',
                                  fontSize: 20),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
      },
    ),
  );
}

class ReuseableCard extends StatelessWidget {
  ReuseableCard(this.text);
  String text;
  Color w = Colors.white;
  Color b = Colors.black;
  Color r = Color.fromRGBO(245, 27, 27, 1);
  Color g = Color.fromRGBO(105, 100, 100, 1);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w400,
        color: Colors.black12,
      ),
    );
  }
}

class SimpleDialog extends StatelessWidget {
  final title;
  SimpleDialog(this.title);
  Color g2 = Color.fromRGBO(93, 96, 99, 1);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    );
  }
}
