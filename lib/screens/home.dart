import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_meet/screens/strollDetails.dart';

final databaseReference = FirebaseFirestore.instance;
// RECUP TT LES IDS
// final strollsRef = FirebaseFirestore.instance.collection('strolls');

class Home extends StatelessWidget {
  //  FUNCTION POUR AFFICHER LES IDS DE TOUTES LES BALADES
  //   @override
  // void initState() {
  //   getStrolls();
  //   super.initState();
  // }
  //  FUNCTION POUR AFFICHER LES IDS DE TOUTES LES BALADES
  //   getStrolls() {
  //   strollsRef.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  //       print(doc.id);
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: databaseReference.collection('strolls').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("good");
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return ListView(
                children: documents
                    .map((doc) => Card(
                          child: ListTile(
                            title: Text(doc['creator']),
                            subtitle: Text(doc['description']),
                            onTap: () {
                              print(doc.id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StrollDetails(
                                            strollId: doc.id,
                                          )));
                            },
                          ),
                        ))
                    .toList());
          } else if (snapshot.hasError) {
            return Text('Bug#1');
          }
          return Text("bug#2");
        });
  }
}
