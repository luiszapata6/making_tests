import '../../../domain.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase({
    required this.authRepository,
  });

  Future<Either<InvalidData, User>> call(
      String username, String password) async {
    return await authRepository.signUp(username, password);
  }
}
