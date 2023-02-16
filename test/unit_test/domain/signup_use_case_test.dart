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
      final signUpUseCase = kiwiContainer.resolve<SignUpUseCase>();

      expect(await signUpUseCase.call(mockUser.email!, 'password'),
          Success(mockUser));
    });

    test('Fail Sign Up', () async {
      final signUpUseCase = kiwiContainer.resolve<SignUpUseCase>();
      whenCalling(Invocation.method(#createUserWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: 'test'));
      expect(
          await signUpUseCase.call(mockUser.email!, 'password'), authException);
    });
  });
}
