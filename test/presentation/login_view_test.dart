import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:making_tests/dependencies_injection/injector.dart';
import 'package:making_tests/presentation/presentation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  setUp(() async {
    setupFirebaseCoreMocks();
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Injector.setup();
  });

  tearDown(() {
    Injector.container.clear();
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
  final invalidEmailTextFinder = find.text('Ingresa un correo válido');
  final invalidPasswordTextFinder = find.text('Ingresa una contraseña válida');
  final loginButtonFinder = find.byKey(const Key('loginButton'));

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

    testWidgets('Check switch sign form', (WidgetTester tester) async {
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
    testWidgets('Check invalid login form', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const SignScreen()));
      expect(loginButtonFinder, findsOneWidget);
      expect(invalidEmailTextFinder, findsNothing);
      expect(invalidPasswordTextFinder, findsNothing);
      await tester.tap(loginButtonFinder);
      await tester.pump();
      expect(invalidEmailTextFinder, findsOneWidget);
      expect(invalidPasswordTextFinder, findsOneWidget);
      await tester.enterText(emailFieldFinder, 'test@domain.com');
      await tester.enterText(passwordFieldFinder, '123456ABC');
      await tester.pump();
      expect(invalidEmailTextFinder, findsNothing);
      expect(invalidPasswordTextFinder, findsNothing);
    });

    testWidgets('Check password hidden', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const SignScreen()));
      final passwordTextField =
          tester.widget<TextFormFieldWidget>(passwordFieldFinder);
      expect(passwordTextField.obscureText, isTrue);
    });

    testWidgets('Check loader on submit', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const SignScreen()));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(loginButtonFinder, findsOneWidget);
      await tester.enterText(emailFieldFinder, 'test@domain.com');
      await tester.enterText(passwordFieldFinder, '123456ABC');
      await tester.tap(loginButtonFinder);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(loginButtonFinder, findsNothing);
    });
  });
}
