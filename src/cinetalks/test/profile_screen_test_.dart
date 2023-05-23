import 'package:cinetalks/widgets/horizontal_scroll_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cinetalks/models/movie_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cinetalks/screens/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';

class MockFirebaseApp extends Mock implements FirebaseApp {}

final mockFirebaseApp = MockFirebaseApp();

FirebaseOptions firebaseOptionsFromMap(Map<String, String> optionsMap) {
  return FirebaseOptions(
    apiKey: optionsMap['apiKey']!,
    appId: optionsMap['appId']!,
    messagingSenderId: optionsMap['messagingSenderId']!,
    projectId: optionsMap['projectId']!,
  );
}

void main() {
  setUpAll(() async {
    // Initialize the mock Firebase app
    registerFallbackValue(
      FirebaseOptions(
        apiKey: 'dummy-api-key',
        appId: 'dummy-app-id',
        messagingSenderId: 'dummy-messaging-sender-id',
        projectId: 'dummy-project-id',
      ),
    );
    when(() => mockFirebaseApp.options).thenReturn(
      firebaseOptionsFromMap({
        'apiKey': 'apiKey',
        'appId': 'appId',
        'messagingSenderId': 'messagingSenderId',
        'projectId': 'projectId',
      }),
    );
    when(() => Firebase.initializeApp(options: any()))
        .thenAnswer((_) async => mockFirebaseApp);
    await Firebase.initializeApp();
  });

// import 'package:cinetalks/widgets/horizontal_scroll_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:cinetalks/models/movie_model.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:cinetalks/screens/profile_screen.dart';
// import 'package:firebase_core/firebase_core.dart';

// class MockFirebaseApp extends Mock implements FirebaseApp {}

// final mockFirebaseApp = MockFirebaseApp();

// FirebaseOptions firebaseOptionsFromMap(Map<String, String> optionsMap) {
//   return FirebaseOptions(
//     apiKey: optionsMap['apiKey']!,
//     appId: optionsMap['appId']!,
//     messagingSenderId: optionsMap['messagingSenderId']!,
//     projectId: optionsMap['projectId']!,
//   );
// }

// void main() {
//   setUpAll(() async {
//     // Initialize the mock Firebase app
//     // registerFallbackValue(
//     //   FirebaseOptions(
//     //     apiKey: 'dummy-api-key',
//     //     appId: 'dummy-app-id',
//     //     messagingSenderId: 'dummy-messaging-sender-id',
//     //     projectId: 'dummy-project-id',
//     //   ),
//     // );
//     when(mockFirebaseApp.options).thenReturn(
//       firebaseOptionsFromMap({
//         'apiKey': 'apiKey',
//         'appId': 'appId',
//         'messagingSenderId': 'messagingSenderId',
//         'projectId': 'projectId',
//       }),
//     );
//     when(Firebase.initializeApp(options: anyNamed('options'))).thenAnswer((_) async => mockFirebaseApp);
//     await Firebase.initializeApp();
//   });
  group('Lists', () {
    testWidgets('ProfileScreen contains HorizontalScrollList for favorites',
        (WidgetTester tester) async {
      // Build the ProfileScreen widget
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

      // Check if there's a HorizontalScrollList for favorites
      expect(find.byType(HorizontalScrollList), findsNWidgets(2));
      expect(find.text('Your Watched List'), findsOneWidget);
    });

    testWidgets('ProfileScreen contains HorizontalScrollList for watchlist',
        (WidgetTester tester) async {
      // Build the ProfileScreen widget
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

      // Check if there's a HorizontalScrollList for watchlist
      expect(find.byType(HorizontalScrollList), findsNWidgets(2));
      expect(find.text('Your To-Watch List'), findsOneWidget);
    });

    testWidgets('ProfileScreen contains TextButton to see all favorites',
        (WidgetTester tester) async {
      // Build the ProfileScreen widget
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

      // Check if there's a TextButton to see all favorites
      expect(find.byType(TextButton), findsNWidgets(2));
      expect(find.widgetWithText(TextButton, 'See All'), findsOneWidget);
    });
  });

  group('Top buttons', () {
    testWidgets('ProfileScreen contains Back button',
        (WidgetTester tester) async {
      // Build the ProfileScreen widget
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

      // Check if there's a Back button
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('ProfileScreen contains Logout button',
        (WidgetTester tester) async {
      // Build the ProfileScreen widget
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

      // Check if there's a Logout button
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });
  });
}
