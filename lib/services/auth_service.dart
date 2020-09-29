import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth =  FirebaseAuth.instance;

  Future login() async {
    try {
      UserCredential userCreds = await _auth.signInWithEmailAndPassword(email: 'test@gmail.com', password: '123456');
      User user = userCreds.user;
      print("logged in");
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}