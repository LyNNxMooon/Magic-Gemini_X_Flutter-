import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvents {}

class CheckAuth extends AuthEvents {}

class UserLogin extends AuthEvents {
  final String email;
  final String password;

  UserLogin({required this.email, required this.password});
}

class RegisterUser  extends AuthEvents {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterUser({required this.email, required this.password, required this.confirmPassword});

}

class LoadUser extends AuthEvents {}

class UserLogout extends AuthEvents {}

class AuthStateChanged extends AuthEvents {
  final User? user;
  AuthStateChanged(this.user);
}
