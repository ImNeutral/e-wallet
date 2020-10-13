import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final int balance;

  UserModel({this.id, this.firstName, this.lastName, this.email, this.balance});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    var _balance = data['balance'] ?? 0;
    return UserModel(
      id: doc.id,
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      email: data['email'] ?? '',
      balance: _balance,
    );
  }
}
