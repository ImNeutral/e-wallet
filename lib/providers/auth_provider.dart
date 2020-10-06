import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future login(String _email, String _password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } catch (e) {
      FirebaseAuthException error = e;
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
    }
  }

  Future register(String name, String _email, String _password,
      BuildContext context) async {
    try {
      UserCredential userCreds = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      User user = userCreds.user;
      await _db.collection('users').doc(user.uid).set({'name': name});
    } catch (e) {
      FirebaseAuthException error = e;
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
    }
  }

  Future logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // StreamSubscription<User> currentUser() {
  //   return FirebaseAuth.instance.authStateChanges().listen((user) {
  //     return user;
  //   });
  // }
}
