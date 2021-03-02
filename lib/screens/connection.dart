import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_meet/screens/navigation.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class EmailPasswordForm extends StatefulWidget {
  @override
  _EmailPasswordFormState createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<EmailPasswordForm> {
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
        appBar: AppBar(
          title: Text("CO"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: const Text('Test sign in with email and password'),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
              ),
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
                child: RaisedButton(
                  child: const Text('Se connecter'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      hasClick = true;
                      _signInWithEmailAndPassword();
                    }
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: hasClick == true
                    ? Text(
                        createAccountMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    : Text(''),
              ),
            ],
          ),
        ));
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Navigation()));
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
