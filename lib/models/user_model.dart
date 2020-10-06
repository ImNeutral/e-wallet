import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String id;

  UserModel({this.name, this.email, this.id});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return UserModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      id: doc.id,
    );
  }
}
