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
        streamAllTransactions(event.uid).listen((_transactionList) {
          this.transactionList = _transactionList;
          notifyListeners();
        });
      }
    });
  }

  Stream<List<TransactionModel>> streamAllTransactions(String uid) {
    var ref = _db.collection('transactions');
    return ref
        .where('usersInTransaction', arrayContains: uid)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => TransactionModel.fromFirestore(doc))
            .toList());
  }

  Future<List<TransactionModel>> getTransactions(int limit) {
    var ref = _db.collection('transactions');
    return ref
        .where('usersInTransaction', arrayContains: _auth.currentUser.uid)
        .limit(limit)
        .get()
        .then(
          (snap) => snap.docs
              .map((doc) => TransactionModel.fromFirestore(doc))
              .toList(),
        );
    // .map((snap) => snap.docs
    //     .map((doc) => TransactionModel.fromFirestore(doc))
    //     .toList());
  }

  Future createTransaction(String from, String _description, int _amount,
      BuildContext context) async {
    var ref = _db.collection('transactions');
    await ref.doc().set({
      'from': from,
      'to': _auth.currentUser.uid,
      'amount': _amount,
      'date_added': DateTime.now(),
      'description': _description,
      'usersInTransaction': [from, _auth.currentUser.uid],
    }).whenComplete(() => Show(context, 'Balance Successfully added!'));
  }

  void addLimit(int _limit) {
    this.limit += _limit;
  }
}
