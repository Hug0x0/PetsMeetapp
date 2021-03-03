import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pets_meet/screens/connection.dart';
import 'package:pets_meet/screens/register.dart';
import 'Home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//3
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      home: Register(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "ff",
//       //home: _RegisterEmailSection(),
//     );
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: Text('Pet\'s Meet'),
//     //   ),
//     //   body: _RegisterEmailSection(),
//     //   // Builder(builder: (BuildContext context) {
//     //   //   return ListView(
//     //   //     scrollDirection: Axis.vertical,
//     //   //     padding: const EdgeInsets.all(16),
//     //   //     children: <Widget>[
//     //   //       // _RegisterEmailSection(),
//     //   //       // _EmailPasswordForm(),
//     //   //     ],
//     //   //   );
//     //   // }),
//     // );
//   }
// }

// // class _RegisterEmailSection extends StatefulWidget {
// //   @override
// //   _RegisterEmailSectionState createState() => _RegisterEmailSectionState();
// // }

// // class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //   bool hasClick;
// //   String createAccountMessage;
// //   bool _success;
// //   String _userEmail;

// //   void dispose() {
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Form(
// //       key: _formKey,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: <Widget>[
// //           TextFormField(
// //             controller: _emailController,
// //             decoration: const InputDecoration(labelText: 'Email'),
// //             validator: (String value) {
// //               if (value.isEmpty) {
// //                 return 'Veuillez entrer votre email.';
// //               }
// //               return null;
// //             },
// //           ),
// //           TextFormField(
// //             controller: _passwordController,
// //             decoration: const InputDecoration(labelText: 'Password'),
// //             validator: (String value) {
// //               if (value.isEmpty) {
// //                 return 'Veuillez entrer votre mot de passe.';
// //               }
// //               return null;
// //             },
// //           ),
// //           Container(
// //             padding: const EdgeInsets.symmetric(vertical: 16.0),
// //             alignment: Alignment.center,
// //             // ignore: deprecated_member_use
// //             child: RaisedButton(
// //               onPressed: () async {
// //                 if (_formKey.currentState.validate()) {
// //                   hasClick = true;
// //                   _register();
// //                 }
// //               },
// //               child: const Text('Créer un compte'),
// //             ),
// //           ),
// //           Container(
// //             alignment: Alignment.center,
// //             child: hasClick == true
// //                 ? Text(
// //                     createAccountMessage,
// //                     style: TextStyle(color: Colors.red),
// //                   )
// //                 : Text(''),
// //           )
// //         ],
// //       ),
// //     );
// //   }

// //   void _register() async {
// //     if (_passwordController.text.length < 6) {
// //       setState(() {
// //         createAccountMessage =
// //             'Entrez un mot de passe de plus de 6 caractères.';
// //       });
// //     }
// //     final User user = (await _auth.createUserWithEmailAndPassword(
// //       email: _emailController.text,
// //       password: _passwordController.text,
// //     ))
// //         .user;

// //     try {
// //       await user.sendEmailVerification();
// //     } catch (e) {
// //       print("An error occured while trying to send email verification");
// //       print(e.message);
// //     }
// //     if (user != null) {
// //       setState(() {
// //         _success = true;
// //         _userEmail = _emailController.text;
// //         _emailController.text = '';
// //         _passwordController.text = '';
// //       });
// //     } else {
// //       setState(() {
// //         _success = false;
// //       });
// //     }

// //     if (_success) {
// //       setState(() {
// //         createAccountMessage =
// //             'Votre compte à bien été créé, veuillez consulter votre boite mail !';
// //       });
// //     } else {
// //       setState(() {
// //         createAccountMessage = 'Une erreur est survenue, veuillez réessayer.';
// //       });
// //     }
// //   }
// // }

// // class _EmailPasswordForm extends StatefulWidget {
// //   @override
// //   _EmailPasswordFormState createState() => _EmailPasswordFormState();
// // }

// // class _EmailPasswordFormState extends State<_EmailPasswordForm> {
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// //   bool _success = false;
// //   String _userEmail;
// //   bool hasClick = false;

// //   String createAccountMessage;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Form(
// //       key: _formKey,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: <Widget>[
// //           Container(
// //             child: const Text('Test sign in with email and password'),
// //             padding: const EdgeInsets.all(16),
// //             alignment: Alignment.center,
// //           ),
// //           TextFormField(
// //             controller: _emailController,
// //             decoration: const InputDecoration(labelText: 'Email'),
// //             validator: (String value) {
// //               if (value.isEmpty) {
// //                 return 'Veuillez entrer votre email.';
// //               }
// //               return null;
// //             },
// //           ),
// //           TextFormField(
// //             controller: _passwordController,
// //             decoration: const InputDecoration(labelText: 'Password'),
// //             validator: (String value) {
// //               if (value.isEmpty) {
// //                 return 'Veuillez entrer votre mot de passe.';
// //               }
// //               return null;
// //             },
// //           ),
// //           Container(
// //             padding: const EdgeInsets.symmetric(vertical: 16.0),
// //             alignment: Alignment.center,
// //             child: RaisedButton(
// //               child: const Text('Se connecter'),
// //               onPressed: () async {
// //                 if (_formKey.currentState.validate()) {
// //                   hasClick = true;
// //                   _signInWithEmailAndPassword();
// //                 }
// //               },
// //             ),
// //           ),
// //           Container(
// //             alignment: Alignment.center,
// //             padding: const EdgeInsets.symmetric(horizontal: 20),
// //             child: hasClick == true
// //                 ? Text(
// //                     createAccountMessage,
// //                     style: TextStyle(color: Colors.red),
// //                   )
// //                 : Text(''),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _signInWithEmailAndPassword() async {
// //     if (_passwordController.text.length < 6) {
// //       setState(() {
// //         createAccountMessage =
// //             'Entrez un mot de passe de plus de 6 caractères.';
// //       });
// //     }
// //     final User user = (await _auth.signInWithEmailAndPassword(
// //       email: _emailController.text,
// //       password: _passwordController.text,
// //     ))
// //         .user;

// //     if (user != null) {
// //       if (user.emailVerified) {
// //         print(user.emailVerified);
// //         setState(() {
// //           _success = true;
// //           _userEmail = user.email;
// //           Navigator.push(
// //               context, MaterialPageRoute(builder: (context) => Home()));
// //         });
// //       } else {
// //         _emailController.text = '';
// //         _passwordController.text = '';
// //         setState(() {
// //           _success = false;
// //         });
// //       }
// //     } else {
// //       setState(() {
// //         _success = false;
// //       });
// //     }
// //     if (_success) {
// //       setState(() {
// //         createAccountMessage = 'Authentification réussi !';
// //       });
// //     } else {
// //       setState(() {
// //         createAccountMessage =
// //             'Authentification échoué. Créer un compte ou consulter votre boite mail afin de valider votre compte';
// //       });
// //     }
// //   }
// // }
