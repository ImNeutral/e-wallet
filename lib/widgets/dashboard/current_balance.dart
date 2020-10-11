import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentBalance extends StatelessWidget {
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new AspectRatio(
        aspectRatio: 100 / 25,
        child: new Container(
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Php',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              .color),
                    ),
                    StreamBuilder<UserModel>(
                      stream: UserProvider().currentUser(),
                      builder: (context, snapshot) {
                        var user = snapshot.data;
                        if (user != null) {
                          return Text(
                            oCcy.format(user.balance),
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1
                                    .color),
                          );
                        } else {
                          return Text('0');
                        }
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Available Balance',
                    style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.bodyText1.color),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
