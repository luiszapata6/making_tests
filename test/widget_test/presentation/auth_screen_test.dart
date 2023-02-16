import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:making_tests/dependencies_injection/injector.dart';
import 'package:making_tests/presentation/presentation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  // Generic Arrange
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

  group('Find auth screen widgets >', () {
    // Best practice
    testWidgets('Check finds screen title', (WidgetTester tester) async {
      // Arrange
      final appTitleFinder = find.text('TESTING APP');
      // Act
      await tester.pumpWidget(fakeMaterialApp(const AuthScreen()));
      // Assert
      expect(appTitleFinder, findsOneWidget);
    });

    // It's okay
    testWidgets('Check finds email field', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(fakeMaterialApp(const AuthScreen()));
      // Assert
      expect(find.byKey(const Key('emailTextField')), findsOneWidget);
    });

    testWidgets('Check finds password field', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const AuthScreen()));

      expect(find.byKey(const Key('passwordTextField')), findsOneWidget);
    });

    testWidgets('Check finds two text field', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const AuthScreen()));

      expect(find.byType(TextFormFieldWidget), findsWidgets);
    });

    testWidgets('Check finds no confirmation password field',
        (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const AuthScreen()));

      expect(find.byKey(const Key('passwordConfirmationField')), findsNothing);
    });
  });

  group('Switch auth forms test >', () {
    // Arrange
    final signUpFormFinder = find.byType(SignUpForm);
    final loginFormFinder = find.byType(LoginForm);
    final switchFormButtonFinder = find.byKey(const Key('switchFormButton'));

    testWidgets('Check switch auth form', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(fakeMaterialApp(const AuthScreen()));
      // Act
      await tester.tap(switchFormButtonFinder);
      await tester.pump();
      // Assert
      expect(signUpFormFinder, findsOneWidget);
      expect(loginFormFinder, findsNothing);
      // Act
      await tester.tap(switchFormButtonFinder);
      await tester.pump();
      // Assert
      expect(signUpFormFinder, findsNothing);
      expect(loginFormFinder, findsOneWidget);
    });
  });

  group('Login form interaction test >', () {
    // Arrange
    final emailFieldFinder = find.byKey(const Key('emailTextField'));
    final passwordFieldFinder = find.byKey(const Key('passwordTextField'));
    final invalidEmailTextFinder = find.text('Ingresa un correo válido');
    final invalidPasswordTextFinder =
        find.text('Ingresa una contraseña válida');
    final loginButtonFinder = find.byKey(const Key('loginButton'));

    testWidgets('Check invalid login form', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(fakeMaterialApp(const AuthScreen()));
      // Assert
      expect(loginButtonFinder, findsOneWidget);
      expect(invalidEmailTextFinder, findsNothing);
      expect(invalidPasswordTextFinder, findsNothing);
      // Act
      await tester.tap(loginButtonFinder);
      await tester.pump();
      // Assert
      expect(invalidEmailTextFinder, findsOneWidget);
      expect(invalidPasswordTextFinder, findsOneWidget);
      // Act
      await tester.enterText(emailFieldFinder, 'test@domain.com');
      await tester.enterText(passwordFieldFinder, '123456Abc*');
      await tester.pump();
      // Assert
      expect(invalidEmailTextFinder, findsNothing);
      expect(invalidPasswordTextFinder, findsNothing);
    });

    testWidgets('Check password hidden', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const AuthScreen()));
      final passwordTextField =
          tester.widget<TextFormFieldWidget>(passwordFieldFinder);
      expect(passwordTextField.obscureText, isTrue);
    });

    testWidgets('Check loader on submit', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialApp(const AuthScreen()));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(loginButtonFinder, findsOneWidget);
      await tester.enterText(emailFieldFinder, 'test@domain.com');
      await tester.enterText(passwordFieldFinder, '123456Abc*');
      await tester.tap(loginButtonFinder);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(loginButtonFinder, findsNothing);
    });
  });
}
