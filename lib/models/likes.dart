import 'package:cloud_firestore/cloud_firestore.dart';

class LikeModel {
  String userEmail;
  String userid;
  String postid;
  String likeID;
  String like;
  String name;
  String img;

  LikeModel(
      {this.userEmail,
      this.postid,
      this.likeID,
      this.like,
      this.name,
      this.userid,
      this.img});
  Map toMap(LikeModel like) {
    var data = Map<String, String>();
    data['name'] = like.name;
    data['likeID'] = like.likeID;
    data['userid'] = like.userid;
    data["postid"] = like.postid;
    data["like"] = like.like;
    data["userEmail"] = like.userEmail;
    data["img"] = like.img;
    return data;
  }

  LikeModel.fromMap(Map<String, String> mapData) {
    this.name = mapData['name'];
    this.likeID = mapData['likeID'];
    this.userid = mapData['userid'];
    this.postid = mapData['postid'];
    this.like = mapData['like'];
    this.userEmail = mapData['userEmail'];
    this.img = mapData['img'];
  }
  String get _name => name;
  String get _like => like;
  String get _userEmail => userEmail;
  String get _userid => userid;
  String get _postid => postid;
  String get _likeID => likeID;
  String get _img => img;
  set _userid(String uid) {
    this.userid = uid;
  }

  set _postid(String postid) {
    this.postid = postid;
  }

  set _like(String like) {
    this.like = like;
  }

  set _likeID(String likeID) {
    this.likeID = likeID;
  }

  set _userEmail(String userEmail) {
    this.userEmail = userEmail;
  }

  set _name(String name) {
    this.name = name;
  }

  set _img(String img) {
    this.img = img;
  }
}
