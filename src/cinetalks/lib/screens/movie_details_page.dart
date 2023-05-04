import 'package:cinetalks/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: const Color(0xFF2A2A2A),
      ),
      body: Container(
        color: const Color(0xFF2A2A2A),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(movie.imagePath),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${movie.year} | ${movie.category} | ${movie.duration.inMinutes} min',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      movie.plot,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'IMDb Rating: ${movie.imdbRating}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}