import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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
      {
        'id': '3',
        'title': 'Movie 3',
        'imagePath': 'https://example.com/image3.jpg'
      }
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              HorizontalScrollList(
                boxWidth: 150,
                boxHeight: 200,
                items: items,
              ),
            ],
          ),
        ),
        navigatorObservers: [mockObserver],
      ),
    );

    expect(find.byType(HorizontalScrollList), findsOneWidget);

    expect(find.text('Movie 1'), findsOneWidget);
    expect(find.text('Movie 2'), findsOneWidget);
    expect(find.text('Movie 3'), findsOneWidget);

    expect(find.byType(GestureDetector), findsNWidgets(items.length));
    expect(find.byType(Image), findsNWidgets(items.length));
  });
}
