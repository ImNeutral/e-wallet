import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/models/transaction_model.dart';
import 'package:e_wallet/util/global_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  int limit = 1;
  List<TransactionModel> transactionList;

  TransactionProvider() {
    initUserTransactions();
  }

  void initUserTransactions() {
    _auth.authStateChanges().listen((event) {
      if (event != null) {
        streamAllTransactions().listen((_transactionList) {
          this.transactionList = _transactionList;
          notifyListeners();
        });
      }
    });
  }

  Stream<List<TransactionModel>> streamAllTransactions() {
    var ref = _db.collection('transactions');
    return ref
        .where('usersInTransaction', arrayContains: _auth.currentUser.uid)
        .orderBy('date_added', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => TransactionModel.fromFirestore(doc))
            .toList());
  }

  Future<List<TransactionModel>> getTransactions(int limit) {
    var ref = _db.collection('transactions');
    if (limit >= 1) {
      return ref
          .where('usersInTransaction', arrayContains: _auth.currentUser.uid)
          .limit(limit)
          .orderBy('date_added', descending: true)
          .get()
          .then(
            (snap) => snap.docs
                .map((doc) => TransactionModel.fromFirestore(doc))
                .toList(),
          );
    } else {
      return getAllTransactions();
    }
  }

  Future<List<TransactionModel>> getAllTransactions() {
    var ref = _db.collection('transactions');
    return ref
        .where('usersInTransaction', arrayContains: _auth.currentUser.uid)
        .orderBy('date_added', descending: true)
        .get()
        .then(
          (snap) => snap.docs
              .map((doc) => TransactionModel.fromFirestore(doc))
              .toList(),
        );
  }

  Future createTransaction(
      String from, String to, String _description, int _amount) async {
    var ref = _db.collection('transactions');
    await ref.doc().set({
      'from': from,
      'to': to,
      'amount': _amount,
      'date_added': DateTime.now(),
      'description': _description,
      'usersInTransaction': [from, to],
    });
  }

  void addLimit(int _limit) {
    this.limit += _limit;
  }
}
