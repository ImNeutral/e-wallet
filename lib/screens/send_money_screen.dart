import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:e_wallet/screens/contact_list_screen.dart';
import 'package:e_wallet/util/custom_format_util.dart';
import 'package:e_wallet/util/decimal_input_formatter.dart';
import 'package:e_wallet/validators/add_balance_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Pay extends StatefulWidget {
  final String routeName = '/send-money';
  final String sendToAddress;

  Pay([this.sendToAddress = '']);

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  var parentContext = new GlobalKey<ScaffoldState>();
  final _addBalanceFormKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _sendToController = TextEditingController();

  bool addToContacts = false;
  bool confirmSend = false;
  bool isLoading = false;
  int amountIntValue = 0;
  UserModel user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context).userModel;
    var sendToArg = ModalRoute.of(context).settings.arguments;
    if (_sendToController.text == null ||
        _sendToController.text.length == 0 &&
            _sendToController.text != sendToArg) {
      _sendToController.text = ModalRoute.of(context).settings.arguments;
    }

    return Scaffold(
      key: parentContext,
      appBar: AppBar(
        title: Text('Send Money'),
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
                Form(
                  key: _addBalanceFormKey,
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Text('Transaction Date:'),
                        Text(
                          CustomFormatUtil()
                              .timeStampAsShortDate(DateTime.now()),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _sendToController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Send to',
                            ),
                            onChanged: (value) {
                              setState(() {
                                addToContacts = false;
                              });
                            },
                            validator: (value) {
                              return AddBalanceValidator()
                                  .sendTo(_sendToController.text);
                              ;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.contacts),
                          color: Colors.blue,
                          onPressed: () {
                            selectContact(context);
                          },
                        ),
                        IconButton(
                          icon: Image.asset("assets/images/icons/qr_code.png"),
                          color: Colors.blue,
                          onPressed: () async {
                            _sendToController.text = await scanner.scan();
                          },
                        ),
                      ],
                    ),
                    if (_sendToController.text.length > 0 &&
                        !user.contactList.contains(_sendToController.text)) ...[
                      CheckboxListTile(
                        title: Text("Add To Contacts"),
                        value: addToContacts,
                        onChanged: (newValue) {
                          setState(() {
                            addToContacts = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
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
                      decoration: InputDecoration(labelText: 'Message'),
                      validator: (value) {
                        return AddBalanceValidator().description(value);
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    if (!isLoading) ...[
                      RaisedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();

                          if (_addBalanceFormKey.currentState.validate()) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return confirmPayment();
                              },
                            );
                          }
                        },
                        child: Text('Send Money'),
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

  void paySubmitForm() {
    if (_addBalanceFormKey.currentState.validate() && confirmSend) {
      setIsLoading(true);
      UserProvider()
          .sendMoney(user, amountIntValue, _sendToController.text,
              _descriptionController.text)
          .then((value) async {
        if (value.length > 0) {
          parentContext.currentState
              .showSnackBar(SnackBar(content: Text(value[0])));
          setIsLoading(false);
        } else {
          if (addToContacts) {
            user.contactList.add(_sendToController.text);
            UserProvider().updateUser(user);
          }
          parentContext.currentState
              .showSnackBar(SnackBar(content: Text('Transaction Successful!')));
          await Future.delayed(Duration(seconds: 1));
          setIsLoading(false);
          Navigator.pop(parentContext.currentContext);
        }
      });
    }
  }

  void setIsLoading(bool _isLoading) {
    if (mounted) {
      setState(() {
        isLoading = _isLoading;
      });
    }
  }

  void confirmSendState(bool _confirmSend) {
    if (mounted) {
      setState(() {
        confirmSend = _confirmSend;
      });
    }
  }

  void selectContact(BuildContext context) async {
    _sendToController.text = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactListScreen(true),
      ),
    );
  }

  Widget confirmPayment() {
    Widget cancelButton = RaisedButton(
      child: Text("Cancel"),
      onPressed: () {
        confirmSendState(false);
        Navigator.of(context, rootNavigator: false).pop();
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Send"),
      onPressed: () {
        confirmSendState(true);
        paySubmitForm();
        Navigator.of(context, rootNavigator: false).pop();
      },
    );

    return AlertDialog(
      title: Text('Send Money Confirmation'),
      content: Text('Are you sure you want to send this amount?'),
      actions: [
        cancelButton,
        yesButton,
      ],
    );
  }
}
