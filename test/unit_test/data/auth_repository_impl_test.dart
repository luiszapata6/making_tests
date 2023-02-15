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

  setUp(() async {
    setupFirebaseAuthMocks();
    mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
    mockAuthDataSource = MockAuthDataSource(mockFirebaseAuth: mockFirebaseAuth);
    mockAuthRepositoryImpl =
        MockAuthRepositoryImpl(mockAuthDataSource: mockAuthDataSource);
  });

  group('Firebase Sign Up Test', () {
    test('Success Sign Up Test', () async {
      expect(await mockAuthRepositoryImpl.signUp(mockUser.email!, 'password'),
          Success(mockUser));
    });

    test('Fail Sign Up Test', () async {
      whenCalling(Invocation.method(#createUserWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: 'test'));
      expect(await mockAuthRepositoryImpl.signUp(mockUser.email!, 'password'),
          authException);
    });
  });

  group('Firebase Login Test', () {
    test('Success login', () async {
      expect(mockFirebaseAuth.currentUser, isNull);

      await mockAuthRepositoryImpl.login(mockUser.email!, 'password');

      expect(mockFirebaseAuth.currentUser, isNotNull);
    });

    test('Fail Login Test', () async {
      whenCalling(Invocation.method(#signInWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: 'test'));
      expect(await mockAuthRepositoryImpl.login(mockUser.email!, 'password'),
          authException);
    });
  });

  group('Firebase Logout Test', () {
    test('Success Logout Test', () async {
      expect(await mockAuthRepositoryImpl.logout(), const Success(true));
    });
  });
}
