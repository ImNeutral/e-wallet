import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/transaction_provider.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:e_wallet/util/custom_format_util.dart';
import 'package:e_wallet/util/decimal_input_formatter.dart';
import 'package:e_wallet/validators/add_balance_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class AddBalance extends StatefulWidget {
  final String routeName = '/add-balance';

  @override
  _AddBalanceState createState() => _AddBalanceState();
}

class _AddBalanceState extends State<AddBalance> {
  final _addBalanceFormKey = GlobalKey<FormState>();
  final oCcy = new NumberFormat("#,###.00", "en_US");
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;
  int amountIntValue = 0;

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).userModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Balance'),
        elevation: 0,
      ),
      body: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: IntrinsicWidth(
            stepWidth: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: [
                    Text('Current Balance:'),
                    if (user != null) ...[
                      Text(
                        CustomFormatUtil().formatIntAsCurrency(user.balance),
                      )
                    ]
                  ],
                ),
                Row(
                  children: [
                    Text('New Balance:'),
                    if (user != null) ...[
                      Text(
                        CustomFormatUtil().formatIntAsCurrencyAdd(
                          user.balance,
                          amountIntValue,
                        ),
                      ),
                    ]
                  ],
                ),
                Form(
                  key: _addBalanceFormKey,
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Text('Transaction Date:'),
                        Text('April 12, 2020')
                      ],
                    ),
                    TextFormField(
                      controller: _amountController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'Amount'),
                      inputFormatters: [
                        DecimalInputFormatter(),
                      ],
                      validator: (value) {
                        return AddBalanceValidator().amount(amountIntValue);
                      },
                      onChanged: (value) async {
                        onAmountValueChange(value);
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
                    if (!isLoading) ...[
                      RaisedButton(
                        onPressed: () => {addBalanceSubmitForm(context, user)},
                        child: Text('Add Amount'),
                      )
                    ],
                    if (isLoading) ...[CircularProgressIndicator()],
                  ]),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void onAmountValueChange(String amount) {
    double doubleVal = 0;
    try {
      doubleVal = double.parse(amount);
    } catch (e) {}
    setState(() {
      amountIntValue = (doubleVal * 100).round();
    });
  }

  void addBalanceSubmitForm(BuildContext context, UserModel user) {
    if (_addBalanceFormKey.currentState.validate()) {
      var from = 'System';
      setIsLoading(true);
      UserProvider().addBalance(user, amountIntValue);
      TransactionProvider()
          .createTransaction(
        from,
        _descriptionController.text,
        amountIntValue,
        context,
      )
          .whenComplete(
        () async {
          await Future.delayed(Duration(seconds: 1));
          setIsLoading(false);
          Navigator.pop(context);
        },
      );
    }
  }

  void setIsLoading(bool _isLoading) {
    if (mounted) {
      setState(() {
        isLoading = _isLoading;
      });
    }
  }
}
