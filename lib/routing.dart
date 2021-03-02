import 'package:flutter/material.dart';
import 'package:pets_meet/routes.dart';
import 'package:pets_meet/screens/navigation.dart';
import 'package:pets_meet/screens/connection.dart';
import 'package:pets_meet/screens/register.dart';

class Routing {
  static void navigateToScreen(BuildContext context, Routes route) {
    switch (route) {
      case Routes.Connection:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EmailPasswordForm()));
        break;
      case Routes.Register:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RegisterEmailSection()));
        break;
      case Routes.Navigation:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navigation()));
        break;
    }
  }
}
