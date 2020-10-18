import 'package:e_wallet/models/transaction_model.dart';
import 'package:e_wallet/providers/transaction_provider.dart';
import 'package:e_wallet/util/custom_format_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTransactions extends StatefulWidget {
  final int size;
  ListTransactions(this.size);

  @override
  _ListTransactionsState createState() => _ListTransactionsState();
}

class _ListTransactionsState extends State<ListTransactions> {
  List<TransactionModel> transactionList;

  void setTransactions() {
    TransactionProvider().getTransactions(widget.size).then((value) => {
          setState(() {
            transactionList = value;
          })
        });
  }

  bool isDebit(String moneyFrom) {
    return moneyFrom == FirebaseAuth.instance.currentUser.uid;
  }

  Color amountColor(String moneyFrom) {
    return isDebit(moneyFrom) ? Colors.red : Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<TransactionProvider>(context)

    if (transactionList == null) {
      setTransactions();
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        setTransactions();
        return null;
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: transactionList.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      CustomFormatUtil().timeStampAsSimpleDate(
                          transactionList[i].dateAdded.toDate()),
                      style: TextStyle(color: Colors.grey),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          transactionList[i].description,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    if (isDebit(transactionList[i].from)) ...[Text('-')],
                    Text(
                      CustomFormatUtil()
                          .formatIntAsCurrency(transactionList[i].amount),
                      style: TextStyle(
                          color: amountColor(transactionList[i].from)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
