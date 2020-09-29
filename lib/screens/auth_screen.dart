import 'package:e_wallet/services/auth_service.dart';
import 'package:e_wallet/widgets/auth/auth_form.dart';
import 'package:e_wallet/widgets/auth/background.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomPaint(painter: AuthBackgroundPainter(), child: AuthForm()),
    );
  }

  void signInUser() async {
    dynamic result = await authService.login();
    if (result == null) {
      print('error signing in');
    } else {
      print('signed in');
      print(result);
    }
  }
}
