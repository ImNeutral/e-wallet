import 'package:e_wallet/models/transaction_model.dart';
import 'package:e_wallet/providers/transaction_provider.dart';
import 'package:e_wallet/validators/add_balance_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBalance extends StatefulWidget {
  final String routeName = '/add-balance';

  @override
  _AddBalanceState createState() => _AddBalanceState();
}

class _AddBalanceState extends State<AddBalance> {
  final _addBalanceKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Balance'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: IntrinsicWidth(
          stepWidth: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [Text('Current Balance:'), Text('1,000.00')],
              ),
              Row(
                children: [Text('New Balance:'), Text('1,200.00')],
              ),
              Form(
                key: _addBalanceKey,
                child: Column(children: <Widget>[
                  Row(
                    children: [
                      Text('Transaction Date:'),
                      Text('April 12, 2020')
                    ],
                  ),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Amount'),
                    validator: (value) {
                      return AddBalanceValidator().amount(value);
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      return AddBalanceValidator().description(value);
                    },
                  ),
                  RaisedButton(
                    onPressed: () => {},
                    child: Text('Add Amount'),
                  ),
                  StreamBuilder<List<TransactionModel>>(
                    stream: TransactionProvider().streamAllTransactions(),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      List<Widget> list = new List<Widget>();
                      for (var i = 0; data != null && i < data.length; i++) {
                        list.add(new Text(data[i].from));
                      }
                      return new Row(children: list);
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
