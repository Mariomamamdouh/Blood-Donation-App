import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'EditAnswer.dart';
import 'image.dart';

class TestResultPage extends StatefulWidget {
  @override
  _TestResultPageState createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(child: Text("click me"), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class Consts {
  static const double padding = 16;
  static const double avatarRadius = 66;
  Consts._();
}

class CustomDialog extends StatefulWidget {
  final String tiltle, describtion1, buttonText;
  final img;

  CustomDialog({
    Key key,
    this.tiltle,
    this.describtion1,
    this.buttonText,
    this.img,
  }) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  Color w = Colors.white;
  Color b = Colors.black;
  Color g = Colors.green;
  Color r = Color.fromRGBO(242, 7, 50, 1);
  Color r2 = Color.fromRGBO(242, 7, 50, 1);
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: DialogContent(context),
    );
  }

  DialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 82,
            bottom: Consts.padding,
            right: Consts.padding,
            left: Consts.padding,
          ),
          margin: EdgeInsets.only(
            top: Consts.avatarRadius,
          ),
          decoration: BoxDecoration(
              color: w,
              borderRadius: BorderRadius.circular(45),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(color: b, blurRadius: 20, offset: Offset(0, 10)),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: Consts.padding),
              Text(
                widget.describtion1,
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 25,
                  color: r2,
                  fontWeight: FontWeight.w700,
                  wordSpacing: 0,
                  letterSpacing: 0,
                ),
              ),
              SizedBox(height: Consts.padding),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  color: flag ? r : g,
                  //r = r == Color.fromRGBO(242, 7, 50, 1)
                  //  ? Color.fromRGBO(242, 8, 50, 1)
                  //: Colors.green,
                  textColor: w,
                  child: Text(widget.buttonText,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                  onPressed: () {
                    pass();
                    setState(() {
                      flag = !flag;
                    });

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Imagee()));
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          height: 140,
          width: 127,
          padding: EdgeInsets.only(top: 10),
          margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: CircleAvatar(
            backgroundImage: widget.img, // AssetImage("assets/images/4.png")
            backgroundColor: w,
            radius: 60,
          ),
        )
      ],
    );
  }

  void pass() async {
    final user = await FirebaseAuth.instance.currentUser;
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    ref.update({
      "flag": "1",
      "donor validity": "yes",
    });
  }
}
