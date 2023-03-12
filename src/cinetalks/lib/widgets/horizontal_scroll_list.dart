import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../models/movie_model.dart';
import '../screens/movie_show_screen.dart';

const List<Movie> movies = Movie.movies;

class HorizontalScrollList extends StatelessWidget {
  final double boxWidth;
  final double boxHeight;

  const HorizontalScrollList(
      {Key? key, required this.boxWidth, required this.boxHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: movies.map((movie) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieShowScreen(movie: movie),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image(
                        image: CachedNetworkImageProvider(movie.imagePath),
                        fit: BoxFit.cover,
                        width: boxWidth,
                        height: boxHeight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: boxWidth,
                      child: Text(
                        overflow: TextOverflow.fade,
                        textWidthBasis: TextWidthBasis.parent,
                        movie.name,
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
