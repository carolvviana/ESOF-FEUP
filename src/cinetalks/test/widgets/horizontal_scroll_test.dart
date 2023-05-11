import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:cinetalks/models/movie_model.dart';
import 'package:cinetalks/screens/movie_show_screen.dart';
import 'package:cinetalks/widgets/horizontal_scroll_list.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('HorizontalScrollList displays items',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    final items = [
      {
        'id': '1',
        'title': 'Movie 1',
        'imagePath': 'https://example.com/image1.jpg'
      },
      {
        'id': '2',
        'title': 'Movie 2',
        'imagePath': 'https://example.com/image2.jpg'
      },
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: HorizontalScrollList(
              boxWidth: 150,
              boxHeight: 200,
              items: items,
            ),
          ),
        ),
        navigatorObservers: [mockObserver],
      ),
    );

    expect(find.text('Movie 1'), findsOneWidget);
    expect(find.text('Movie 2'), findsOneWidget);

    // Tap on the first item and verify that it navigates to the correct screen
    await tester.tap(find.byKey(Key('1')));
    await tester.pumpAndSettle();

    verify(mockObserver.didPush(any, any)).called(1);
    expect(find.byType(MovieShowScreen), findsOneWidget);
    expect(find.text('Movie 1'), findsOneWidget);
  });
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
