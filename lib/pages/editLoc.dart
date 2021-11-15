import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';

import 'image.dart';

class EditLoc extends StatefulWidget {
  _EditLocState createState() => _EditLocState();
}

class _EditLocState extends State<EditLoc> {
  var backG = Color.fromRGBO(229, 33, 33, 1);
  final GlobalKey<FormState> _formKey = GlobalKey();
  var admin_area = "AdminArea";
  var countryy = " Country ";
  var addressLine = " Addressline ";
  var sub_admin_area = " SubadminArea ";
  var lat, long, country, adminarea, addressline, subadmin;
  _getLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
    final coordinates = new Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    country = addresses.first.countryName;
    adminarea = addresses.first.adminArea;
    addressline = addresses.first.addressLine;
    subadmin = addresses.first.subAdminArea;
    setState(() {
      admin_area = "$adminarea";
      countryy = "$country";
      addressLine = "$addressline";
      sub_admin_area = "$subadmin";
    });
  }

  Widget build(BuildContext cx) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: backG,
        title: Text(
          "Set Location",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.all(20),
                color: Colors.white,
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            "Current Location",
                            style: TextStyle(
                              color: backG,
                              fontFamily: 'Arial',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                              hintMaxLines: 5,
                              hintText: admin_area,
                              hintStyle: TextStyle(
                                color: backG,
                                fontFamily: 'Arial',
                                fontSize: 20,
                              ),
                            ),
                              showCursor: false,
                              readOnly: true,
                          ),
                        ),
                        //SizedBox(height: 50,),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                              hintMaxLines: 5,
                              hintText: countryy,
                              hintStyle: TextStyle(
                                color: backG,
                                fontFamily: 'Arial',
                                fontSize: 20,
                              ),
                            ),
                            showCursor: false,
                            readOnly: true,
                          ),
                        ),
                        //SizedBox(height: 50,),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                              hintMaxLines: 5,
                              hintText: addressLine,
                              hintStyle: TextStyle(
                                color: backG,
                                fontFamily: 'Arial',
                                fontSize: 20,
                              ),
                            ),
                            showCursor: false,
                            readOnly: true,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                              hintMaxLines: 5,
                              hintText: sub_admin_area,
                              hintStyle: TextStyle(
                                color: backG,
                                fontFamily: 'Arial',
                                fontSize: 20,
                              ),
                            ),
                            showCursor: false,
                            readOnly: true,
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 10, 0),
                child: InkWell(
                  child: Icon(
                    Icons.location_on,
                    color: backG,
                    size: 100,
                  ),
                  onTap: () {
                    _getLocation();
                  },
                ),
              ),
              text(),
              Expanded(
              child:Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 10, 0),
                child: FlatButton(
                  //backgroundColor: Color.fromRGBO(255, 255, 255, 0.7),
                  onPressed: () {
                    update();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        //color: Color.fromRGBO(130, 130, 130, 1)
                      color: backG,
                      ),
                  ),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget text() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Text(
        "Press here",
        style: TextStyle(fontSize: 20, color: backG),
      ),
    );
  }
  void update() async {
    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({
      'long': long,
      'lat': lat,
      'adminarea': adminarea,
      'addressline': addressline,
      'subadminarea': subadmin,
      'country': country,
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Imagee()));
  }
}
