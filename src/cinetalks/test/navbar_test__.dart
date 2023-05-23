import 'dart:io';

import 'package:cinetalks/movie_app_icons_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cinetalks/widgets/bottom_navbar.dart';

import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigator extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  late MockNavigator mockNavigator;

  setUpAll(() {
    Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    mockNavigator = MockNavigator();
    registerFallbackValue(FakeRoute());
  });

  testWidgets("Navbar navigates to right pages", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: bottomNavigationBar(),
        ),
        navigatorObservers: [mockNavigator],
      ),
    );

    await tester.tap(find.byIcon(MovieAppIcons.search));
    await tester.pumpAndSettle();

    verify(() => mockNavigator.didPush(any(), any())).called(1);
  });

  tearDown(() {
    resetMocktailState();
  });
}
