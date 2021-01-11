import 'package:e_wallet/screens/add_balance_screen.dart';
import 'package:e_wallet/screens/custom_drawer.dart';
import 'package:e_wallet/screens/my_qr_code_screen.dart';
import 'package:e_wallet/screens/send_money_screen.dart';
import 'package:e_wallet/widgets/dashboard/current_balance.dart';
import 'package:e_wallet/widgets/dashboard/list_transactions.dart';
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
      body: Container(
        child: Wrap(
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
                title: Text('Send Money'),
                leading: Icon(Icons.payment),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, Pay().routeName);
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('My QR Code'),
                leading:
                    Image.asset("assets/images/icons/qr_code_lead_trail.png"),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, MyQrCode().routeName);
                },
              ),
            ),
            Card(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          'Last',
                        ),
                        Text(
                          ' 5 ',
                        ),
                        Text(
                          'Transactions',
                        ),
                      ],
                    ),
                  ),
                  // ListTransactions(),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: ListTransactions(5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
