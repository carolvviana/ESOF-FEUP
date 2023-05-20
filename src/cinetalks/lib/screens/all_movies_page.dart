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
