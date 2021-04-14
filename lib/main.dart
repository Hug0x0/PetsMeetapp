import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pets_meet/screens/connection.dart';

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
      home: Connection(),
    );
  }
}
