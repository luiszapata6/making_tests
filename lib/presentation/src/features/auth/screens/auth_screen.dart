import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:making_tests/presentation/src/features/auth/screens/login_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return const LoginScreen();
            } else {
              return const LoginScreen();
            }
          }
        }),
      ),
    );
  }
}
