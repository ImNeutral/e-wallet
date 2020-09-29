import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String fullName;
  final String userId;
  final String id;

  User({this.fullName, this.userId, this.id});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return User (
        fullName: data['full_name'] ?? '',
        userId: data['user_id'] ?? '',
        id: doc.id
    );
  }
}