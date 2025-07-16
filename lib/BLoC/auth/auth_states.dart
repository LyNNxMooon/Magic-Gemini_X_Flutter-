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

//for registration

abstract class RegistrationStates {}

class RegistrationInital extends RegistrationStates {}

class RegistrationLoading extends RegistrationStates {}

class RegisterSuccessful extends RegistrationStates {
  final String message;

  RegisterSuccessful (this.message);
}

class RegisterFailed extends RegistrationStates {
  final String message;

  RegisterFailed (this.message);
}