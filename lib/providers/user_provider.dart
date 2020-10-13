import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<User> getUser(String id) async {
  //   var snap = await _db.collection('users').doc(id).get();
  //
  //   return User.fromFirestore(snap);
  // }

  Stream<UserModel> streamUser(String id) {
    return _db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => UserModel.fromFirestore(snap));
  }

  Stream<List<UserModel>> streamAllUsers() {
    var ref = _db.collection('users');
    return ref.snapshots().map((usersSnap) =>
        usersSnap.docs.map((doc) => UserModel.fromFirestore(doc)).toList());
  }

  Stream<UserModel> currentUser() {
    if (_auth.currentUser != null) {
      return streamUser(_auth.currentUser.uid);
    }
    return null;
  }

  Future addBalance(UserModel user, int balance) async {
    try {
      await _db.collection('users').doc(_auth.currentUser.uid).set({
        'balance': user.balance + balance,
      });
    } catch (e) {}
  }
}
