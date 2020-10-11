import 'package:e_wallet/providers/auth_provider.dart';
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
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Saved contact List'),
            leading: Icon(Icons.contacts),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app.
              // ...
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
