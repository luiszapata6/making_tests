import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:making_tests/presentation/src/core/config/helpers/errors/invalid_data.dart';

class AuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> signUp(String email, String password) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return response.user!;
    } on FirebaseAuthException catch (e) {
      debugPrint("error");
      throw InvalidData(e.message);
    }
  }

  Future<User> login(String email, String password) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return response.user!;
    } on FirebaseAuthException catch (e) {
      debugPrint("error");
      throw InvalidData(e.message);
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint("error");
      throw InvalidData(e.message);
    }
  }
}
