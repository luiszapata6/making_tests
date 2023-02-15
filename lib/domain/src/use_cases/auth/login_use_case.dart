import 'package:multiple_result/multiple_result.dart';

import '../../../domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase({
    required this.authRepository,
  });

  Future<Result<User, Exception>> call(String username, String password) async {
    return await authRepository.login(username, password);
  }
}
