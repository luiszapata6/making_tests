import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../presentation.dart';

class AuthHandlerView extends StatelessWidget {
  const AuthHandlerView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      key: const Key('authHandlerStream'),
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget(
            key: Key('loadingScaffold'),
          );
        } else {
          if (snapshot.hasData) {
            return const HomeScreen(
              title: 'Hola',
            );
          } else {
            return const AuthScreen();
          }
        }
      }),
    );
  }
}
