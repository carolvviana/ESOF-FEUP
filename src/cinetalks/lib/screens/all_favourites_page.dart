import 'package:flutter/material.dart';
import 'package:cinetalks/models/movie_model.dart';
import 'package:cinetalks/widgets/bottom_navbar.dart';
import 'package:cinetalks/widgets/vertical_scroll_list.dart';

class AllFavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favorites;

  const AllFavoritesPage({Key? key, required this.favorites})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = favorites
        .map((data) => Movie(
              id: data['id'] ?? '',
              title: data['title'] ?? '',
              year: data['year'] ?? 0,
              imagePath: data['imagePath'] ?? '',
              category: data['category'] ?? '',
              duration: data['duration'] != null ? Duration(minutes: data['duration']) : Duration.zero,
              plot: data['plot'] ?? '',
              imdbRating: data['imdbRating'] ?? '',
              ranking: data['ranking'] ?? '',
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text('All Favorites'),
      ),
      backgroundColor: const Color(0xFF2A2A2A),
      body: Column(
        children: [
          VerticalScrollList(
            boxWidth: MediaQuery.of(context).size.width * 0.45,
            boxHeight: MediaQuery.of(context).size.height * 0.26,
            items: movies,
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}