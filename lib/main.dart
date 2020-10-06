import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:e_wallet/screens/auth_screen.dart';
import 'package:e_wallet/screens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserProvider userService = new UserProvider();

  runApp(MultiProvider(
    providers: [
      StreamProvider<List<UserModel>>.value(
        value: userService.streamAllUsers(),
      ),
      StreamProvider<User>.value(
          value: FirebaseAuth.instance.authStateChanges()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    var isLoggedIn = user != null;

    return MaterialApp(
      title: 'Flutter Start',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (isLoggedIn ? DashboardScreen() : AuthScreen()),
    );
  }
}
