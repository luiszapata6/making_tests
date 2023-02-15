import 'package:multiple_result/multiple_result.dart';

import '../../../domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase({
    required this.authRepository,
  });

  Future<Result<User, Exception>> call(String username, String password) async {
    return await authRepository.signUp(username, password);
  }
}
