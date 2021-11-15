import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderUid;
  String receiverUid;
  String type;
  String message;
  Timestamp timestamp;
  String senderimg;
  String recimg;
  String sendername;
  String recname;
  String chatid;

  Message(
      {this.senderUid,
      this.receiverUid,
      this.type,
      this.message,
      this.timestamp,
      this.recimg,
      this.recname,
      this.senderimg,
      this.sendername,
      this.chatid});
  Message.withoutMessage(
      {this.senderUid,
      this.receiverUid,
      this.type,
      this.timestamp,
      this.message,
      this.recimg,
      this.recname,
      this.senderimg,
      this.sendername,
      this.chatid});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['senderUid'] = this.senderUid;
    map['receiverUid'] = this.receiverUid;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    map['recimg'] = this.recimg;
    map['senderimg'] = this.senderimg;
    map['sendername'] = this.sendername;
    map['recname'] = this.recname;
    map['chatid'] = this.chatid;
    return map;
  }

  Message fromMap(Map<String, dynamic> map) {
    Message _message = Message();
    _message.senderUid = map['senderUid'];
    _message.receiverUid = map['receiverUid'];
    _message.type = map['type'];
    _message.message = map['message'];
    _message.timestamp = map['timestamp'];
    _message.timestamp = map['sendername'];
    _message.timestamp = map['senderimg'];
    _message.timestamp = map['recname'];
    _message.timestamp = map['recimg'];
    return _message;
  }
}
