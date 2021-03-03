import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_meet/routes.dart';
import 'package:pets_meet/routing.dart';
import 'package:pets_meet/screens/navigation.dart';
import 'package:pets_meet/screens/register.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Connection extends StatefulWidget {
  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _success = false;
  String _userEmail;
  bool hasClick = false;

  String createAccountMessage;
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
                    "Pet's Meet App,",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Connectez-vous pour continuer!",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer votre email.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              fontSize: 14, color: Colors.grey.shade400),
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
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer votre mot de passe.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Mot de passe",
                          labelStyle: TextStyle(
                              fontSize: 14, color: Colors.grey.shade400),
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
                    ]),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Mot de passe oublié ?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          hasClick = true;
                          _signInWithEmailAndPassword();
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
                            "Connexion",
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
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {},
                      color: Colors.indigo.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/google.png",
                            height: 18,
                            width: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Connectez-vous avec Google",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {},
                      color: Colors.indigo.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/google.png",
                            height: 18,
                            width: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Connectez-vous avec Google",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {},
                      color: Colors.indigo.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/google.png",
                            height: 18,
                            width: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Connectez-vous avec Google",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Je suis un nouvel utilisateur.",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Routing.navigateToScreen(context, Routes.Register);
                      },
                      child: Text(
                        " S'inscrire",
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

  void _signInWithEmailAndPassword() async {
    if (_passwordController.text.length < 6) {
      setState(() {
        createAccountMessage =
            'Entrez un mot de passe de plus de 6 caractères.';
      });
    }
    final User user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      if (user.emailVerified) {
        print(user.emailVerified);
        setState(() {
          _success = true;
          _userEmail = user.email;
          Routing.navigateToScreen(context, Routes.Navigation);
        });
      } else {
        _emailController.text = '';
        _passwordController.text = '';
        setState(() {
          _success = false;
        });
      }
    } else {
      setState(() {
        _success = false;
      });
    }
    if (_success) {
      setState(() {
        createAccountMessage = 'Authentification réussi !';
      });
    } else {
      setState(() {
        createAccountMessage =
            'Authentification échoué. Créer un compte ou consulter votre boite mail afin de valider votre compte';
      });
    }
  }
}
