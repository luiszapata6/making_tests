import 'package:multiple_result/multiple_result.dart';

import '../../../domain.dart';

class LogoutUseCase {
  final AuthRepository authRepository;
  LogoutUseCase({
    required this.authRepository,
  });

  Future<Result<bool, Exception>> call() async {
    return await authRepository.logout();
  }
}
