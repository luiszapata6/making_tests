import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../presentation.dart';

class AuthHandlerView extends StatelessWidget {
  const AuthHandlerView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else {
          if (snapshot.hasData) {
            return const HomeScreen(
              title: 'Hola',
            );
          } else {
            return const SignScreen();
          }
        }
      }),
    );
  }
}
