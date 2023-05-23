import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:cinetalks/api/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:cinetalks/dependencies/dependencies.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri());
    httpClient = MockClient();
  });
  group('fetchTopMovies', () {
    test("returns a list of movies if the http request completes sucessfully",
        () async {
      //read html file
      final mockedHttpResponse =
          File('test/mocks/top_movies.html').readAsStringSync();

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
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

    test('throws an exception if the http call completes with an error',
        () async {
      // Use Mockito to return an unsuccessful response when it calls the provided http.Client.
      when(() => httpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) => Future.value(http.Response('Not Found', 404)));

      expect(fetchTopMovies(), throwsException);
    });
  });
}
