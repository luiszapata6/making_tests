import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:making_tests/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/__firebasemock___.dart';
import '../../mocks/__authmocks__.dart';
import 'package:kiwi/kiwi.dart';

void main() {
  late KiwiContainer kiwiContainer;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockAuthDataSource mockAuthDataSource;
  late MockAuthRepositoryImpl mockAuthRepositoryImpl;

  setUp(() async {
    setupFirebaseAuthMocks();
    mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
    mockAuthDataSource = MockAuthDataSource(mockFirebaseAuth: mockFirebaseAuth);
    mockAuthRepositoryImpl =
        MockAuthRepositoryImpl(mockAuthDataSource: mockAuthDataSource);
    kiwiContainer = KiwiContainer();
    kiwiContainer.registerFactory(
        (container) => LoginUseCase(authRepository: mockAuthRepositoryImpl));
  });

  tearDown(() {
    kiwiContainer.clear();
  });

  group('Login use case Test >', () {
    test('Success login', () async {
      final loginUseCase = kiwiContainer.resolve<LoginUseCase>();
      expect(mockFirebaseAuth.currentUser, isNull);

      await loginUseCase.call(mockUser.email!, 'password');

      expect(mockFirebaseAuth.currentUser, isNotNull);
    });

    test('Fail login', () async {
      final loginUseCase = kiwiContainer.resolve<LoginUseCase>();
      whenCalling(Invocation.method(#signInWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: 'test'));
      expect(
          await loginUseCase.call(mockUser.email!, 'password'), authException);
    });
  });
}
