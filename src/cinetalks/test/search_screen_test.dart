import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:cinetalks/dependencies/dependencies.dart';
import 'package:cinetalks/screens/search_screen.dart';


class MockClient extends Mock implements http.Client {}

void main() {
   setUpAll(() {
    registerFallbackValue(Uri());
    httpClient = MockClient();
  });
  testWidgets('SearchPage should update search results', (WidgetTester tester) async {    
    final mockedHttpResponse = File('test/mocks/search_media.json').readAsStringSync();
    
    when(() => httpClient.get(any(), headers: any(named: 'headers')))
    .thenAnswer((_) async => await http.Response(mockedHttpResponse, 200));
    
    // Build widget tree
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: SearchPage())));

    // Tap search bar and enter query
    await tester.enterText(find.byType(TextField), 'godfather');
    await tester.pumpAndSettle();

    // Verify search results
    expect(find.text('The Godfather'), findsOneWidget);
    expect(find.text('The Godfather Part II'), findsOneWidget);
    expect(find.text('The Godfather Part III'), findsOneWidget);
  });
}
