abstract class AuthEvents {}

class CheckAuth extends AuthEvents {}

class UserLogin extends AuthEvents {
  final String email;
  final String password;

  UserLogin({required this.email, required this.password});
}

class LoadUser extends AuthEvents {}

class UserLogout extends AuthEvents {}
