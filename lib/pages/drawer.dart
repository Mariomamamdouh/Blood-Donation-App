import 'package:gpp1/pages/chat.dart';
import 'package:gpp1/pages/profile_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'BloodTypes.dart';
import 'Change_Password.dart';
import 'home.dart';
import 'login.dart';
import 'image.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String _img, _name;
  var text = Color.fromRGBO(213, 209, 209, 1);
  var backG = Color.fromRGBO(229, 33, 33, 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: backG,
          width: double.infinity,
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageProfile(),
                  FutureBuilder(
                    future: _showProfile(),
                    builder: (context, snapshot) {
                      return Text(
                        "$_name ",
                        style: TextStyle(
                          color: text,
                          fontFamily: 'Arial',
                          fontSize: 25,
                        ),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: text,
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                          fontFamily: 'Arial', color: text, fontSize: 25),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Imagee()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.post_add_sharp,
                      color: text,
                    ),
                    title: Text(
                      'Posts',
                      style: TextStyle(
                          fontFamily: 'Arial', color: text, fontSize: 25),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: text,
                    ),
                    title: Text(
                      'Calls',
                      style: TextStyle(
                          fontFamily: 'Arial', color: text, fontSize: 25),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.messenger_sharp,
                      color: text,
                    ),
                    title: Text(
                      'Chats',
                      style: TextStyle(
                          fontFamily: 'Arial', color: text, fontSize: 25),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Chat()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.search,
                      color: text,
                    ),
                    title: Text(
                      'Search',
                      style: TextStyle(
                          fontFamily: 'Arial', color: text, fontSize: 25),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.vpn_key_outlined,
                      color: text,
                    ),
                    title: Text(
                      'Change Password',
                      style: TextStyle(
                          fontFamily: 'Arial', color: text, fontSize: 25),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Change()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: text,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: 'Arial', color: text, fontSize: 25),
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance
                          .signOut(); // دي هنا عشان ال يوزر يخرج وهيرجع علي اللوجين
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                  SizedBox(
                    height: 37.5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget imageProfile() {
    return FutureBuilder(
      future: _showProfile(),
      builder: (context, snapshot) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 190.0,
                width: 190.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (_img != null)
                          ? NetworkImage(_img)
                          : NetworkImage(
                              'https://i.pinimg.com/564x/04/28/f5/0428f5706e19f681febc5aa677d7e282.jpg'),
                      //NetworkImage(_img),
                    ),
                    border: Border.all(color: text, width: 6.0)),
              ),
            ]);
      },
    );
  }

  _showProfile() async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        _name = value.data()['name'];
        _img = value.data()['imageurl'];
      }).catchError((e) {
        print(e);
      });
  }
}
