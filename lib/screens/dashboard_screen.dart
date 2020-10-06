import 'package:e_wallet/providers/auth_provider.dart';
import 'package:e_wallet/widgets/auth/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: CustomPaint(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Text('Hello worlds'),
              RaisedButton(
                onPressed: () => AuthProvider().logout(),
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
