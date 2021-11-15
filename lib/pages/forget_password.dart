import 'dart:ui';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}
class _ForgetPasswordState extends State<ForgetPassword> {
  FirebaseAuth instance = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  String _email;
  @override
  Widget build(BuildContext context) {
    Size  screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
        child:Column(
          children:<Widget>[
            Container(
              margin: EdgeInsets.only(top: 40,right: 350),
              child: IconButton(icon:Icon(Icons.arrow_back_ios),
                color: Colors.black,

                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage(),));
                },),),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 55.0),
                    child: Text(
                      "Forget  Password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: HexColor("#F91818"),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    child: Image.asset("assets/images/forget.jpeg"),
                    height: 180,
                    width: 180,
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      "Enter the email address associated with your account ",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        color: HexColor("#E52121"),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: Text(
                      "We will email you a link ",
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        color: HexColor("#B78181"),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(
                      "to reset your password",
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        color: HexColor("#B78181"),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Enter your Email Address",
                          hintStyle: TextStyle(
                            color: HexColor("#A79A9A"),
                            fontSize: 18.0,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged : (value){
                          setState(() {
                            this._email = value;
                          });
                        }
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    //height: 20.0,
                      width: 200.0,
                      margin: EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),

                        child: Text(
                          " Send ",
                          style: TextStyle(
                            color: HexColor("#FFFFFF"),
                            fontSize:35,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        onPressed: () {
                          try {
                            instance.sendPasswordResetEmail(email: this._email);

                            Navigator.of(context).pop();
                          } catch (e) {
                            print(e.code);
                          }
                        },
                        color: Colors.red,
                      ))
                ],
              ),
            )],
        )));
  }
}





















// import 'package:Conneect_Firebase/pages/home.dart';
// import 'package:Conneect_Firebase/pages/login.dart';
// import 'package:Conneect_Firebase/pages/registration.dart';
// import 'package:Conneect_Firebase/provider/auth_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class ForgetPassword extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return ForgetPasswordState();
//   }
// }
//
// class ForgetPasswordState extends State<ForgetPassword> {
//   var r = Color.fromRGBO(218, 19, 19, 1);
//   var g = Color.fromRGBO(211, 211, 211, 1);
//   bool passwordVisible = true;
//   String _email;
//   FirebaseAuth instance = FirebaseAuth.instance;
//   var loginKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<AuthProvider>(
//         context); // الي عملتهAuthProvider ده كدة اوبجيكت من كلاس ال
//     return Scaffold(
//         appBar: AppBar(
//         title: Text("Home"),
//     actions: [
//     IconButton(
//     icon: Icon(Icons.logout),
//     onPressed: () async{
//     await FirebaseAuth.instance.signOut(); // دي هنا عشان ال يوزر يخرج وهيرجع علي اللوجين
//     Navigator.pushReplacement(
//     context, MaterialPageRoute(builder: (context) => LoginPage()));
//     })
//     ],
//         ),
//       key: loginKey,
//       body: Container(
//         height: double.infinity,
//         margin: EdgeInsets.fromLTRB(30, 230, 30, 100),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 child: Center(
//                   child: Text(
//                     "Forget Password!",
//                     style: TextStyle(
//                       fontSize: 40,
//                       fontWeight: FontWeight.w900,
//                       color: r,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.0,
//               ),
//               Container(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Enter Your Email Password",
//                     fillColor: g,
//                     filled: true,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 2, color: g),
//                       borderRadius: BorderRadius.circular(60.0),
//                     ),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   onChanged: (value) {
//                     setState(() {
//                       this._email = value;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 40.0,
//               ),
//               Container(
//                 child: RaisedButton(
//                   child: Column(
//                     children: [
//                       Text(
//                         "Send",
//                         style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.w900,
//                             color: Colors.white,
//                             fontStyle: FontStyle.italic),
//                       ),
//                     ],
//                   ),
//                   onPressed: () {
//                     // await FirebaseAuth.instance.sendPasswordResetEmail(email: this._email);
//                     //  Navigator.of(context).pop();
//                     try {
//                       instance.sendPasswordResetEmail(email: this._email);
//
//                       Navigator.of(context).pop();
//                     } catch (e) {
//                       print(e.code);
//                     }
//                   },
//                   color: r,
//                   padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(60.0),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
