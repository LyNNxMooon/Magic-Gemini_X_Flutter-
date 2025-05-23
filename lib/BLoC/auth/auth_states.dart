import 'package:magic_gemini_x_flutter/data/vo/user_vo.dart';

abstract class AuthStates {}

class AuthsInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class Authenticated extends AuthStates {
  final UserVO user;

  Authenticated (this.user);
}

class UnAuthenticated extends AuthStates {
  final String message;

  UnAuthenticated (this.message);
}