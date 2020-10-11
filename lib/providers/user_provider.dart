import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<User> getUser(String id) async {
  //   var snap = await _db.collection('users').doc(id).get();
  //
  //   return User.fromFirestore(snap);
  // }

  Stream<UserModel> streamUser(String id) {
    return _db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => UserModel.fromFirestore(snap));
  }

  Stream<List<UserModel>> streamAllUsers() {
    var ref = _db.collection('users');
    return ref.snapshots().map((usersSnap) =>
        usersSnap.docs.map((doc) => UserModel.fromFirestore(doc)).toList());
  }

  Stream<UserModel> currentUser() {
    return streamUser(_auth.currentUser.uid);
  }
}
