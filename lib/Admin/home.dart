import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  @override
  HomeAdminState createState() => HomeAdminState();
}
class HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(child:  
        Text("Admin",style: TextStyle(fontSize: 50),),
        ),
        );
  }
}
