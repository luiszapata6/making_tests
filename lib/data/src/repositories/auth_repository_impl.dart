import '../../data.dart';
import '../../../domain/domain.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<InvalidData, User>> signUp(
      String email, String password) async {
    try {
      final User response = await authDataSource.signUp(email, password);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, User>> login(String email, String password) async {
    try {
      final User response = await authDataSource.login(email, password);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, bool>> logout() async {
    try {
      await authDataSource.logout();
      return const Right(true);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
