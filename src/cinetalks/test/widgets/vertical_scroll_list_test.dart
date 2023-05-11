import 'package:cinetalks/models/movie_model.dart';
import 'package:cinetalks/screens/movie_show_screen.dart';
import 'package:cinetalks/widgets/vertical_scroll_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('VerticalScrollList displays items', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    final items = [
        Movie(
            id: '1',
            title: 'Movie 1',
            imagePath: 'https://example.com/image1.jpg',
            plot: 'Plot 1',
            year: 2020,
            duration: Duration(minutes: 120),
            imdbRating: '8.0',
            category: 'Action',
            ranking: '1',
        ),
        Movie(
            id: '2',
            title: 'Movie 2',
            imagePath: 'https://example.com/image2.jpg',
            plot: 'Plot 2',
            year: 2020,
            duration: Duration(minutes: 120),
            imdbRating: '8.0',
            category: 'Action',
            ranking: '1',
        ),
        Movie(
            id: '3',
            title: 'Movie 3',
            imagePath: 'https://example.com/image3.jpg',
            plot: 'Plot 3',
            year: 2020,
            duration: Duration(minutes: 120),
            imdbRating: '8.0',
            category: 'Action',
            ranking: '1',
        ),
    ];

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: VerticalScrollList(
              boxWidth: 150,
              boxHeight: 200,
              items: items,
            ),
          ),
        ),
        navigatorObservers: [mockObserver],
      ),
    );

    expect(find.byType(VerticalScrollList), findsOneWidget);

    expect(find.text('Movie 1'), findsOneWidget);
    expect(find.text('Movie 2'), findsOneWidget);
    expect(find.text('Movie 3'), findsOneWidget);

    expect(find.byType(Image), findsNWidgets(3));
    
    await tester.tap(find.byKey(Key('1')));
    await tester.pumpAndSettle();

    Route<dynamic> route = MaterialPageRoute(builder: (context) => MovieShowScreen(id: items[0].id));
    Route<dynamic>? previousRoute = null;
    verify(mockObserver.didPush(route, previousRoute)).called(1);

    // await tester.tap(find.byKey(Key('2')));
    // await tester.pumpAndSettle();

    // route = MaterialPageRoute(builder: (context) => MovieShowScreen(id: items[1].id));
    // previousRoute = MaterialPageRoute(builder: (context) => MovieShowScreen(id: items[0].id));
    // verify(mockObserver.didPush(route, previousRoute)).called(1);

    // await tester.tap(find.byKey(Key('3')));
    // await tester.pumpAndSettle();

    // route = MaterialPageRoute(builder: (context) => MovieShowScreen(id: items[2].id));
    // previousRoute = MaterialPageRoute(builder: (context) => MovieShowScreen(id: items[1].id));
    // verify(mockObserver.didPush(route, previousRoute)).called(1);
  }); 
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
 

