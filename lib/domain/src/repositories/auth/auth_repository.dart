import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:making_tests/presentation/src/core/config/helpers/errors/invalid_data.dart';

abstract class AuthRepository {
  Future<Either<InvalidData, User>> signUp(String email, String password);
  Future<Either<InvalidData, User>> login(String email, String password);
  Future<Either<InvalidData, bool>> logout();
}
