import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
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

  // Generic Arrange
  setUp(() async {
    setupFirebaseAuthMocks();
    mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
    mockAuthDataSource = MockAuthDataSource(mockFirebaseAuth: mockFirebaseAuth);
    mockAuthRepositoryImpl =
        MockAuthRepositoryImpl(mockAuthDataSource: mockAuthDataSource);
  });

  group('Firebase Sign Up Test >', () {
    test('Success Sign Up Test', () async {
      // Act
      final signUp =
          await mockAuthRepositoryImpl.signUp(mockUser.email!, 'password');
      // Assert
      expect(signUp, Success(mockUser));
    });

    test('Fail Sign Up Test', () async {
      // Arrange
      whenCalling(Invocation.method(#createUserWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: 'test'));

      // Act
      final signUp =
          await mockAuthRepositoryImpl.signUp(mockUser.email!, 'password');

      // Assert
      expect(signUp, authException);
    });
  });

  group('Firebase Login Test >', () {
    test('Success login', () async {
      // Assert
      expect(mockFirebaseAuth.currentUser, isNull);

      // Act
      await mockAuthRepositoryImpl.login(mockUser.email!, 'password');

      // Assert
      expect(mockFirebaseAuth.currentUser, isNotNull);
    });

    test('Fail Login Test', () async {
      // Arrange
      whenCalling(Invocation.method(#signInWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: 'test'));
      // Act
      final login =
          await mockAuthRepositoryImpl.login(mockUser.email!, 'password');
      // Assert
      expect(login, authException);
    });
  });
}
