part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignUp extends AuthEvent {
  final String email;
  final String password;
  SignUp(this.email, this.password);
}

class Login extends AuthEvent {
  final String email;
  final String password;
  Login(this.email, this.password);
}

class Logout extends AuthEvent {
  Logout();
}
