import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AuthRepository {
  Future<Result<User, Exception>> signUp(String email, String password);
  Future<Result<User, Exception>> login(String email, String password);
}
