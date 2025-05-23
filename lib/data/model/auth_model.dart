import 'package:magic_gemini_x_flutter/data/vo/user_vo.dart';
import 'package:magic_gemini_x_flutter/domain/auth_repository.dart';
import 'package:magic_gemini_x_flutter/network/firebase/firebase_auth_repo.dart';

class AuthModel extends AuthRepo {
  AuthModel._();
  static final AuthModel _singleton = AuthModel._();
  factory AuthModel() => _singleton;
  final _firebaseAgent = FirebaseAuthRepo();

  @override
  Future<UserVO?> getCurrentUser() async {
    try {
      UserVO? user = await _firebaseAgent.getCurrentUser();

     

      if (user != null && user.email.isEmpty) {
        user.email = "invalid user";
      }

      return user;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<UserVO?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserVO? user =
          await _firebaseAgent.loginWithEmailAndPassword(email, password);

      user ??= UserVO(uid: "", email: "Invalid User");

      if (user.email.isEmpty) {
        user.email = "invalid user";
      }

      return user;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAgent.logout();
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
