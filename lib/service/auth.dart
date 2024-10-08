import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getcurrentUser() async {
    return await auth.currentUser;
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future deleteuser() async {
    User? user = await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}
