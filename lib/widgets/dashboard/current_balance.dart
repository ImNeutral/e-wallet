import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:e_wallet/util/custom_format_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentBalance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).userModel;

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
                    if (user != null) ...[
                      Text(
                        CustomFormatUtil().formatIntAsCurrency(user.balance),
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .color),
                      ),
                    ],
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
