import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:cinetalks/api/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:cinetalks/dependencies/dependencies.dart';
import 'package:cinetalks/models/movie_model.dart';

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
          'imagePath':
              'https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@.jpg',
        },
        {
          'id': 'tt0068646',
          'title': 'The Godfather',
          'imagePath':
              'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@.jpg',
        },
        {
          'id': 'tt0468569',
          'title': 'The Dark Knight',
          'imagePath':
              'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@.jpg',
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

  group('fetchTopTVShows', () {
    test("returns a list of tv shows if the http request completes sucessfully",
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
          'imagePath':
              'https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@.jpg',
        },
        {
          'id': 'tt0068646',
          'title': 'The Godfather',
          'imagePath':
              'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@.jpg',
        },
        {
          'id': 'tt0468569',
          'title': 'The Dark Knight',
          'imagePath':
              'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@.jpg',
        }
      ];

      final result = await fetchTopTVShows();
      expect(result, expected);
    });

    test('throws an exception if the http call completes with an error',
        () async {
      // Use Mockito to return an unsuccessful response when it calls the provided http.Client.
      when(() => httpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) => Future.value(http.Response('Not Found', 404)));

      expect(fetchTopTVShows(), throwsException);
    });
  });

  group('fetchDetails', () {
    test("returns movie details if the http request completes sucessfully",
        () async {
      //read html file
      final mockedHttpResponse =
          File('test/mocks/movie_details.html').readAsStringSync();

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => await http.Response(mockedHttpResponse, 200),
      );

      final Movie expected = Movie(
        id: "tt0468569",
        title: "The Dark Knight",
        year: 2008,
        imagePath:
            "https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg",
        category: "Action, Crime, Drama, Thriller",
        duration: Duration(hours: 2, minutes: 32),
        plot:
            "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
        imdbRating: "9",
        ranking: "111",
      );

      final result = await fetchDetails("any");

      expect(result.id, expected.id);
      expect(result.title, expected.title);
      expect(result.year, expected.year);
      expect(result.imagePath, expected.imagePath);
      expect(result.category, expected.category);
      expect(result.duration, expected.duration);
      expect(result.plot, expected.plot);
      expect(result.imdbRating, expected.imdbRating);
      expect(result.ranking, expected.ranking);
    });

    test('throws an exception if the http call completes with an error',
        () async {
      // Use Mockito to return an unsuccessful response when it calls the provided http.Client.
      when(() => httpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) => Future.value(http.Response('Not Found', 404)));

      expect(fetchDetails("any"), throwsException);
    });
  });

  group('fetchYoutubeTrailer', () {
    test(
        "returns a link for the trailer if the http request completes sucessfully",
        () async {
      //read html file
      final mockedHttpResponse =
          File('test/mocks/trailer.json').readAsStringSync();

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => await http.Response(mockedHttpResponse, 200),
      );

      final String expected = "https://www.youtube.com/watch?v=K_tLp7T6U1c";

      final result = await fetchYoutubeTrailer("any");
      expect(result, expected);
    });

    test('throws an exception if the http call completes with an error',
        () async {
      // Use Mockito to return an unsuccessful response when it calls the provided http.Client.
      when(() => httpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) => Future.value(http.Response('Not Found', 404)));

      expect(fetchYoutubeTrailer("any"), throwsException);
    });
  });

  group('searchMedia', () {
    test("returns a list of movies if the http request completes sucessfully",
        () async {
      //read html file
      final mockedHttpResponse = File('test/mocks/search_media.json').readAsStringSync();

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => await http.Response(mockedHttpResponse, 200),
      );

      final List<Movie> expected = [
        Movie(
          id: "tt0068646",
          title: "The Godfather",
          year: 2020,
          imagePath:
              "https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg",
          category: "",
          duration: Duration(minutes: 0),
          plot: "",
          imdbRating: "",
          ranking: "",
        ),
        Movie(
          id: "tt0071562",
          title: "The Godfather Part II",
          year: 2020,
          imagePath:
              "https://m.media-amazon.com/images/M/MV5BMWMwMGQzZTItY2JlNC00OWZiLWIyMDctNDk2ZDQ2YjRjMWQ0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg",
          category: "",
          duration: Duration(minutes: 0),
          plot: "",
          imdbRating: "",
          ranking: "",
        ),
        Movie(
          id: "tt0099674",
          title: "The Godfather Part III",
          year: 2020,
          imagePath:
              "https://m.media-amazon.com/images/M/MV5BNWFlYWY2YjYtNjdhNi00MzVlLTg2MTMtMWExNzg4NmM5NmEzXkEyXkFqcGdeQXVyMDk5Mzc5MQ@@._V1_.jpg",
          category: "",
          duration: Duration(minutes: 0),
          plot: "",
          imdbRating: "",
          ranking: "",
        )
      ];

      final result = await searchMedia("any");
      
      
      expect(result[0].id, expected[0].id);
      expect(result[0].title, expected[0].title);
      expect(result[0].year, expected[0].year);
      expect(result[0].imagePath, expected[0].imagePath);
      expect(result[0].category, expected[0].category);
      expect(result[0].duration, expected[0].duration);
      expect(result[0].plot, expected[0].plot);
      expect(result[0].imdbRating, expected[0].imdbRating);
      expect(result[0].ranking, expected[0].ranking);

      expect(result[1].id, expected[1].id);
      expect(result[1].title, expected[1].title);
      expect(result[1].year, expected[1].year);
      expect(result[1].imagePath, expected[1].imagePath);
      expect(result[1].category, expected[1].category);
      expect(result[1].duration, expected[1].duration);
      expect(result[1].plot, expected[1].plot);
      expect(result[1].imdbRating, expected[1].imdbRating);
      expect(result[1].ranking, expected[1].ranking);

      expect(result[2].id, expected[2].id);
      expect(result[2].title, expected[2].title);
      expect(result[2].year, expected[2].year);
      expect(result[2].imagePath, expected[2].imagePath);
      expect(result[2].category, expected[2].category);
      expect(result[2].duration, expected[2].duration);
      expect(result[2].plot, expected[2].plot);
      expect(result[2].imdbRating, expected[2].imdbRating);
      expect(result[2].ranking, expected[2].ranking);

      expect(result.length, expected.length);
    });

    test('throws an exception if the http call completes with an error',
        () async {
      // Use Mockito to return an unsuccessful response when it calls the provided http.Client.
      when(() => httpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) => Future.value(http.Response('Not Found', 404)));

      expect(searchMedia("any"), throwsException);
    });
  });
}
