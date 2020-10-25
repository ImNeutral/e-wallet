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
  bool isDebit(String moneyFrom) {
    return moneyFrom == FirebaseAuth.instance.currentUser.uid;
  }

  Color amountColor(String moneyFrom) {
    return isDebit(moneyFrom) ? Colors.red : Colors.blue;
  }

  int listViewSize(int listSize, int declaredSize) {
    int listViewSize = 0;
    if (declaredSize != 0 && listSize >= declaredSize) {
      listViewSize = declaredSize;
    } else {
      listViewSize = listSize;
    }
    return listViewSize;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            Provider.of<TransactionProvider>(context).streamAllTransactions(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: listViewSize(snapshot.data.length, widget.size),
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
                                snapshot.data[i].dateAdded.toDate()),
                            style: TextStyle(color: Colors.grey),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Text(
                                snapshot.data[i].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          if (isDebit(snapshot.data[i].from)) ...[Text('-')],
                          Text(
                            CustomFormatUtil()
                                .formatIntAsCurrency(snapshot.data[i].amount),
                            style: TextStyle(
                                color: amountColor(snapshot.data[i].from)),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        });
  }
}
