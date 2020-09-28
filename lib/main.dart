import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Start',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          appBar: AppBar(title: Text("Hello AppBar")),
          body:
          Container(
            child: ListView(
              children: [
                Text("Hello"),
                Text("World"),
                RaisedButton(child: Text("Button"), onPressed: showTestData, ),
              ],
            ),
          ),
      ),
    );
  }

  QuerySnapshot showTestData() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
          snapshot.docs.forEach((element) {
            print(element.data()["full_name"]);
          });
    });
  }
}
