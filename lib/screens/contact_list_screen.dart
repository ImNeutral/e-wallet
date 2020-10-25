import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:e_wallet/widgets/contact_list/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactListScreen extends StatefulWidget {
  final String routeName = '/contact-list';

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        elevation: 0,
      ),
      body: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: ContactList(),
        );
      }),
    );
  }
}
