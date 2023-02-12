import '../../../domain.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<InvalidData, User>> signUp(String email, String password);
  Future<Either<InvalidData, User>> login(String email, String password);
  Future<Either<InvalidData, bool>> logout();
}
