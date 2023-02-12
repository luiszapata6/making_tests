import '../../../domain.dart';
import 'package:either_dart/either.dart';

class LogoutUseCase {
  final AuthRepository authRepository;
  LogoutUseCase({
    required this.authRepository,
  });

  Future<Either<InvalidData, void>> call() async {
    return await authRepository.logout();
  }
}
