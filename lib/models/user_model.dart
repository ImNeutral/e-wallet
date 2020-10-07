import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String id;

  UserModel({this.firstName, this.lastName, this.id});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return UserModel(
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      id: doc.id,
    );
  }
}
