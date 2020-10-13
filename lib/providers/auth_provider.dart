import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/util/global_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future login(String _email, String _password, BuildContext context) async {
    try {
      UserCredential userCreds = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      User user = userCreds.user;
      if (user != null && !user.emailVerified) {
        Show(context, 'Please verify your email first.');
        logout();
      }
    } catch (e) {
      FirebaseAuthException error = e;
      Show(context, error.message);
    }
  }

  Future register(String _firstName, String _lastName, String _email,
      String _password, BuildContext context) async {
    _email = _email != null ? _email.trim() : _email;
    try {
      UserCredential userCreds = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      User user = userCreds.user;
      if (user != null) {
        user.sendEmailVerification();
        Show(context,
            'Account created successfully, please verify your email to be able to login.');
        logout();
      }
      await _db.collection('users').doc(user.uid).set({
        'first_name': _firstName,
        'last_name': _lastName,
        'email': _email,
        'balance': 0,
      });
    } catch (e) {
      FirebaseAuthException error = e;
      Show(context, error.message);
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
