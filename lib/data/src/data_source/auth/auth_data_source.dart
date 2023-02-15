import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';

class AuthDataSource {
  final FirebaseAuth firebaseAuth;
  AuthDataSource({required this.firebaseAuth});

  Future<Result<User, Exception>> signUp(String email, String password) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return Success(response.user!);
    } on FirebaseAuthException catch (e) {
      return Error(Exception(e.message));
    }
  }

  Future<Result<User, Exception>> login(String email, String password) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Success(response.user!);
    } on FirebaseAuthException catch (e) {
      return Error(Exception(e.message));
    }
  }

  Future<Result<bool, Exception>> logout() async {
    try {
      await firebaseAuth.signOut();
      return const Success(true);
    } on FirebaseAuthException catch (e) {
      return Error(Exception(e.message));
    }
  }
}
