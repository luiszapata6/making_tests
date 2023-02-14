import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:making_tests/presentation/presentation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:making_tests/data/data.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockAuthDataSource extends Mock implements AuthDataSource {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User?> authStateChanges() {
    return Stream.fromIterable({MockUser()});
  }

  Stream<User?> get getUser => FirebaseAuth.instance.authStateChanges();
}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
  await Firebase.initializeApp();
  AuthDataSource authDataSource = AuthDataSource();
  /* setUp(() {
    Injector.container.registerInstance<AuthDataSource>(AuthDataSource());
    authDataSource = Injector.resolve<AuthDataSource>();
  });
  tearDown(
    () {
      Injector.container.clear();
    },
  ); */

  final FirebaseAuth mockAuth = MockFirebaseAuth();

  Widget fakeMaterialAppSignPage() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
      ],
      child: const MaterialApp(
        home: AuthHandlerView(),
      ),
    );
  }

  group('Find the auth handler view ', () {
    testWidgets('Check we can find Auth Handler View',
        (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialAppSignPage());
      expect(find.byType(AuthHandlerView), findsOneWidget);
    });

    testWidgets('Check we can find StreamBuilder', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialAppSignPage());
      expect(find.byType(StreamBuilder<User?>), findsOneWidget);
    });

    testWidgets('Check we can find Loader Scaffold',
        (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialAppSignPage());
      expect(find.byKey(const Key('loadingScaffold')), findsOneWidget);
    });

    testWidgets('Check we can find Home Screen', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialAppSignPage());

      final result = await mockAuth.signInWithEmailAndPassword(
          email: '123123123@hola.com', password: '123aaa56');
      await Future.delayed(const Duration(seconds: 5));

      await tester.pump(const Duration(seconds: 2));
      /*   loggedUser.fold(
        (error) => print(error),
        (user) => print(user),
      ); */

      //  expect(find.byType(HomeScreen), findsOneWidget);
    });

    /*   testWidgets('Check we can find Sign Screen', (WidgetTester tester) async {
      await tester.pumpWidget(fakeMaterialAppSignPage());
      expect(find.byType(SignScreen), findsOneWidget);
    }); */
  });
}
