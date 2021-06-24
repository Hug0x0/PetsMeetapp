import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_meet/screens/chat.dart';
import 'package:pets_meet/screens/home.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  User currentUser;

  Widget _listOfUsers() {
    return Column(
      children: [
        Flexible(
          flex: 6,
          child: StreamBuilder<QuerySnapshot>(
              stream: databaseReference
                  .collection('users')
                  .where('uid', isNotEqualTo: currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView(
                      children: documents
                          .map((doc) => Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(doc['imageProfile'])),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(doc['firstName']),
                                      Text(doc['lastName'])
                                    ],
                                  ),
                                  onTap: () {
                                    print(doc.id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Chat(
                                              userId: doc['uid'],
                                              userFirstname: doc['firstName'],
                                              userLastname: doc['lastName'],
                                              doc: doc),
                                        ));
                                  },
                                ),
                              ))
                          .toList());
                } else if (snapshot.hasError) {
                  return Text('Bug#1');
                }
                return CircularProgressIndicator();
              }),
        ),
      ],
    );
  }

  @override
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _listOfUsers());
  }
}
