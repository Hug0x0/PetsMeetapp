import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_meet/services/firebaseServices.dart';

final databaseReference = FirebaseFirestore.instance;
final FirebaseServices _auth = FirebaseServices();

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 6,
          child: StreamBuilder<QuerySnapshot>(
              stream: databaseReference
                  .collection('strolls')
                  .where('creator_uid',
                      isEqualTo: _auth.currentUid().toString())
                  .orderBy("date", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView(
                      children: documents
                          .map((doc) => Card(
                                child: ListTile(
                                  leading: Icon(Icons.pets_outlined),
                                  trailing:
                                      Text(doc["date"] + " " + doc["hour"]),
                                  title: Text(doc['creator']),
                                  subtitle: Text(doc['participants']),
                                  onTap: () {
                                    //print(doc.id);
                                    print(_auth.currentUid());
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => StrollDetails(
                                    //       strollId: doc.id,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                ),
                              ))
                          .toList());
                } else if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Text(snapshot.error.toString());
                }
                return CircularProgressIndicator();
              }),
        ),
      ],
    );
  }
}
