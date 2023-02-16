import 'dart:async';

import '../../data.dart';
import '../../../domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Result<User, Exception>> signUp(String email, String password) async {
    final response = await authDataSource.signUp(email, password);

    return response;
  }

  @override
  Future<Result<User, Exception>> login(String email, String password) async {
    final response = await authDataSource.login(email, password);
    return response;
  }
}
