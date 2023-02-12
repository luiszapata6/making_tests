import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../../../presentation/src/core/config/helpers/errors/invalid_data.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase({
    required this.authRepository,
  });

  Future<Either<InvalidData, User>> call(
      String username, String password) async {
    return await authRepository.login(username, password);
  }
}
