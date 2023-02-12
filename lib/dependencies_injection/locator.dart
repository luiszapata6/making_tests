import '../data/data.dart';
import '../domain/domain.dart';
import 'package:get_it/get_it.dart';

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
