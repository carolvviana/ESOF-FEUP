import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'search_parameters.dart';

import '../models/movie_model.dart';

// k_mgeyovhl guardar para aula

//
// k_ehiwsy71
// k_8v04708r
// k_1c995682
Future<List<Map<String, dynamic>>> fetchTopMovies() async {
  final response = await http.get(
      Uri.parse('https://www.imdb.com/chart/top/?ref_=nv_mv_250'),
      headers: {'Accept-Language': 'en'});

  if (response.statusCode == 200) {
    final htmlString = response.body;
    final document = dom.Document.html(htmlString);

    List<Map<String, dynamic>> metaList =
        document.querySelectorAll('.posterColumn').map((element) {
      final imagePath = element.querySelector('img')!.attributes['src']!;
      return {
        'id': element.querySelector('a')!.attributes['href']!.split('/')[2],
        'title': element.querySelector('img')!.attributes['alt']!,
        'imagePath':
            '${imagePath.substring(0, imagePath.lastIndexOf('.', imagePath.lastIndexOf('.') - 1))}${imagePath.substring(imagePath.lastIndexOf('.'))}',
      };
    }).toList();

    return metaList;
  } else {
    throw Exception('Failed to fetch top movies');
  }
}

Future<List<Map<String, dynamic>>> fetchTopTVShows() async {
  final response = await http.get(
      Uri.parse('https://www.imdb.com/chart/toptv/?ref_=nv_tvv_250'),
      headers: {'Accept-Language': 'en'});

  if (response.statusCode == 200) {
    final htmlString = response.body;
    final document = dom.Document.html(htmlString);

    List<Map<String, dynamic>> metaList =
        document.querySelectorAll('.posterColumn').map((element) {
      final imagePath = element.querySelector('img')!.attributes['src']!;
      return {
        'id': element.querySelector('a')!.attributes['href']!.split('/')[2],
        'title': element.querySelector('img')!.attributes['alt']!,
        'imagePath':
            '${imagePath.substring(0, imagePath.lastIndexOf('.', imagePath.lastIndexOf('.') - 1))}${imagePath.substring(imagePath.lastIndexOf('.'))}',
      };
    }).toList();

    return metaList;
  } else {
    throw Exception('Failed to fetch top movies');
  }
}

Future<List<Movie>> fetchInTheaters() async {
  final response = await http.get(
    Uri.parse('https://imdb-api.com/en/API/InTheaters/k_sl0727cr'),
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
          category: movieJson['genres'],
          duration: Duration(minutes: int.parse(movieJson['runtimeMins'])),
          plot: "",
          imdbRating: movieJson['imDbRating'],
          ranking: '');
    }).toList();

    return movies;
  } else {
    throw Exception('Failed to load In Theaters');
  }
}
/*
Future<String> fetchYoutubeTrailer(String id) async {
  final response = await http.get(
    Uri.parse('https://imdb-api.com/en/API/Top250Movies/k_sl0727cr'),
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
    Uri.parse('https://imdb-api.com/en/API/Top250TVs/k_sl0727cr'),
  );

  if (response.statusCode == 200) {
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
    throw Exception('Failed to load Top 250 TV Shows');
  }
}
*/

Future<String> fetchYoutubeTrailer(String id) async {
  final response = await http.get(
    Uri.parse('https://imdb-api.com/en/API/YoutubeTrailer/k_ehiwsyz71/$id'),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)['videoUrl'];
  } else {
    throw Exception('Failed to load Youtube Trailer');
  }
}

Future<Movie> fetchDetails(String id) async {
  final response = await http.get(Uri.parse('https://www.imdb.com/title/$id'),
      headers: {'Accept-Language': 'en'});

  if (response.statusCode == 200) {
    final htmlString = response.body;
    final document = dom.Document.html(htmlString);
    final movieData = document.querySelector('#__NEXT_DATA__')!;
    final movieJson = json.decode(movieData.innerHtml);

    final jsonData = movieJson['props']['pageProps']['aboveTheFoldData'];
    // print("HERE");
    // print(jsonData['id'].toString());
    // print(jsonData['originalTitleText']['text'].toString());
    // print(jsonData['releaseYear']['year'].toInt());
    // print(jsonData['primaryImage']['url'].toString());
    // print(jsonData['genres']['genres']
    //     .map((json) => json['text'])
    //     .toList()
    //     .join(', ')
    //     .toString());
    // print(Duration(seconds: jsonData['runtime']['seconds']));
    // print(jsonData['plot']['plotText']['plainText'].toString());
    // print(jsonData['ratingsSummary']['aggregateRating'].toString());
    // print(jsonData['meterRanking']['currentRank'].toString());

    Movie movie = Movie(
      id: jsonData['id'].toString(),
      title: jsonData['originalTitleText']['text'].toString(),
      year: jsonData['releaseYear']['year'].toInt(),
      imagePath: jsonData['primaryImage']['url'].toString(),
      category: jsonData['genres']['genres']
          .map((json) => json['text'])
          .toList()
          .join(', ')
          .toString(),
      duration: Duration(seconds: jsonData['runtime']['seconds']),
      plot: jsonData['plot']['plotText']['plainText'].toString(),
      imdbRating: jsonData['ratingsSummary']['aggregateRating'].toString(),
      ranking: jsonData['meterRanking']['currentRank'].toString(),
    );

    return movie;
  } else {
    throw Exception('Failed to load Movie Details');
  }
}

Future<List<Movie>> searchMedia(String query) async {
  query = Uri.encodeComponent(query);
  final String url = "https://v3.sg.media-imdb.com/suggestion/x/$query.json";

  final response = await http.get(Uri.parse(url));
  final data = jsonDecode(response.body);
  // final results = data['results'] as List<dynamic>;
  final results = data['d'] as List<dynamic>;
  final List<Movie> aux = [];
  final List<Movie> ret = [];

  return results.where((result) => (result["qid"]) != null).map((result) {
    final title = result['l'] as String;
    final year = 2020; //result['y'] as int;
    final imagePath =
        result['i'] != null ? result['i']['imageUrl'] as String : "";
    // final category = "Drama"; //result['q'] as String;
    // final duration = result['s'] as String;
    // final plot = result['s'] as String;
    // final imdbRating = result['rank'] as String;

    {
      return Movie(
        id: result['id'].toString(),
        title: title,
        year: year,
        imagePath: imagePath,
        category: "",
        duration: Duration(minutes: 0),
        plot: "",
        imdbRating: "",
        ranking: '',
      );
    }
  }).toList();
}
