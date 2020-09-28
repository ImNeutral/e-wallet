import 'package:e_wallet/model/User.dart';
import 'package:e_wallet/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserService userService = new UserService();

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
    var userList = Provider.of<List<User>>(context);

    return MaterialApp(
      title: 'Flutter Start',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Hello AppBar")),
        body: Container(
          child: ListView(
            children: <Widget>[
              for(var item in userList ) Text(item.fullName)
            ],
            // [
              // Text("Hello"),
              // Text("World"),
              // RaisedButton(
              //   child: Text("Button"),
              //   onPressed: () => {
              //     showTestData(userList)
              //   },
              // ),

              /*StreamProvider<List<User>>.value (
                  builder: UserService.streamAllUsers,
                  child: Text("Hello"),
                )*/

            // ],
          ),
        ),
      ),
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
