import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:cinetalks/api/api_services.dart';
import 'package:http/http.dart' as http;

// Mock HTTP client class

class MockClient extends Mock implements http.Client {}

void main() {
  group('fetchTopMovies', () {
    setUpAll(() {
      registerFallbackValue(Uri());
    });
    test("returns a list of movies if the http request completes sucessfully",
        () async {
      final client = MockClient();

      final mockedHttpResponse = {
        {
          'id': 'tt0111161',
          'title': 'The Shawshank Redemption',
          'imagePath': 'https://example.com',
        },
        {
          'id': 'tt0068646',
          'title': 'The Godfather',
          'imagePath': 'https://example.com',
        },
        {
          'id': 'tt0071562',
          'title': 'The Godfather: Part II',
          'imagePath': 'https://example.com',
        }
      }.toString();

      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
        (_) async => await http.Response(mockedHttpResponse, 200),
      );

      final List<Map<String, dynamic>> expected = [
        {
          'id': 'tt0111161',
          'title': 'The Shawshank Redemption',
          'imagePath': 'https://example.com',
        },
        {
          'id': 'tt0068646',
          'title': 'The Godfather',
          'imagePath': 'https://example.com',
        },
        {
          'id': 'tt0071562',
          'title': 'The Godfather: Part II',
          'imagePath': 'https://example.com',
        }
      ];

      final result = await fetchTopMovies();
      expect(result, expected);
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the provided http.Client.
      when(() => client.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) => Future.value(http.Response('Not Found', 404)));

      expect(fetchTopMovies(), throwsException);
    });
  });
}
