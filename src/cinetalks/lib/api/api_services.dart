import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../models/movie_model.dart';

import 'package:cinetalks/dependencies/dependencies.dart';

// k_mgeyovhl guardar para aula

//
// k_ehiwsy71
// k_8v04708r
// k_1c995682

String api_key = "k_ehiwsy71";

Future<List<Map<String, dynamic>>> fetchTopMovies() async {
  final response = await httpClient.get(
      Uri.parse('https://www.imdb.com/chart/top/?ref_=nv_mv_250'),
      headers: {'content-type': 'application/json', 'Accept-language': 'en'});

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
  final response = await httpClient.get(
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
  final response = await httpClient.get(
      Uri.parse('https://imdb-api.com/en/API/InTheaters/$api_key'),
      headers: {'content-type': 'application/json', 'Accept-Language': 'en'});

  if (response.statusCode == 200) {
    /* map to the List<Movie> */

    final data = json.decode(response.body);

    final List<dynamic> moviesJson = data['items'];

    List<Movie> movies = moviesJson.map((movieJson) {
      return Movie(
          id: movieJson['id'],
          title: movieJson['title'],
          year: movieJson['year'] == "" ? 0 : int.parse(movieJson['year']),
          imagePath: movieJson['image'],
          category: movieJson['genres'],
          duration: Duration(minutes: int.parse(movieJson['runtimeMins'])),
          plot: "",
          imdbRating:
              movieJson['imDbRating'] == "" ? "0.0" : movieJson['imDbRating'],
          ranking: '');
    }).toList();

    return movies;
  } else {
    throw Exception('Failed to load In Theaters');
  }
}

Future<String> fetchYoutubeTrailer(String id) async {
  final response = await httpClient.get(
      Uri.parse('https://imdb-api.com/en/API/YoutubeTrailer/$api_key/$id'),
      headers: {'Accept-Language': 'en'});

  if (response.statusCode == 200) {
    return json.decode(response.body)['videoUrl'];
  } else {
    throw Exception('Failed to load Youtube Trailer');
  }
}

Future<Movie> fetchDetails(String id) async {
  final response = await httpClient.get(
      Uri.parse('https://www.imdb.com/title/$id'),
      headers: {'Accept-Language': 'en'});

  if (response.statusCode == 200) {
    final htmlString = response.body;
    final document = dom.Document.html(htmlString);
    final movieData = document.querySelector('#__NEXT_DATA__')!;
    final movieJson = json.decode(movieData.innerHtml);

    final jsonData = movieJson['props']['pageProps']['aboveTheFoldData'];

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

  final response =
      await httpClient.get(Uri.parse(url), headers: {'Accept-Language': 'en'});

  if (response.statusCode == 200) {
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
  } else {
    throw Exception('Failed to load search results');
  }
}

/*
Future<String> fetchYoutubeTrailer(String id) async {
  final response = await http.get(
    Uri.parse('https://imdb-api.com/en/API/Top250Movies/$api_key'),
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
    Uri.parse('https://imdb-api.com/en/API/Top250TVs/$api_key'),
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

Future<List<Movie>> fetchInTheatersScrape() async {
  final response = await httpClient.get(
      Uri.parse(
          'https://www.imdb.com/chart/boxoffice?pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=470df400-70d9-4f35-bb05-8646a1195842&pf_rd_r=ENXH2SSKG9YFCW55WK1H&pf_rd_s=right-4&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_ql_1'),
      headers: {'Accept-Language': 'en'});

  if (response.statusCode == 200) {
    final htmlString = response.body;
    final document = dom.Document.html(htmlString);

    List<Movie> metaList =
        document.querySelectorAll('.posterColumn').map((element) {
      final imagePath = element.querySelector('img')!.attributes['src']!;
      return Movie(
          id: element.querySelector('a')!.attributes['href']!.split('/')[2],
          title: element.querySelector('img')!.attributes['alt']!,
          imagePath:
              '${imagePath.substring(0, imagePath.lastIndexOf('.', imagePath.lastIndexOf('.') - 1))}${imagePath.substring(imagePath.lastIndexOf('.'))}',
          year: 2023,
          category: '',
          duration: Duration(minutes: 127),
          plot: "",
          imdbRating: '7',
          ranking: '');
    }).toList();

    return metaList;
  } else {
    throw Exception('Failed to fetch top movies');
  }
}
