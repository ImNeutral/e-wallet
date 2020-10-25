import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/transaction_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  UserModel userModel;

  UserProvider() {
    setCurrentUser();
  }

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

  void setCurrentUser() {
    _auth.authStateChanges().listen((event) {
      if (event != null) {
        streamUser(event.uid).listen((_userModel) {
          this.userModel = _userModel;
          notifyListeners();
        });
      }
    });
  }

  Future addBalance(UserModel user, int balance) async {
    user.addBalance(balance);
    try {
      await _db.collection('users').doc(user.id).update(user.objectToMap());
    } catch (e) {}
  }

  void updateUser(UserModel _user) async {
    try {
      await _db.collection('users').doc(_user.id).update(_user.objectToMap());
    } catch (e) {}
  }

  Future<List<String>> sendMoney(
      UserModel user, int _amount, String payTo, String _description) async {
    List<String> errors = [];
    try {
      await _db.runTransaction((transaction) {
        return _db
            .collection('users')
            .where('email', isEqualTo: payTo)
            .limit(1)
            .get()
            .then((value) {
          if (value.docs.length > 0) {
            UserModel payToUser = UserModel.fromFirestore(value.docs[0]);
            payToUser.addBalance(_amount);
            print(payToUser.objectToMap());
            user.subtractBalance(_amount);
            updateUser(payToUser);
            updateUser(user);
            TransactionProvider().createTransaction(
                user.id, payToUser.id, _description, _amount);
          } else {
            errors.add('Destination User does not Exists');
          }
        });
      });
    } catch (e) {
      errors.add('An error has occured! Check your internet connection.');
    }
    return errors;
  }
}
