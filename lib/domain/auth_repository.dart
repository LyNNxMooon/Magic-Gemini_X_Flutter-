import 'package:magic_gemini_x_flutter/data/vo/user_vo.dart';

abstract class AuthRepo {
  Future<UserVO?> loginWithEmailAndPassword(String email, String password);

  Future<void> registerWithEmailAndPassword(String email, String password);

  Future<void> logout();

  Future<UserVO?> getCurrentUser();
}