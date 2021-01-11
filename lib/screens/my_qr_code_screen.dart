import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrCode extends StatefulWidget {
  final String routeName = '/my-qr-code';

  @override
  _MyQrCodeState createState() => _MyQrCodeState();
}

class _MyQrCodeState extends State<MyQrCode> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).userModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('My QR Code'),
        elevation: 0,
      ),
      body: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: QrImage(
            data: user.email,
            version: QrVersions.auto,
            size: double.infinity,
          ),
        );
      }),
    );
  }
}
