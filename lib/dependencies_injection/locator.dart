import 'package:get_it/get_it.dart';
import 'package:making_tests/data/src/data_source/auth/auth_data_source.dart';
import 'package:making_tests/data/src/repositories/auth_repository_impl.dart';
import 'package:making_tests/domain/src/repositories/auth/auth_repository.dart';
import 'package:making_tests/domain/src/use_cases/auth/login_use_case.dart';
import 'package:making_tests/domain/src/use_cases/auth/logout_use_case.dart';
import 'package:making_tests/domain/src/use_cases/auth/signup_use_case.dart';

GetIt locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: locator()));
  locator.registerFactory<AuthDataSource>(() => AuthDataSource());
  locator.registerFactory<LoginUseCase>(
      () => LoginUseCase(authRepository: locator()));
  locator.registerFactory<SignUpUseCase>(
      () => SignUpUseCase(authRepository: locator()));
  locator.registerFactory<LogoutUseCase>(
      () => LogoutUseCase(authRepository: locator()));
}
