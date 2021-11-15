import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpp1/models/message.dart';

import 'package:gpp1/pages/home.dart';
import 'package:gpp1/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpp1/services/post.dart';

class Chat extends StatefulWidget {
  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  TextEditingController messagecontroller = TextEditingController();
  User user = FirebaseAuth.instance.currentUser;
  var listItem;
  final messagesend = SendMessage();
  List<DocumentSnapshot> chatlist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("users").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text("There is no expense");
              return new ListView(children: getExpenseItems(snapshot));
            }));
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => kk(doc["userid"])));
              print(doc["userid"]);
            },
            child: Row(children: <Widget>[
              Image.network(
                doc['imageurl'],
                width: 150,
                height: 100,
                fit: BoxFit.fill,
              ),
              SimpleDialog(doc["name"]),
            ])))
        .toList();
  }

  Widget kk(userid) {
    return Scaffold(
        appBar: AppBar(
          title: Text("chat"),
        ),
        body: Form(
          child: FirebaseAuth.instance.currentUser.uid == null
              ? Container(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: <Widget>[
                    //buildListLayout(),
                    ChatMessagesListWidget(userid),
                    Divider(
                      height: 20.0,
                      color: Colors.black,
                    ),
                    ChatInputWidget(userid),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
        ));
  }

  sendmessage(userid1) async {
    final userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    final userData1 =
        await FirebaseFirestore.instance.collection("users").doc(userid1).get();
    messagesend.AddMessage(Message(
      senderUid: FirebaseAuth.instance.currentUser.uid,
      receiverUid: userid1,
      timestamp: Timestamp.now(),
      message: messagecontroller.text,
      type: "text",
      recname: userData1["name"],
      sendername: userData["name"],
      recimg: userData1["imageurl"],
      senderimg: userData['imageurl'],
      chatid: FirebaseFirestore.instance
          .collection("message")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection(userid1)
          .doc()
          .id,
    ));
  }

  Widget ChatInputWidget(userid1) {
    return Container(
      height: 55.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(
              validator: (String input) {
                if (input.isEmpty) {
                  return "Please enter message";
                }
              },
              controller: messagecontroller,
              decoration: InputDecoration(
                  hintText: "Enter message...",
                  labelText: "Message",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              onFieldSubmitted: (value) {
                messagecontroller.text = value;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              splashColor: Colors.white,
              icon: Icon(
                Icons.send,
                color: Colors.black,
              ),
              onPressed: () {
                sendmessage(userid1);
              },
            ),
          )
        ],
      ),
    );
  }

  /* Widget chat(userid1) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Color(0xffe60000),
          elevation: 0.0,
        ),
        preferredSize: Size.fromHeight(60),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('message')
            .where('senderid', isEqualTo: user.uid)
            .where("Recieverid", isEqualTo: userid1)
            .snapshots(),
        builder: (context, snapshot) {
          if (userid1 != null) {
            return Column(children: [
              Container(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  validator: (String input) {
                    if (input.isEmpty) {
                      return "Please enter message";
                    }
                  },
                  controller: messagecontroller,
                  decoration: InputDecoration(
                      hintText: "Enter message...",
                      labelText: "Message",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  onFieldSubmitted: (value) {
                    messagecontroller.text = value;
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                      onPressed: () {
                        sendmessage(userid1);
                      },
                      splashColor: Colors.white,
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      )))
            ]);
          } else {
            return Text("hello");
          }
        },
      ),
    );
  }
  */

  Widget ChatMessagesListWidget(userid) {
    return Flexible(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('message')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection(userid)
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            listItem = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  buildChatLayout(snapshot.data.documents[index], userid),
            );
          }
        },
      ),
    );
  }

  Widget buildChatLayout(QueryDocumentSnapshot chatid, userid) {
    return Column(children: [
      Flexible(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('message')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection(userid)
                .where('chatid', isEqualTo: chatid)
                .snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        if (snapshot.hasData) {
                          return Text(
                            "Chat " + data["sendername"],
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromRGBO(183, 129, 129, 1)),
                          );
                        }

                        children:
                        <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: chatid['senderUid'] ==
                                      FirebaseAuth.instance.currentUser.uid
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: <Widget>[
                                chatid['senderUid'] ==
                                        FirebaseAuth.instance.currentUser.uid
                                    ? CircleAvatar(
                                        backgroundImage: chatid['senderimg'] ==
                                                null
                                            ? AssetImage(
                                                'assets/blankimage.png')
                                            : NetworkImage(chatid['senderimg']),
                                        radius: 20.0,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: chatid['recimg'] ==
                                                null
                                            ? AssetImage(
                                                'assets/blankimage.png')
                                            : NetworkImage(chatid['recimg']),
                                        radius: 20.0,
                                      ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    chatid['senderUid'] ==
                                            FirebaseAuth
                                                .instance.currentUser.uid
                                        ? new Text(
                                            chatid['sendername'] == null
                                                ? ""
                                                : chatid['sendername'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : new Text(
                                            chatid['recname'] == null
                                                ? ""
                                                : chatid['recname'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                    chatid['type'] == 'text'
                                        ? new Text(
                                            chatid['message'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0),
                                          )
                                        : InkWell(
                                            onTap: (() {}),
                                          )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ];
                      });
            }),
      )
    ]);
  }
}

class SimpleDialog extends StatelessWidget {
  final title;
  SimpleDialog(this.title);
  Color g2 = Color.fromRGBO(93, 96, 99, 1);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    );
  }
}
