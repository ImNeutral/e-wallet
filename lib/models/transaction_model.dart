import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String from;
  final String to;
  final int amount;
  final Timestamp dateAdded;
  final String description;
  final List usersInTransaction;

  TransactionModel({
    this.id,
    this.from,
    this.to,
    this.amount,
    this.dateAdded,
    this.description,
    this.usersInTransaction,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    var _amount = data['amount'] ?? 0;
    return TransactionModel(
      id: doc.id,
      from: data['from'] ?? '',
      to: data['to'] ?? '',
      amount: _amount,
      dateAdded: data['date_added'],
      description: data['description'],
      usersInTransaction: data['usersInTransaction'],
    );
  }
}
