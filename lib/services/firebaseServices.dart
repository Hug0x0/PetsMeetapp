import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createNewUser(String email, String password) async {
    try {
      final User result = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  Future connectionEmailAndPassword(String email, String password) async {
    try {
      final User result = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future userAddStore(String lastname, String firstname, String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String uid = _auth.currentUser.uid.toString();
    users.add({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'uid': uid
    });
    return;
  }
}
