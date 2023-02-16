import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:multiple_result/multiple_result.dart';
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
        (container) => SignUpUseCase(authRepository: mockAuthRepositoryImpl));
  });

  tearDown(() {
    kiwiContainer.clear();
  });

  group('Sign Up use case testing >', () {
    test('Success Sign Up', () async {
      // Arrange
      final signUpUseCase = kiwiContainer.resolve<SignUpUseCase>();
      // Act
      final signUp = await signUpUseCase.call(mockUser.email!, 'password');
      // Assert
      expect(signUp, Success(mockUser));
    });

    test('Fail Sign Up', () async {
      // Arrange
      final signUpUseCase = kiwiContainer.resolve<SignUpUseCase>();
      // Arrange
      whenCalling(Invocation.method(#createUserWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: 'test'));
      // Act
      final signUp = await signUpUseCase.call(mockUser.email!, 'password');
      // Assert
      expect(signUp, authException);
    });
  });
}
