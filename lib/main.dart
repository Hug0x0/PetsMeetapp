import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pets_meet/screens/connection.dart';
import 'package:pets_meet/screens/home.dart';
import 'package:pets_meet/screens/register.dart';
import 'package:pets_meet/screens/strollDetails.dart';
import 'screens/navigation.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Navigation());
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
