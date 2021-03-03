import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _Home();
  }
}

class _Home extends State<Home> {
  String currentUser;
  final TextEditingController _creatorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool hasClick = false;
  int stroll_id = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          child: Text("Créer Balade"),
          onPressed: () {
            return showGeneralDialog(
              barrierLabel: "Barrier",
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: Duration(milliseconds: 700),
              context: context,
              pageBuilder: (_, __, ___) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    height: 600,
                    child: SizedBox.expand(
                        child: Form(
                      key: _formKey,
                      child: Scaffold(
                          appBar: AppBar(
                            title: Text('Créer une balade'),
                          ),
                          body: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Form(
                              child: Column(children: <Widget>[
                                TextFormField(
                                  controller: _creatorController,
                                  decoration:
                                      const InputDecoration(labelText: 'Nom'),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Veuillez entrer votre nom.';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                      labelText: 'Description'),
                                  validator: (String value) {
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _participantsController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      labelText: 'Nombre de participants'),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Veuillez entrer un nombre de participants';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _placeController,
                                  decoration:
                                      const InputDecoration(labelText: 'Place'),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Veuillez entrer une ville';
                                    }
                                    return null;
                                  },
                                ),
                                /*  TextFormField(
                                  controller: _dateController,
                                  decoration:
                                      const InputDecoration(labelText: 'Date'),
                                  validator: (String value) {
                                    return null;
                                  },
                                ),*/
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                    child: const Text('Créer balade'),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        // ignore: unnecessary_statements
                                        stroll_id++;
                                        hasClick = true;
                                        if (_creatorController
                                                .text.isNotEmpty ||
                                            _descriptionController
                                                .text.isNotEmpty ||
                                            _participantsController
                                                .text.isNotEmpty ||
                                            _placeController.text.isNotEmpty) {
                                          createScroll(
                                              _auth.currentUser.uid,
                                              _creatorController.text,
                                              _descriptionController.text,
                                              _participantsController.text,
                                              _placeController.text,
                                              stroll_id.toString());
                                        }
                                      }
                                    },
                                  ),
                                )
                              ]),
                            ),
                          )),
                    )),
                    margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
                  ),
                );
              },
              transitionBuilder: (_, anim, __, child) {
                return SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                      .animate(anim),
                  child: child,
                );
              },
            );
            ;
          }),
    );
    /*return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: Text(" Strolls create"),
          ),
          body: Container(
            child: Form(
              child: Column(children: <Widget>[
                TextFormField(
                  controller: _creatorController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Veuillez entrer votre nom.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (String value) {
                    return null;
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: RaisedButton(
                    child: const Text('Créer balade'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        hasClick = true;
                        createScroll(_creatorController.text,
                            _descriptionController.text, _auth.currentUser.uid);
                      }
                    },
                  ),
                )
              ]),
            ),
          )),
    ); */
  }

  Future<void> createScroll(String uid, String creator, String description,
      String participants, String place, String strollid) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('strolls');
    users.add({
      'creator_uid': uid,
      'creator': creator,
      'description': description,
      'place': place,
      'participant': participants,
      // 'date': date,
      'stroll_id': strollid
    });
    return;
  }
}
