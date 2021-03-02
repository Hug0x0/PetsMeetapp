import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_meet/main.dart';
import 'package:pets_meet/screens/connection.dart';
import 'package:pets_meet/routes.dart';
import 'package:pets_meet/routing.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterEmailSection extends StatefulWidget {
  @override
  _RegisterEmailSectionState createState() => _RegisterEmailSectionState();
}

class _RegisterEmailSectionState extends State<RegisterEmailSection> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hasClick;
  String createAccountMessage;
  bool _success;
  String _userEmail;

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Veuillez entrer votre email.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe.';
                    }
                    return null;
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        hasClick = true;
                        _register();
                      }
                    },
                    child: const Text('Créer un compte'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () {
                      Routing.navigateToScreen(context, Routes.Navigation);
                    },
                    child: const Text('Test'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: hasClick == true
                      ? Text(
                          createAccountMessage,
                          style: TextStyle(color: Colors.red),
                        )
                      : Text(''),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmailPasswordForm()));
                        },
                        child: Text('Avez vs deja un compte ?'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _register() async {
    if (_passwordController.text.length < 6) {
      setState(() {
        createAccountMessage =
            'Entrez un mot de passe de plus de 6 caractères.';
      });
    }
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    try {
      await user.sendEmailVerification();
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
    }
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = _emailController.text;
        _emailController.text = '';
        _passwordController.text = '';
      });
    } else {
      setState(() {
        _success = false;
      });
    }

    if (_success) {
      setState(() {
        createAccountMessage =
            'Votre compte à bien été créé, veuillez consulter votre boite mail !';
        _userStore("test");
      });
    } else {
      setState(() {
        createAccountMessage = 'Une erreur est survenue, veuillez réessayer.';
      });
    }
  }

  Future<void> _userStore(String name) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    users.add({'name': name, 'uid': uid});
    return;
  }
}
