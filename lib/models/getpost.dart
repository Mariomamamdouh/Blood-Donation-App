import 'package:cloud_firestore/cloud_firestore.dart';

class Postt {
  String currentuserid;
  String postdesc;
  var postid;
  String uid;
  String name;
  String appending;
  Timestamp time;
  String img;
  String userEmail;
  Map likes;
  int likecount;
  Postt(
      {this.currentuserid,
      this.postdesc,
      this.postid,
      this.uid,
      this.name,
      this.appending,
      this.img,
      this.time,
      this.userEmail,
      this.likes,
      this.likecount});
  Map toMap(Postt postDetails) {
    var data = Map<String, String>();
    data['currentuserid'] = postDetails.currentuserid;
    data['name'] = postDetails.name;
    data['img'] = postDetails.img;
    data['postdesc'] = postDetails.postdesc;
    data['uid'] = postDetails.uid;
    data["postid"] = postDetails.postid;
    data["likes"] = postDetails.likes as String;
    data["likecount"] = postDetails.likecount as String;
    return data;
  }

  Postt.fromMap(Map<String, String> mapData) {
    this.currentuserid = mapData['currentuserid'];
    this.name = mapData['name'];
    this.img = mapData['img'];
    this.postdesc = mapData['postdesc'];
    this.uid = mapData['uid'];
    this.postid = mapData['postid'];
  }
  String get _name => name;
  String get _img => img;
  String get _postdesc => postdesc;
  String get _uid => uid;
  String get _postid => postid;
  String get _currentuserid => currentuserid;
  set _img(String img) {
    this.img = img;
  }

  set _name(String name) {
    this.name = name;
  }

  set _postdesc(String postdesc) {
    this.postdesc = postdesc;
  }

  set _uid(String uid) {
    this.uid = uid;
  }

  set _postid(String postid) {
    this.postid = postid;
  }

  set _likes(Map likes) {
    this.likes = likes;
  }

  set _likecount(int likecount) {
    this.likecount = likecount;
  }
}
