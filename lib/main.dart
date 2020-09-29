import 'package:e_wallet/models/User.dart';
import 'package:e_wallet/services/auth_service.dart';
import 'package:e_wallet/services/user_service.dart';
import 'package:e_wallet/widgets/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserProvider userService = new UserProvider();
  // StreamProvider<List<User>>.value(value: userService.streamAllUsers(),);
  // runApp(MyApp());
  runApp(MultiProvider(
    providers: [
      StreamProvider<List<User>>.value(
        value: userService.streamAllUsers(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // final FirebaseFirestore _db =  FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Start',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignIn(),
    );
  }

  void showTestData(List<User> userList) {
    userList.forEach((element) {
      print(element.fullName);
    });
  }
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .snapshots()
  //       .listen((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((element) {
  //       print(element.data()["full_name"]);
  //     });
  //   });
  // }
}

/*
var userList = Provider.of<List<User>>(context);
Container(
          child: ListView(
            children: <Widget>[
              if(userList != null) for(var item in userList ) Text(item.fullName)
            ],
          ),
        ),
* */