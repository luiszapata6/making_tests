import 'package:either_dart/either.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../../../presentation/src/core/config/helpers/errors/invalid_data.dart';

class LogoutUseCase {
  final AuthRepository authRepository;
  LogoutUseCase({
    required this.authRepository,
  });

  Future<Either<InvalidData, void>> call() async {
    return await authRepository.logout();
  }
}
