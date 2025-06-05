import 'package:firebase_auth/firebase_auth.dart';
import 'package:magic_gemini_x_flutter/data/vo/user_vo.dart';
import 'package:magic_gemini_x_flutter/domain/auth_repository.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //get current user

  @override
  Future<UserVO?> getCurrentUser() async {

    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return null;
    }

    UserVO user = UserVO(uid: currentUser.uid, email: currentUser.email ?? "");

    return user;
  }

  // login user

  @override
  Future<UserVO?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        return null;
      }

      UserVO user = UserVO(
          uid: userCredential.user?.uid ?? "",
          email: userCredential.user?.email ?? "");

      return user;
    } catch (error) {
      throw Exception("Login Failed: $error");
    }
  }

  //logout user

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
