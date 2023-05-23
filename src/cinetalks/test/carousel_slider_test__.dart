import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinetalks/models/movie_model.dart';
import 'package:cinetalks/widgets/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  // testWidgets("Testing the carousel slider", (WidgetTester tester) async {
  //   final mockObserver = MockNavigatorObserver();

  //   List<Movie> movies = [
  //     Movie(
  //         id: '1',
  //         title: 'first',
  //         year: 2000,
  //         imagePath:
  //             'https://m.media-amazon.com/images/M/MV5BZGFmOTA0YmUtYmFiYS00ZWIyLWE2YWItNjg3YWMxNjM0N2MwXkEyXkFqcGdeQXVyNjg1MjE2MDc@._V1_.jpg',
  //         category: 'Drama',
  //         duration: Duration(hours: 2, minutes: 2),
  //         plot: 'A good movie',
  //         imdbRating: '10',
  //         ranking: '1'),
  //     Movie(
  //         id: '2',
  //         title: 'second',
  //         year: 2001,
  //         imagePath:
  //             'https://m.media-amazon.com/images/M/MV5BZGFmOTA0YmUtYmFiYS00ZWIyLWE2YWItNjg3YWMxNjM0N2MwXkEyXkFqcGdeQXVyNjg1MjE2MDc@._V1_.jpg',
  //         category: 'Drama',
  //         duration: Duration(hours: 3, minutes: 3),
  //         plot: 'A good movie',
  //         imdbRating: '9',
  //         ranking: '2'),
  //     Movie(
  //         id: '3',
  //         title: 'third',
  //         year: 2002,
  //         imagePath:
  //             'https://m.media-amazon.com/images/M/MV5BZGFmOTA0YmUtYmFiYS00ZWIyLWE2YWItNjg3YWMxNjM0N2MwXkEyXkFqcGdeQXVyNjg1MjE2MDc@._V1_.jpg',
  //         category: 'Drama',
  //         duration: Duration(hours: 4, minutes: 4),
  //         plot: 'A good movie',
  //         imdbRating: '8',
  //         ranking: '3'),
  //   ];

  //   await tester.pumpWidget(MaterialApp(
  //     home: SafeArea(
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: CarouselSliderWidget(
  //               movies: movies,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     navigatorObservers: [mockObserver],
  //   ));

  //   expect(find.text('first'), findsOneWidget);
  //   expect(find.text('2000 • 2h 2min • Drama'), findsOneWidget);
  //   expect(find.text('IMDb 10/10'), findsOneWidget);
  //   expect(find.byType(DecorationImage), findsOneWidget);
  //   expect(find.byType(BackdropFilter), findsOneWidget);

  //   expect(find.text('second'), findsOneWidget);
  //   expect(find.text('2001 • 3h 3min • Drama'), findsOneWidget);
  //   expect(find.text('IMDb 9/10'), findsOneWidget);

  //   expect(find.text('third'), findsOneWidget);
  //   expect(find.text('2002 • 4h 4min • Drama'), findsOneWidget);
  //   expect(find.text('IMDb 8/10'), findsOneWidget);
  // });

  testWidgets('CarouselSliderWidget displays correct movie information',
      (WidgetTester tester) async {
    // Create a list of movies to display in the widget
    final movies = [
      Movie(
        id: '1',
        title: 'Movie 1',
        year: 2022,
        duration: Duration(minutes: 120),
        category: 'Action',
        imdbRating: '8.5',
        imagePath: 'https://example.com/movie1.jpg',
        plot: 'A good movie',
        ranking: '1',
      ),
      Movie(
        id: '2',
        title: 'Movie 2',
        year: 2021,
        duration: Duration(minutes: 90),
        category: 'Comedy',
        imdbRating: '7.8',
        imagePath: 'https://example.com/movie2.jpg',
        plot: 'A good movie',
        ranking: '1',
      ),
    ];

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: CarouselSliderWidget(
                      movies: movies,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // Verify that the widget displays the correct movie information
    expect(find.text('Movie 1'), findsOneWidget);
    expect(find.text('2022 • 2h 0m • Action'), findsOneWidget);
    expect(find.text('8.5'), findsOneWidget);

    //scroll to the next movie
    await tester.drag(find.byType(CarouselSliderWidget), Offset(-600.0, 0.0),
        warnIfMissed: true);

    expect(find.text('Movie 2'), findsOneWidget);
    expect(find.text('2021 • 1h 30m • Comedy'), findsOneWidget);
    expect(find.text('7.8'), findsOneWidget);
  });
}
