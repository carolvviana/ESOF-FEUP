import 'package:flutter/material.dart';
import 'package:cinetalks/models/movie_model.dart';
import 'package:cinetalks/widgets/bottom_navbar.dart';
import 'package:cinetalks/widgets/vertical_scroll_list.dart';

class SeeAllPage extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String pageTitle;

  const SeeAllPage({Key? key, required this.items, required this.pageTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = items
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
        title: Text(pageTitle),
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