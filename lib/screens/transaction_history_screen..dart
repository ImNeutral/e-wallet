import 'package:e_wallet/widgets/dashboard/list_transactions.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  final String routeName = '/transaction-history';

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
        elevation: 0,
      ),
      body: Builder(builder: (context) {
        return ListTransactions(10);
      }),
    );
  }
}
