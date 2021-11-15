import 'package:gpp1/models/approve.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gpp1/models/getpost.dart';

class ApprovePost {
  final _firestore = Firestore.instance;

  Approve(String postid, PostApprove1 postapprove) {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('post').doc(postid);
    ref.update({
      "appending": postapprove.appending1,
    });
  }
}
