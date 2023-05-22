import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinetalks/widgets/video_player.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Video player works correctly', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VideoPlayerScreen(
            videoUrl: 'https://www.youtube.com/watch?v=7lCDEYXw3mM',
          ),
        ),
        navigatorObservers: [mockObserver],
      ),
    );

    expect(find.byType(VideoPlayerScreen), findsOneWidget);
  });
}
