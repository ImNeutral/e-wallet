import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactList extends StatelessWidget {
  int getContactListSize(UserModel user) {
    var size = 0;
    if (user != null && user.contactList != null) {
      size = user.contactList.length;
    }
    return size;
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).userModel;
    var size = getContactListSize(user);
    if (size == 0) {
      return Text('You have currently no saved contact!');
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: size,
        itemBuilder: (context, i) {
          return Column(
            children: [
              ListTile(
                title: Text(user.contactList[i]),
                leading: Icon(Icons.contact_mail),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context, user.contactList[i]);
                },
              ),
              Divider(),
            ],
          );
        },
      );
    }
  }
}
