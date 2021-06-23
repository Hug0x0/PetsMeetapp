import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pets_meet/screens/addInformation.dart';
import 'package:pets_meet/screens/connection.dart';
import 'package:pets_meet/screens/home.dart';
import 'package:pets_meet/screens/navigation.dart';
import 'package:pets_meet/screens/register.dart';
import 'package:pets_meet/screens/updatepassword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Auth Demo',
      home: Register(),
    );
  }
}
