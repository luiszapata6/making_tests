// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureAuthFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => AuthDataSource(firebaseAuth: c<FirebaseAuth>()))
      ..registerFactory<AuthRepository>(
          (c) => AuthRepositoryImpl(authDataSource: c<AuthDataSource>()))
      ..registerFactory(
          (c) => LoginUseCase(authRepository: c<AuthRepository>()))
      ..registerFactory(
          (c) => SignUpUseCase(authRepository: c<AuthRepository>()));
  }
}
