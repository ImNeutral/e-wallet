import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  int balance;
  List contactList;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.balance,
      this.contactList});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return new UserModel(
      id: doc.id,
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      email: data['email'] ?? '',
      balance: data['balance'] ?? 0,
      contactList: data['contact_list'],
    );
  }

  void subtractBalance(int amount) {
    if (amount < 0) {
      amount = amount * -1;
    }
    this.balance -= amount;
  }

  void addBalance(int amount) {
    if (amount < 0) {
      amount = amount * -1;
    }
    this.balance += amount;
  }

  Map<String, dynamic> objectToMap() {
    return {
      'first_name': this.firstName,
      'last_name': this.lastName,
      'email': this.email,
      'balance': this.balance,
      'contact_list': this.contactList,
    };
  }
}
