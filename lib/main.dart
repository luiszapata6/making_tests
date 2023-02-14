import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:making_tests/dependencies_injection/injector.dart';
import 'presentation/presentation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Injector.setup();
  runApp(const MakingTestApp());
}

class MakingTestApp extends StatelessWidget {
  const MakingTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Testing Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: black,
          appBarTheme: const AppBarTheme(color: black),
        ),
        home: const AuthHandlerView(),
      ),
    );
  }
}
