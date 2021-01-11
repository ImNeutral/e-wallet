import 'package:e_wallet/models/user_model.dart';
import 'package:e_wallet/providers/transaction_provider.dart';
import 'package:e_wallet/providers/user_provider.dart';
import 'package:e_wallet/screens/add_balance_screen.dart';
import 'package:e_wallet/screens/auth_screen.dart';
import 'package:e_wallet/screens/contact_list_screen.dart';
import 'package:e_wallet/screens/dashboard_screen.dart';
import 'package:e_wallet/screens/my_qr_code_screen.dart';
import 'package:e_wallet/screens/send_money_screen.dart';
import 'package:e_wallet/screens/transaction_history_screen..dart';
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
        value: FirebaseAuth.instance.authStateChanges(),
      ),
      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider<TransactionProvider>(
        create: (_) => TransactionProvider(),
      ),
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
      title: 'E Wallet',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (isLoggedIn ? DashboardScreen() : AuthScreen()),
      routes: {
        AddBalance().routeName: (context) => AddBalance(),
        TransactionHistory().routeName: (context) => TransactionHistory(),
        Pay().routeName: (context) => Pay(),
        MyQrCode().routeName: (context) => MyQrCode(),
        ContactListScreen().routeName: (context) => ContactListScreen(),
      },
    );
  }
}
