import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:making_tests/data/data.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';

class MockAuthRepositoryImpl extends Mock implements AuthRepositoryImpl {
  final MockAuthDataSource mockAuthDataSource;
  MockAuthRepositoryImpl({required this.mockAuthDataSource});

  @override
  Future<Result<User, Exception>> signUp(String email, String password) async {
    final response = await mockAuthDataSource.signUp(email, password);
    return response;
  }

  @override
  Future<Result<User, Exception>> login(String email, String password) async {
    final response = await mockAuthDataSource.login(email, password);
    return response;
  }

  @override
  Future<Result<bool, Exception>> logout() async {
    final response = await mockAuthDataSource.logout();
    return response;
  }
}

// ----- MOCK DATA SOURCE -----

class MockAuthDataSource extends Mock implements AuthDataSource {
  final MockFirebaseAuth mockFirebaseAuth;
  MockAuthDataSource({required this.mockFirebaseAuth});

  @override
  Future<Result<User, Exception>> signUp(String email, String password) async {
    try {
      final response = await mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return Success(response.user!);
    } on FirebaseAuthException {
      return authException;
    }
  }

  @override
  Future<Result<User, Exception>> login(String email, String password) async {
    try {
      final response = await mockFirebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return Success(response.user!);
    } on FirebaseAuthException {
      return authException;
    }
  }

  @override
  Future<Result<bool, Exception>> logout() async {
    try {
      await mockFirebaseAuth.signOut();
      return const Success(true);
    } on FirebaseAuthException {
      return boolException;
    }
  }
}

final mockUser = MockUser(
  isAnonymous: false,
  uid: 'mock_uid',
  email: 'test@domain.com',
  displayName: 'Mock User',
);

final Error<User, Exception> authException =
    Error<User, Exception>(Exception());

final Error<bool, Exception> boolException =
    Error<bool, Exception>(Exception());
