import 'package:flutter/material.dart';
import 'package:pets_meet/routes.dart';
import 'package:pets_meet/screens/forgotpassword.dart';
import 'package:pets_meet/screens/navigation.dart';
import 'package:pets_meet/screens/connection.dart';
import 'package:pets_meet/screens/register.dart';
import 'package:pets_meet/screens/strollDetails.dart';

class Routing {
  static void navigateToScreen(BuildContext context, Routes route) {
    switch (route) {
      case Routes.Connection:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Connection()));
        break;
      case Routes.Register:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Register()));
        break;
      case Routes.Navigation:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navigation()));
        break;
      case Routes.StrollDetails:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StrollDetails()));
        break;
      case Routes.ForgotPassword:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ForgotPassword()));
        break;
    }
  }
}
