import 'package:e_wallet/screens/add_balance_screen.dart';
import 'package:e_wallet/screens/custom_drawer.dart';
import 'package:e_wallet/widgets/dashboard/current_balance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: CustomPaint(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              CurrentBalance(),
              Card(
                child: ListTile(
                  title: Text('Add Balance'),
                  leading: Icon(Icons.add),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, AddBalance().routeName);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Pay'),
                  leading: Icon(Icons.payment),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
