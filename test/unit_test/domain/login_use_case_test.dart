import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:making_tests/dependencies_injection/injector.dart';
import 'package:making_tests/domain/domain.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/__firebasemock___.dart';
import '../../mocks/__authmocks__.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockAuthDataSource mockAuthDataSource;
  late MockAuthRepositoryImpl mockAuthRepositoryImpl;

  setUp(() async {
    setupFirebaseAuthMocks();
    mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
    mockAuthDataSource = MockAuthDataSource(mockFirebaseAuth: mockFirebaseAuth);
    mockAuthRepositoryImpl =
        MockAuthRepositoryImpl(mockAuthDataSource: mockAuthDataSource);
    Injector.container
      ..registerFactory(
          (container) => LoginUseCase(authRepository: mockAuthRepositoryImpl))
      ..registerFactory(
          (container) => SignUpUseCase(authRepository: mockAuthRepositoryImpl));
  });

  tearDown(() {
    Injector.container.clear();
  });

  group('Sign Up use case testing >', () {
    test('Success Sign Up', () async {
      final signUpUseCase = Injector.resolve<SignUpUseCase>();

      expect(await signUpUseCase.call(mockUser.email!, 'password'),
          Success(mockUser));
    });

    test('Fail Sign Up', () async {
      final signUpUseCase = Injector.resolve<SignUpUseCase>();
      whenCalling(Invocation.method(#createUserWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: 'test'));
      expect(
          await signUpUseCase.call(mockUser.email!, 'password'), authException);
    });
  });

  group('Login use case Test >', () {
    test('Success login', () async {
      final loginUseCase = Injector.resolve<LoginUseCase>();
      expect(mockFirebaseAuth.currentUser, isNull);

      await loginUseCase.call(mockUser.email!, 'password');

      expect(mockFirebaseAuth.currentUser, isNotNull);
    });

    test('Fail login', () async {
      final loginUseCase = Injector.resolve<LoginUseCase>();
      whenCalling(Invocation.method(#signInWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: 'test'));
      expect(
          await loginUseCase.call(mockUser.email!, 'password'), authException);
    });
  });
}
