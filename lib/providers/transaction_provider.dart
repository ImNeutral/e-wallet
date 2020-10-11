import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/models/transaction_model.dart';

class TransactionProvider {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<TransactionModel>> streamAllTransactions() {
    var ref = _db.collection('transactions');
    return ref.snapshots().map((snap) =>
        snap.docs.map((doc) => TransactionModel.fromFirestore(doc)).toList());
  }
}
