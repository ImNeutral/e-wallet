import 'package:e_wallet/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In to E-wallet"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
            child: Text("Sign In!"),
            onPressed: signInUser
            ),
      ),
    );
  }

  void signInUser() async {
    dynamic result = await authService.login();
    if(result == null) {
      print('error signing in');
    } else {
      print('signed in');
      print(result);
    }
  }
}
