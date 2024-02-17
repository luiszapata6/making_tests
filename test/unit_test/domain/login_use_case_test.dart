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

  // Generic Arrange
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
      // Arrange
      final loginUseCase = kiwiContainer.resolve<LoginUseCase>();
      // Assert
      expect(mockFirebaseAuth.currentUser, isNull);
      // Act
      await loginUseCase.call(mockUser.email!, 'password');
      // Assert
      expect(mockFirebaseAuth.currentUser, isNotNull);
    });

    test('Failed login', () async {
      // Arrange
      final loginUseCase = kiwiContainer.resolve<LoginUseCase>();
      whenCalling(Invocation.method(#signInWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: 'test'));
      // Act & Assert
      expect(
          await loginUseCase.call(mockUser.email!, 'password'), authException);
    });
  });
}
