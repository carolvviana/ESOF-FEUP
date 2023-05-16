/*import 'package:cinetalks/models/movie_model.dart';
import 'package:cinetalks/screens/movie_show_screen.dart';
import 'package:flutter/material.dart';

class AllMoviesPage extends StatelessWidget {
  final List<Map<String, dynamic>> movies;
  const AllMoviesPage({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A2A2A), // set the background color to grey
        title: const Text('All Movies'),
      ),
      backgroundColor: const Color(0xFF2A2A2A),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 8,
          childAspectRatio: 0.6,
        ),
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieShowScreen(id: movies[index]['id']),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.network(
                        movies[index]['imagePath'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movies[index]['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
*/

import 'package:cinetalks/screens/movie_show_screen.dart';
import 'package:cinetalks/widgets/bottom_navbar.dart';
import 'package:cinetalks/widgets/vertical_scroll_list.dart';
import 'package:flutter/material.dart';

import '../models/movie_model.dart';

class AllMoviesPage extends StatelessWidget {
  final List<Map<String, dynamic>> movies;

  const AllMoviesPage({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text('All Movies'),
      ),
      backgroundColor: const Color(0xFF2A2A2A),
      body: Column(
        children: [
          VerticalScrollList(
            boxWidth: MediaQuery.of(context).size.width * 0.45,
            boxHeight: MediaQuery.of(context).size.height * 0.26,
            items: movies
                .map((movie) => Movie(
                      id: movie['id'],
                      title: movie['title'],
                      imagePath: movie['imagePath'],
                      category: "",
                      year: 0,
                      duration: Duration(minutes: 0),
                      plot: "",
                      imdbRating: "",
                      ranking: "",
                    ))
                .toList(),
          ),
        ],
      ),
    );

  }
}
