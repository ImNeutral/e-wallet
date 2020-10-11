import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String from;
  final String to;
  final double amount;
  final Timestamp dateAdded;

  TransactionModel({this.id, this.from, this.to, this.amount, this.dateAdded});

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    var _amount = data['amount'] ?? 0;
    return TransactionModel(
      id: doc.id,
      from: data['from'] ?? '',
      to: data['to'] ?? '',
      amount: _amount / 1.0,
      dateAdded: data['date_added'],
    );
  }
}
