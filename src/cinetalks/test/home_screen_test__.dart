import 'package:clock/src/clock.dart';
import 'dart:ui';

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

class FirebaseAuthMocksBinding extends TestWidgetsFlutterBinding {
  final mockUser = MockUser(
    uid: 'testUserId',
    displayName: 'Test User',
  );
  final mockAuth = MockFirebaseAuth(mockUser: mockUser);

  @override
  FirebaseAuth get auth => mockAuth;

  @override
  Clock get clock => throw UnimplementedError();

  @override
  Timeout get defaultTestTimeout => throw UnimplementedError();

  @override
  Future<void> delayed(Duration duration) {
    throw UnimplementedError();
  }

  @override
  bool get inTest => throw UnimplementedError();

  @override
  int get microtaskCount => throw UnimplementedError();

  @override
  Future<void> pump(
      [Duration? duration,
      EnginePhase newPhase = EnginePhase.sendSemanticsUpdate]) {
    throw UnimplementedError();
  }

  @override
  Future<T?> runAsync<T>(Future<T> Function() callback,
      {Duration additionalTime = const Duration(milliseconds: 1000)}) {
    throw UnimplementedError();
  }

  @override
  Future<void> runTest(
      Future<void> Function() testBody, VoidCallback invariantTester,
      {String description = '', Duration? timeout}) {
    throw UnimplementedError();
  }
}

void main() {
  TestWidgetsFlutterBinding binding =
      FirebaseAuthMocksBinding.ensureInitialized();
  // Your tests go here

  testWidgets('SearchBar logic works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MySearchBar(),
        ),
      ),
    );

    expect(find.byType(MySearchBar), findsOneWidget);
  });
}
