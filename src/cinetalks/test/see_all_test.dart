import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cinetalks/models/movie_model.dart';
import 'package:cinetalks/screens/see_all_pages.dart';
import 'package:cinetalks/widgets/vertical_scroll_list.dart';


void main() {
  testWidgets('SeeAllPage contains VerticalScrollList', (WidgetTester tester) async {
    // Prepare sample data for the test
    List<Map<String, dynamic>> sampleItems = [
      {
        'id': 'tt0068646',
        'title': 'The Godfather',
        'year': 1972,
        'imagePath': 'https://example.com/image.jpg',
        'category': 'feature',
        'duration': 0,
        'plot': '',
        'imdbRating': '',
        'ranking': '',
      },
      // Add more items if needed
    ];

    // Build the SeeAllPage widget
    await tester.pumpWidget(MaterialApp(
      home: SeeAllPage(items: sampleItems, pageTitle: 'Test Page'),
    ));

    // Check if there's a VerticalScrollList
    expect(find.byType(VerticalScrollList), findsOneWidget);
  });
}