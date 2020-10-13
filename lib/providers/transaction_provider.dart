import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/models/transaction_model.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:e_wallet/util/global_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<TransactionModel>> streamAllTransactions() {
    var ref = _db.collection('transactions');
    return ref.snapshots().map((snap) =>
        snap.docs.map((doc) => TransactionModel.fromFirestore(doc)).toList());
  }

  Future createTransaction(String from, String _description, int _amount,
      BuildContext context) async {
    var ref = _db.collection('transactions');
    await ref.doc(_auth.currentUser.uid).set({
      'from': from,
      'to': _auth.currentUser.uid,
      'amount': _amount,
      'date_added': DateTime.now().millisecondsSinceEpoch,
      'description': _description,
    }).whenComplete(() => Show(context, 'Balance Successfully added!'));
  }
}
