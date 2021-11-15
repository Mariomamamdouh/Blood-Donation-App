import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String userEmail;
  String postid;
  String commentID;
  String comment;
  String img;
  String name;
  String userid;
  CommentModel(
      {this.userEmail,
      this.postid,
      this.commentID,
      this.comment,
      this.img,
      this.name,
      this.userid});
  Map toMap(CommentModel comment) {
    var data = Map<String, String>();
    data['name'] = comment.name;
    data['commentID'] = comment.commentID;
    data['userid'] = comment.userid;
    data["postid"] = comment.postid;
    data["comment"] = comment.comment;
    data["userEmail"] = comment.userEmail;
    data["img"] = comment.img;
    return data;
  }

  CommentModel.fromMap(Map<String, String> mapData) {
    this.name = mapData['name'];
    this.img = mapData['img'];
    this.comment = mapData['comment'];
    this.userid = mapData['userid'];
    this.postid = mapData['postid'];
    this.img = mapData['img'];
    this.userEmail = mapData['userEmail'];
  }

  // factory LikeModel.fromDoc(DocumentSnapshot doc) {
  // return LikeModel(doc["userEmail"], doc["postID"], doc["likeID"]);
  // }
}
