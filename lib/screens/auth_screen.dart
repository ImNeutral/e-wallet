import 'package:e_wallet/providers/auth_provider.dart';
import 'package:e_wallet/widgets/auth/auth_form.dart';
import 'package:e_wallet/widgets/auth/background.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthProvider authService = new AuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomPaint(
        painter: AuthBackgroundPainter(),
        child: AuthForm(),
      ),
    );
  }
}
