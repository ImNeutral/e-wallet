import 'package:e_wallet/providers/auth_provider.dart';
import 'package:e_wallet/screens/contact_list_screen.dart';
import 'package:e_wallet/screens/transaction_history_screen..dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'E Wallet',
              style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryTextTheme.bodyText1.color),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Transaction History'),
            leading: Icon(Icons.assignment_turned_in),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, TransactionHistory().routeName);
            },
          ),
          ListTile(
            title: Text('Saved contact List'),
            leading: Icon(Icons.contacts),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ContactListScreen().routeName);
            },
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.pop(context);
              AuthProvider().logout();
            },
          ),
        ],
      ),
    );
  }
}
