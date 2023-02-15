import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiwi/kiwi.dart';

import '../data/data.dart';
import '../domain/domain.dart';

part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer container = KiwiContainer();
  static void setup() {
    var injector = _$Injector();
    injector._configure();
  }

  static final resolve = container.resolve;

  //The repositories and their implementation, the use case and the datasource must always be registered.
  //If two or more use cases depend on the same repositories and datasource, only the new use case should be registered, since the rest will already be registered.

  //When you finish registering the new use case, you must run the following command in the console
  // flutter packages pub run build_runner build
  //If it fails, you must run the following command
  // flutter packages pub run build_runner build --delete-conflicting-outputs
  //The second com mand will overwrite the injector.g.dart file if necessary

  //A new factory configuration must be created every time there is a new repository and datasource.

  void _configure() {
    _configureAuthsModule();
  }

  void _configureAuthsModule() {
    _configureAuthFactories();
    _configureAuthFirebase();
  }

  void _configureAuthFirebase() {
    container.registerInstance(FirebaseAuth.instance);
  }

  @Register.factory(AuthDataSource)
  @Register.factory(AuthRepository, from: AuthRepositoryImpl)
  @Register.factory(LoginUseCase, name: 'LoginUseCase')
  @Register.factory(SignUpUseCase)
  @Register.factory(LogoutUseCase)
  void _configureAuthFactories();
}
