import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:pets_meet/routes.dart';
import 'package:pets_meet/routing.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _changePassword(String password) async {
    //Create an instance of the current user.
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User currentUser = firebaseAuth.currentUser;
    currentUser.updatePassword(password);
    print("yessss");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update password"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _passwordController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer votre email.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle:
                      TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: TextFormField(
                controller: _confirmpasswordController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer votre email.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Confirm password",
                  labelStyle:
                      TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FlatButton(
                onPressed: () {
                  if (_passwordController.text !=
                      _confirmpasswordController.text) {
                    return "Votre mot de passe doit etre similaire dans les champs";
                  }
                  if (_passwordController.text.isNotEmpty &&
                      _confirmpasswordController.text.isNotEmpty &&
                      _passwordController.text ==
                          _confirmpasswordController.text) {
                    print(_auth.currentUser.uid);
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(_auth.currentUser.uid)
                        .update({
                      'password': _passwordController.text,
                    });
                    _changePassword(_passwordController.text);
                    print("password update");
                  }
                },
                padding: EdgeInsets.all(0),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xff71afff),
                        Color(0xff529cfa),
                        Color(0xff1b7bf5),
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                        maxWidth: double.infinity, minHeight: 50),
                    child: Text(
                      "Réinitialiser votre mot de passe",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}