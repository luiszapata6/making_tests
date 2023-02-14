import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:making_tests/dependencies_injection/injector.dart';
import 'package:making_tests/domain/domain.dart';
import 'package:making_tests/presentation/presentation.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  setUpAll(() async {
    setupFirebaseCoreMocks();
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Injector.setup();
  });

  Widget fakeMaterialApp(Widget page) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
      ],
      child: MaterialApp(home: page),
    );
  }

  final appTitleFinder = find.text('TESTING APP');
  final emailTitleFinder = find.text('Correo electrónico');
  final passwordTitleFinder = find.text('Contraseña');
  final emailFieldFinder = find.byKey(const Key('emailTextField'));
  final passwordFieldFinder = find.byKey(const Key('passwordTextField'));
  final largeButtonFinder = find.byType(LargeButton);
  final signUpFormFinder = find.byType(SignUpForm);
  final loginFormFinder = find.byType(LoginForm);
  final switchFormButtonFinder = find.byKey(const Key('switchFormButton'));
  final invalidEmailText = find.text('Ingresa un correo válido');
  final invalidPasswordText = find.text('Ingresa una contraseña válida');
  final loginButton = find.byKey(const Key('loginButton'));

  group('Sign Screen Test', () {
    testWidgets('Find initial screen widgets', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const SignScreen()));

      expect(appTitleFinder, findsOneWidget);
      expect(emailTitleFinder, findsOneWidget);
      expect(passwordTitleFinder, findsOneWidget);
      expect(emailFieldFinder, findsOneWidget);
      expect(passwordFieldFinder, findsOneWidget);
      expect(switchFormButtonFinder, findsOneWidget);
      expect(largeButtonFinder, findsWidgets);
      expect(signUpFormFinder, findsNothing);
      expect(loginFormFinder, findsOneWidget);
    });

    testWidgets('Switch sign form', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const SignScreen()));

      await tester.tap(switchFormButtonFinder);
      await tester.pump();
      expect(signUpFormFinder, findsOneWidget);
      expect(loginFormFinder, findsNothing);
      await tester.tap(switchFormButtonFinder);
      await tester.pump();
      expect(signUpFormFinder, findsNothing);
      expect(loginFormFinder, findsOneWidget);
    });
  });

  group('Login form test', () {
    testWidgets('', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const SignScreen()));
      expect(loginButton, findsOneWidget);
      expect(invalidEmailText, findsNothing);
      expect(invalidPasswordText, findsNothing);
      await tester.tap(loginButton);
      await tester.pump();
      expect(invalidEmailText, findsOneWidget);
      expect(invalidPasswordText, findsOneWidget);
      await tester.enterText(emailFieldFinder, 'test@domain.com');
      await tester.enterText(passwordFieldFinder, '123456ABC');
      await tester.pump();
      expect(invalidEmailText, findsNothing);
      expect(invalidPasswordText, findsNothing);
    });
  });
}
