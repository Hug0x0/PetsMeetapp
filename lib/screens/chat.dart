import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:pets_meet/screens/home.dart';
import 'message.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  final String userId;
  final String userFirstname;
  final String userLastname;
  final DocumentSnapshot doc;

  Chat(
      {Key key,
      @required this.userId,
      this.userFirstname,
      this.userLastname,
      this.doc});

  @override
  State<StatefulWidget> createState() {
    return new _Chat();
  }
}

class _Chat extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  final User user = FirebaseAuth.instance.currentUser;
  final msg = FirebaseFirestore.instance.collection("message");

  // sendMessage(String message) {
  //   if (message.isNotEmpty) {
  //     FirebaseFirestore.instance.collection("message").doc(widget.userId).set({
  //       'sendTo': widget.userId,
  //       'sendFrom': FirebaseAuth.instance.currentUser.uid,
  //       'message': message,
  //       'timeOf': DateTime.now()
  //     });
  //   }
  // }

  sendMessage(User me, DocumentSnapshot partenaire, String text) async {
    DateTime date = await NTP.now();
    Map<String, dynamic> map = {
      "idMessage": getMessageRef(me.uid, widget.userId),
      "from": me.uid,
      "to": widget.userId,
      "message": text,
      "dateString": date.toString()
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('message');
    collectionReference.add(map);
  }

  getMessageRef(String from, String to) {
    List<String> list = [from, to];
    list.sort((a, b) => a.compareTo(b));
    String ref = "";
    for (var x in list) {
      ref += x + '+';
    }
    return ref;
  }

  test() {
    return Column(children: [
      Text("test"),
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('message')
              .where(
                "idMessage",
                isEqualTo: getMessageRef(
                  widget.userId,
                  user.uid,
                ),
              )
              .orderBy("dateString", descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              return ListView(
                  children: documents
                      .map((doc) => Card(
                              child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(doc['message']),
                              ],
                            ),
                          )))
                      .toList());
            } else if (snapshot.hasError) {
              print(snapshot.error);
              print(snapshot.data);
              return Text('Bug#1');
            }
            return CircularProgressIndicator();
          })
    ]);
  }

  Widget screen() {
    return new Scaffold(
      appBar: new AppBar(
          elevation: 0.0,
          title: new Text(
            widget.userFirstname.toString() +
                ' ' +
                widget.userLastname.toString(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Flexible(
                  flex: 3,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('message')
                          .where(
                            "idMessage",
                            isEqualTo: getMessageRef(
                              user.uid,
                              widget.userId,
                            ),
                          )
                          .orderBy("dateString", descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("j'ai des dataaaaaaaaaas");
                          final List<DocumentSnapshot> documents =
                              snapshot.data.docs;
                          return ListView(
                              children: documents
                                  .map(
                                    (doc) => Container(
                                      padding: EdgeInsets.only(
                                          left: 14,
                                          right: 14,
                                          top: 10,
                                          bottom: 10),
                                      child: Align(
                                        alignment: (doc['to'] == widget.userId
                                            ? Alignment.topLeft
                                            : Alignment.topRight),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: (doc['to'] == widget.userId
                                                ? Colors.grey.shade200
                                                : Colors.blue[200]),
                                          ),
                                          padding: EdgeInsets.all(16),
                                          child: Text(
                                            doc['message'],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList());
                        } else if (snapshot.hasError) {
                          return Text('Bug#1');
                        }
                        return CircularProgressIndicator();
                      })),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     height: 30,
                  //     width: 30,
                  //     decoration: BoxDecoration(
                  //       color: Colors.lightBlue,
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //     child: Icon(
                  //       Icons.add,
                  //       color: Colors.white,
                  //       size: 20,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        sendMessage(user, widget.doc, _messageController.text);
                        _messageController.clear();
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: screen());
  }
}

//ici on affiche les messages
// child: FirestoreAnimatedList(
//   query: FirebaseFirestore.instance
//       .collection('message')
//       .where(
//         "idMessage",
//         isEqualTo: getMessageRef(
//           widget.userId,
//           FirebaseAuth.instance.currentUser.uid,
//         ),
//       )
//       .orderBy("dateString", descending: true),
//   reverse: true,
//   itemBuilder: (BuildContext ctx, DocumentSnapshot snap,
//       Animation<double> animation, int index) {
//     return Text("test");
//   },
// ),
