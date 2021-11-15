//import 'dart:html';
import 'package:gpp1/provider/firebase.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:gpp1/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'BackGraund.dart';
import 'home.dart';

class Register extends StatefulWidget {
  static String id = 'FormScreen';
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  var backG = Color.fromRGBO(229, 33, 33, 1);
  var gr = Color.fromRGBO(230, 230, 230, 1);
  var b = Colors.black;
  var w = Colors.white;
  User user;
  bool passwordVisible = true;
  String _name,
      _phone,
      _location,
      _age,
      _confirmpass,
      email,
      _password,
      _bloodeType;
  int state = 1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  var loginKey = GlobalKey<ScaffoldState>();
  FirebaseAuth instance = FirebaseAuth.instance;
  var locationMessage = "Location";
  var lat, long, country, adminarea, addressline, subadmin, code;
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
      locationMessage =
          " AdminArea : $adminarea \n Country : $country \n addressline: $addressline \n subadminarea : $subadmin";
    });
  }

  Widget _buildName() {
    return TextFormField(
      //decoration: InputDecoration(labelText: 'User Name'),
      //maxLength: 10,
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
        fillColor: Colors.grey[200],
        hintText: "UserName",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'Arial',
          fontSize: 20,
        ),
        suffixIcon: Icon(Icons.person_pin, color: Colors.black54),
      ),
      keyboardType: TextInputType.name,
      validator: (String value) {
        if (value.isEmpty) {
          return 'This field is Required';
        }
        if (value.length < 3) {
          return 'Name Must Be at least 3 characters';
        }
        if (value.length > 30) {
          return 'You exceed characters limits';
        }
        if (value.contains('@') ||
            value.contains('*') ||
            value.contains('/') ||
            value.contains('+')) {
          return 'invalid username';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
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
        fillColor: Colors.grey[200],
        hintText: 'Email Address',
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'Arial',
          fontSize: 20,
        ),
        suffixIcon: Icon(Icons.email, color: Colors.black54),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'This field is Required';
        }
        if (!RegExp("^[a-zA-Z0-9+.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return "Please Enter Invalid Email";
        } else if (!value.contains('.com') || !value.contains('gmail')) {
          return "invalid email";
        }
      },
      onSaved: (value) {
        email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      // obscureText: true,
      controller: password,
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
        fillColor: Colors.grey[200],
        hintText: 'Password',
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'Arial',
          fontSize: 20,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          color: Colors.black54,
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible; // false
            });
          },
        ),
      ),
      obscureText: passwordVisible,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value.isEmpty) {
          return 'This field is Required';
        } else if (value.length <= 5) {
          return "Password is too short";
        } else if (value.length > 15) {
          return "Password is too Long";
        }
      },
      onSaved: (value) {
        _password = value;
      },
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      controller: confirmpassword,
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
        fillColor: Colors.grey[200],
        hintText: 'Confirm Password',
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'Arial',
          fontSize: 20,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          color: Colors.black54,
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible; // false
            });
          },
        ),
      ),
      obscureText: passwordVisible,
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'This field is Required';
        }
        if (password.text != confirmpassword.text) {
          return "Password does not match";
        }
        if (value.length < 5) {
          return "Password must be at least 5 Characters";
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildLocation() {
    return TextFormField(
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
        fillColor: Colors.grey[200],
        suffixIcon: IconButton(
            icon: Icon(
              Icons.location_on,
              color: Colors.black54,
              size: 30,
            ),
            onPressed: () {
              _getLocation();
            }),
        hintMaxLines: 5,
        hintText: locationMessage,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'Arial',
          fontSize: 20,
        ),
      ),
      readOnly: true,
      showCursor: false,
      validator: (value) {
        if (locationMessage.isEmpty) {
          return 'This field is Required';
        }
        return null;
      },
      onSaved: (String value) {
        locationMessage = value;
      },
    );
  }

  Widget _buildBloodType() {
    return TextFormField(
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
        fillColor: Colors.grey[200],
        suffixIcon: Icon(
          Icons.local_fire_department_rounded,
          color: Colors.black54,
          size: 30,
        ),
        hintMaxLines: 5,
        hintText: 'Blood Type',
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'Arial',
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'This field is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _bloodeType = value;
        ;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
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
        fillColor: Colors.grey[200],
        hintText: 'Phone Number',
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'Arial',
          fontSize: 20,
        ),
        suffixIcon: Icon(Icons.phone_enabled, color: Colors.black54),
      ),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'This field is Required';
        }
        if (value.contains('@') ||
            value.contains('*') ||
            value.contains('/') ||
            value.contains('+') ||
            value.contains('(') ||
            value.contains(')') ||
            value.contains('=') ||
            value.contains('?') ||
            value.contains('>') ||
            value.contains('<') ||
            value.contains(',') ||
            value.contains('.') ||
            value.contains('[') ||
            value.contains(']') ||
            value.contains('{') ||
            value.contains('}') ||
            value.contains('"') ||
            value.contains(';') ||
            value.contains(':') ||
            value.contains('_') ||
            value.contains('-') ||
            value.contains('&') ||
            value.contains('^') ||
            value.contains('%') ||
            value.contains('!') ||
            value.contains('،') ||
            value.contains('|') ||
            value.contains('~')) {
          return 'phone number mustn\'t contain special characters';
        }
        if (RegExp("[a-zA-Z]").hasMatch(value)) {
          return "Phone number mustn\'t be characters";
        }
        if (value.length != 11) {
          return 'Phone number must be 11 numbers';
        }
        if (value.contains('-')) {
          return 'Phone number mustn\'t be negative number';
        }
        return null;
      },
      onSaved: (String value) {
        _phone = value;
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
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
        fillColor: Colors.grey[200],
        hintText: 'Age',
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'Arial',
          fontSize: 20,
        ),
        suffixIcon: Icon(Icons.perm_contact_calendar, color: Colors.black54),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int ages = int.tryParse(value);

        if (ages == null) {
          return 'This field is Required';
        }
        if (ages == 0) {
          return 'Age mustn\'t be zero';
        }
        if (ages < 15) {
          return 'minimum age is 15';
        }
        if (ages > 90) {
          return 'maximum age is 90';
        }
        return null;
      },
      onSaved: (String value) {
        _age = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.25;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Color(0xffe60000),
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      key: loginKey,
      body: ListView(
        children: [
          //margin: EdgeInsets.all(24),
          ClipPath(
            // will draw the wave
            clipper: BezierClipper(state),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: Color(0xffe60000),
              height: height,
              child: Container(
                padding: EdgeInsets.fromLTRB(50, 80, 50, 50),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Arial",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Color(0xF5F5F5),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildName(),
                        SizedBox(height: 10.0),
                        _buildEmail(),
                        SizedBox(height: 10.0),
                        _buildPhoneNumber(),
                        SizedBox(height: 10.0),
                        _buildAge(),
                        SizedBox(height: 10.0),
                        _buildBloodType(),
                        SizedBox(height: 10.0),
                        _buildLocation(),
                        SizedBox(height: 10.0),
                        _buildPassword(),
                        SizedBox(height: 10.0),
                        _buildConfirmPassword(),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              register();
                            },
                            child: Text("Signup",
                                style: TextStyle(
                                    fontSize: 35, color: Color(0xFFFFFFFF))),
                            color: Color(0xffe60000),
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 45),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                            // margin: EdgeInsets.fromLTRB(195, 0, 0, 0),
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Color(0xff2A2222),
                                fontSize: 20,
                              ),
                            ),
                            InkWell(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Color(0xffE17373),
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> register() async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      //print(_email);
      verificationEmail();
    }
  }

  void verificationEmail() async {
    EmailAuth.sessionName = "Blood Donation";
    var ref = await EmailAuth.sendOtp(receiverMail: email);
    if (ref) {
      print("code send");
      showDialogFun(context);
    } else {
      print("code not send");
    }
  }

  void verifyCode() async {
    var ref = EmailAuth.validate(receiverMail: email, userOTP: code);
    if (ref) {
      print("code verifed");
      try {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: _password);
        FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user.uid)
            .set({
          'name': this._name,
          'age': this._age,
          'phone': this._phone,
          'long': long,
          'lat': lat,
          'adminarea': adminarea,
          'addressline': addressline,
          'subadminarea': subadmin,
          'country': country,
          'imageurl':
              'https://i.pinimg.com/564x/04/28/f5/0428f5706e19f681febc5aa677d7e282.jpg',
          'userid': credential.user.uid,
          'role': 'notAdmin',
          'BloodType': _bloodeType,
          "flag": "0",
          "donor validity": "-",
        });
        // verificationEmail();
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => SendCode()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          //shwo snackbar
          loginKey.currentState.showSnackBar(SnackBar(
            content: Text("Email already exist"),
          ));
        } else if (e.code == 'weak-password') {
          //shwo snackbar
          loginKey.currentState.showSnackBar(SnackBar(
            content: Text("Your Password Is weak"),
          ));
        } else if (e.code == 'invalid-email') {
          //shwo snackbar
          loginKey.currentState.showSnackBar(SnackBar(
            content: Text("Invalid Email"),
          ));
        }
      } catch (e) {
        print(e.code);
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      loginKey.currentState.showSnackBar(SnackBar(
        content: Text("Invalid Code"),
      ));
    }
  }

  showDialogFun(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SingleChildScrollView(
              child: Container(
                height: 500,
                child: Container(
                  //padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
                        child: Container(
                          width: 85,
                          height: 85,
                          child: IconButton(
                            icon: Icon(
                              Icons.email_rounded,
                              color: Colors.white,
                              size: 60,
                            ),
                            onPressed: () {},
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Text(
                          "Email Verification",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          "Enter the code sent to your email",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: gr,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: gr),
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
                            hintText: "Enter Code",
                            hintStyle: TextStyle(
                                fontSize: 20, color: Color(0xff808080)),
                          ),
                          style: TextStyle(color: b, fontSize: 21),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            code = value;
                          },
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Don't receive the code? ",
                                style: TextStyle(
                                  color: Color(0xff2A2222),
                                  fontSize: 20,
                                ),
                              ),
                              InkWell(
                                child: Text(
                                  "RESEND",
                                  style: TextStyle(
                                    color: Color(0xffE17373),
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () {
                                  verificationEmail();
                                },
                              ),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Verify",
                              style: TextStyle(fontSize: 35, color: w)),
                          color: Color(0xffe60000),
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 70),
                          onPressed: () {
                            verifyCode();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
