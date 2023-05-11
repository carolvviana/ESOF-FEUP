import 'package:cinetalks/models/movie_model.dart';
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

    // verify(mockObserver.didPush(route, previousRoute));
  }); 
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
} Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 0,
            mainAxisExtent: boxHeight + 60,
            // childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            // print(items[index].title);
            return GestureDetector(
              key: Key(items[index].id),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieShowScreen(id: items[index].id),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      image: CachedNetworkImageProvider(items[index].imagePath),
                      fit: BoxFit.cover,
                      width: boxWidth,
                      height: boxHeight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: boxWidth,
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textWidthBasis: TextWidthBasis.parent,
                      items[index].title,
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
