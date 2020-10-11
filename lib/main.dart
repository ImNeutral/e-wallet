import 'package:e_wallet/models/transaction_model.dart';
import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/transaction_provider.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:e_wallet/screens/add_balance_screen.dart';
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
  final TransactionProvider transactionProvider = new TransactionProvider();

  runApp(MultiProvider(
    providers: [
      StreamProvider<List<UserModel>>.value(
        value: userService.streamAllUsers(),
      ),
      StreamProvider<User>.value(
        value: FirebaseAuth.instance.authStateChanges(),
      ),
      // StreamProvider<UserModel>.value(
      //   value: userService.streamUser('Qw0YNjseGjMWJw0AOx9t'),
      // ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    var isLoggedIn = user != null && user.emailVerified;

    return MaterialApp(
      title: 'Flutter Start',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (isLoggedIn ? DashboardScreen() : AuthScreen()),
      routes: {
        AddBalance().routeName: (context) => AddBalance(),
      },
    );
  }
}
