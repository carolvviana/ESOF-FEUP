import 'dart:convert';
import 'package:http/http.dart' as http;
import 'search_parameters.dart';

import '/models/movie_model.dart';

Future<List<Movie>> fetchTop250Movies() async {
  final response = await http.get(
    Uri.parse('https://imdb-api.com/en/API/Top250Movies/k_ehiwsy71'),
  );

  if (response.statusCode == 200) {
    /* map to the List<Movie> */

    final data = json.decode(response.body);
    // print(data);
    final List<dynamic> moviesJson = data['items'];

    List<Movie> movies = moviesJson.map((movieJson) {
      return Movie(
        id: movieJson['id'],
        title: movieJson['title'],
        year: int.parse(movieJson['year']),
        imagePath: movieJson['image'],
        category: "",
        duration: Duration(minutes: 0),
        plot: "",
        imdbRating: movieJson['imDbRating'],
      );
    }).toList();

    return movies;
  } else {
    throw Exception('Failed to load Top 250 Movies');
  }
}

Future<List<Movie>> fetchTop250TvShows() async {
  final response = await http.get(
    Uri.parse('https://imdb-api.com/en/API/Top250TVs/k_q8cbumjq'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load Top 250 TV Shows');
  }
}

Future<List<Movie>> fetchInTheaters() async {
  final response = await http.get(
    Uri.parse('https://imdb-api.com/en/API/InTheaters/k_q8cbumjq'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load In Theaters');
  }
}

Future<List<Movie>> fetchYoutubeTrailer(String id) async {
  final response = await http.get(
    Uri.parse('https://imdb-api.com/en/API/YoutubeTrailer/k_q8cbumjq/$id'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load Youtube Trailer');
  }
}

Future<Movie> fetchMovieTvShowDetails(String id) async {
  final response = await http.get(
    Uri.parse('https://imdb-api.com/en/API/Title/k_ehiwsy71/$id'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    return Movie(
      id: data['id'],
      title: data['title'],
      year: int.parse(data['year']),
      imagePath: data['image'],
      category: data['genres'],
      duration: Duration(minutes: int.parse(data['runtimeMins'])),
      //duration: data['runtimeMins'],
      plot: data['plot'],
      imdbRating: data['imDbRating'],
    );
  } else {
    throw Exception('Failed to load Movie/TV Show Details');
  }
}

Future<List<Movie>> fetchRatings(String id) async {
  final response = await http.get(
    Uri.parse('https://imdb-api.com/en/API/UserRatings/k_q8cbumjq/$id'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load Rating');
  }
}

Future<List<Movie>> fetchSearchResults(
    SearchParameters searchParameters) async {
  final response = await http.get(
    Uri.parse(
        'https://imdb-api.com/API/AdvancedSearch/k_q8cbumjq?title=${searchParameters.title}&title_type=${searchParameters.titleTypes.join(',')}&user_rating=,${searchParameters.userRating}&release_date=,${searchParameters.releaseDate}-01-01&genres=${searchParameters.genres.join(',')}&groups=${searchParameters.groups}&sort=${searchParameters.sort}'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load Search Results');
  }
}
