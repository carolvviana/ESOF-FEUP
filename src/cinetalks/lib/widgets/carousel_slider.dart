import 'dart:ui';

import 'package:cinetalks/screens/movie_show_screen.dart';
import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<Movie> movies;

  CarouselSliderWidget({Key? key, required this.movies}) : super(key: key);

  @override
  State<CarouselSliderWidget> createState() => CarouselSliderState();
}

class CarouselSliderState extends State<CarouselSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        clipBehavior: Clip.none,
        enlargeCenterPage: true,
        height: 190,
        enableInfiniteScroll: true,
        viewportFraction: 0.92,
        enlargeFactor: 0.18,
      ),
      itemCount: widget.movies.length,
      itemBuilder: (context, index, realIndex) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MovieShowScreen(id: widget.movies[index].id),
                  settings: RouteSettings(name: '/movie'),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              /* card blur */
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        widget.movies[index].imagePath),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* movie info */
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SizedBox(
                      width: 160,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /* In Theaters */
                              Container(
                                width: 100,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffd4d0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      /* Circle */
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Icon(
                                          Icons.circle,
                                          color: Colors.red.shade600,
                                          size: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "In Theaters",
                                        style: TextStyle(
                                          color: Colors.red.shade600,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                widget.movies[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${widget.movies[index].year} • ${widget.movies[index].duration.inHours}h ${widget.movies[index].duration.inMinutes.remainder(60)}m • ${widget.movies[index].category}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: false,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'IMDb',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    widget.movies[index].imdbRating.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '/10',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          /* Watch Trailer Button */
                          // GestureDetector(
                          //   child: Container(
                          //     width: 150,
                          //     height: 36,
                          //     decoration: BoxDecoration(
                          //       color: const Color(0xff2594f7),
                          //       borderRadius: BorderRadius.circular(18),
                          //     ),
                          //     child: const Center(
                          //       child: Text(
                          //         "Watch Trailer",
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w900,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          //   onTap: () {/* Play Trailer */},
                          // ),
                        ],
                      ),
                    ),
                  ),
                  /* movie banner */
                  SizedBox(
                    width: 130,
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.movies[index].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
