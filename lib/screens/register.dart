import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_meet/screens/connection.dart';
import 'package:pets_meet/routes.dart';
import 'package:pets_meet/routing.dart';
import 'package:pets_meet/screens/home.dart';
import 'package:pets_meet/screens/navigation.dart';
import 'package:pets_meet/services/firebaseServices.dart';
import '../widget/button/customButton.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseServices _auth = FirebaseServices();

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Créer un compte,",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Inscrivez-vous pour commencer!",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                  ),
                ],
              ),
              Column(children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _firstnameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer un prénom.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Prénom",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _lastnameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer un nom.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Nom",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) =>
                            EmailValidator.validate(_emailController.text)
                                ? null
                                : "Veuillez entrer un email valide.",
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer un password.';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Mot de passe",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        child: FlatButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              hasClick = true;
                              _register();
                            }
                          },
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff71afff),
                                  Color(0xff529cfa),
                                  Color(0xff1b7bf5),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(
                                  minHeight: 50, maxWidth: double.infinity),
                              child: Text(
                                "S'inscrire",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
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
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              ]),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Je suis déjà membre.",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Routing.navigateToScreen(context, Routes.Connection);
                      },
                      child: Text(
                        " S'identifier",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void _register() async {
  //   if (_passwordController.text.length < 6) {
  //     setState(() {
  //       createAccountMessage =
  //           'Entrez un mot de passe de plus de 6 caractères.';
  //     });
  //   }
  //   final User user = (await _auth.createUserWithEmailAndPassword(
  //     email: _emailController.text,
  //     password: _passwordController.text,
  //   ))
  //       .user;
  //   try {
  //     await user.sendEmailVerification();
  //   } catch (e) {
  //     print("An error occured while trying to send email verification");
  //     print(e.message);
  //   }
  //   if (user != null) {
  //     setState(() {
  //       _success = true;
  //       _userEmail = _emailController.text;
  //     });
  //   } else {
  //     setState(() {
  //       _success = false;
  //     });
  //   }

  //   if (_success) {
  //     setState(() {
  //       createAccountMessage =
  //           'Votre compte à bien été créé, veuillez consulter votre boite mail !';
  //       _userStore(_lastnameController.text, _firstnameController.text,
  //           _emailController.text);
  //       _emailController.text = '';
  //       _passwordController.text = '';
  //       _lastnameController.text = '';
  //       _firstnameController.text = '';
  //       Routing.navigateToScreen(context, Routes.Navigation);
  //     });
  //   } else {
  //     setState(() {
  //       createAccountMessage = 'Une erreur est survenue, veuillez réessayer.';
  //     });
  //   }
  // }

  void _register() async {
    if (_passwordController.text.length < 6) {
      setState(() {
        createAccountMessage =
            'Entrez un mot de passe de plus de 6 caractères.';
      });
    }
    final User user = (await _auth.createNewUser(
      _emailController.text,
      _passwordController.text,
    ))
        .user;
    try {
      print("ici $user ${user.email}");
      await user.sendEmailVerification();
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
    }
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = _emailController.text;
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
        _userStore(_lastnameController.text, _firstnameController.text,
            _emailController.text);
        _emailController.text = '';
        _passwordController.text = '';
        _lastnameController.text = '';
        _firstnameController.text = '';
        Routing.navigateToScreen(context, Routes.Navigation);
      });
    } else {
      setState(() {
        createAccountMessage = 'Une erreur est survenue, veuillez réessayer.';
      });
    }
  }

  Future<void> _userStore(
      String lastname, String firstname, String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    users.add({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'uid': uid
    });
    return;
  }
}
