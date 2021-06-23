import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> createNewUser(
      FirebaseAuth auth, String email, String password) async {
    try {
      final User result = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<User> connectionEmailAndPassword(
      FirebaseAuth auth, String email, String password) async {
    try {
      final User result = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  String currentUid() {
    try {
      return auth.currentUser.uid;
    } catch (e) {
      print(e.toString());
    }
  }

  Future userAddStore(
      String lastname, String firstname, String email, String password) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String uid = auth.currentUser.uid.toString();
    users.doc(uid).set({
      'firstName': firstname,
      'lastName': lastname,
      'email': email,
      'password': password,
      'uid': uid
    });
    return;
  }
}
