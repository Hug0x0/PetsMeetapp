import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateStrolls extends StatefulWidget {
  CreateStrolls({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _CreateStrolls();
  }
}

class _CreateStrolls extends State<CreateStrolls> {
  String currentUser;
  final TextEditingController _creatorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool hasClick = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                            _descriptionController.text);
                      }
                    },
                  ),
                )
              ]),
            ),
          )),
    );
  }

  Future<void> createScroll(String creator, String description) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('strolls');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    users.add({'creator': creator, 'description': description, 'uid': uid});
    return;
  }
}
