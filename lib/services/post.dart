import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpp1/models/comment.dart';
import 'package:gpp1/models/likes.dart';
import 'package:gpp1/models/message.dart';
import 'package:gpp1/models/post.dart';

class Post {
  final _firestore = Firestore.instance;
  AddPost(Postt post) {
    _firestore.collection("post").doc(post.postid).set({
      "userid": post.uid,
      "postdescribtion": post.postdesc,
      "name": post.name,
      "postid": post.postid,
      "appending": post.appending,
      "time": post.time,
      "img": post.img,
    });
  }
}

class Likes {
  User user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  AddLike(String post, LikeModel like) {
    _firestore.collection("like").doc(like.likeID).set({
      "like": like.like,
      "like_id": like.likeID,
      "userEmail": like.userEmail,
      "postid": post,
      "userid": like.userid,
      "name": like.name,
      "img": like.img,
    });
  }
}

class Comment {
  final _firestore = FirebaseFirestore.instance;
  AddComment(String post, CommentModel comment) {
    _firestore.collection("comments").doc(comment.commentID).set({
      "comment": comment.comment,
      "comment_id": comment.commentID,
      "userEmail": comment.userEmail,
      "img": comment.img,
      "postid": post,
      "name": comment.name,
      "userid": comment.userid
    });
  }
}

class SendMessage {
  final _firestore = FirebaseFirestore.instance;
  AddMessage(Message msg) {
    _firestore
        .collection("message")
        .doc(msg.senderUid)
        .collection(msg.receiverUid)
        .doc(msg.chatid)
        .set({
      "senderUid": msg.senderUid,
      "receiverUid": msg.receiverUid,
      "timestamp": msg.timestamp,
      "message": msg.message,
      "type": msg.type,
      "sendername": msg.sendername,
      "recname": msg.recname,
      "recimg": msg.recimg,
      "senderimg": msg.senderimg,
      "chatid": msg.chatid,
    });
  }
}
