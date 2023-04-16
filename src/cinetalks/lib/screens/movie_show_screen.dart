import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinetalks/api/api_services.dart';
import 'package:cinetalks/database_service/app_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../widgets/video_player.dart';
import '../movie_app_icons_icons.dart';
import 'package:readmore/readmore.dart';

import '../database_service/app_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MovieShowScreen extends StatelessWidget {
  final String id;
  final AppDatabase _databaseService = AppDatabase();

  MovieShowScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMovieTvShowDetails(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: const Color(0xff2a2a2a),
            body: Stack(
              children: [
                _buildBackground(context, snapshot.data as Movie),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: _buildImageBox(context, snapshot.data as Movie),
                ),
                _buildDraggableScrollableSheet(context, snapshot.data as Movie),
                Positioned(
                  bottom: 0,
                  child: _bottomCommentBar(context),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _bottomCommentBar(BuildContext context) {
    TextEditingController _commentController = TextEditingController();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(60, 255, 255, 255),
            width: 0.5,
          ),
        ),
        color: Color(0xff2a2a2a),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white.withOpacity(0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                ),
                controller: _commentController,
                onSubmitted: (_) {
                  _databaseService.writeComment(
                      FirebaseAuth.instance.currentUser!.uid,
                      id,
                      _commentController.text);
                },
                decoration: InputDecoration(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                  ),
                  border: InputBorder.none,
                  hintText: 'Add a comment...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16,
                  ),
                  contentPadding: const EdgeInsets.only(
                    left: 16,
                    top: 14,
                    bottom: 14,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _databaseService.writeComment(
                      FirebaseAuth.instance.currentUser!.uid,
                      id,
                      _commentController.text);

                  FocusScope.of(context).unfocus();
                  _commentController.clear();
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground(context, movie) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(movie.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          color: const Color(0xff2a2a2a).withOpacity(0.0),
        ),
      ),
    );
  }

  Widget _buildImageBox(context, movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const VideoPlayerScreen(
            //       videoUrl: "https://www.youtube.com/watch?v=Jvurpf91omw",
            //     ),
            //   ),
            // );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: CachedNetworkImageProvider(movie.imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                // Center(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: const [
                //       Icon(
                //         Icons.play_arrow_rounded,
                //         color: Colors.white,
                //         size: 100,
                //       ),
                //       /* play trailer */
                //       Text(
                //         "Play Trailer",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 20,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDraggableScrollableSheet(context, movie) {
    return DraggableScrollableSheet(
      initialChildSize: 0.62,
      maxChildSize: 1,
      minChildSize: 0.62,
      snap: true,
      snapSizes: const [0.62, 1],
      builder: (context, scrollController) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: Color(0xff2a2a2a),
          ),
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.only(top: 18.0),
              children: [
                /* drag bar */
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 24),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          /* TODO: buttons are placeholder for now */
                          SizedBox(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    /* add to favorite */
                                  },
                                  child: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    /* add to watchlist */
                                  },
                                  child: const Icon(
                                    Icons.bookmark_border,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    /* movie info */
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${movie.duration.inHours}h ${movie.duration.inMinutes.remainder(60)} • ${movie.category} • ${movie.year}',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                /*Ratings*/

                Padding(
                  padding:
                      const EdgeInsets.only(top: 14.0, left: 18, right: 18),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withOpacity(0.5),
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.white.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "IMDb",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    movie.imdbRating,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "/10",
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       const Text(
                        //         "Rotten Tomatoes",
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        //       const SizedBox(
                        //         height: 4,
                        //       ),
                        //       Row(
                        //         crossAxisAlignment: CrossAxisAlignment.end,
                        //         children: [
                        //           const Text(
                        //             "85",
                        //             style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //           ),
                        //           Text(
                        //             "%",
                        //             style: TextStyle(
                        //               color: Colors.grey.shade400,
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       const Text(
                        //         "My rating",
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        //       const SizedBox(
                        //         height: 4,
                        //       ),
                        //       Row(
                        //         children: [
                        //           const Text(
                        //             "4.5",
                        //             style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //           ),
                        //           Text(
                        //             "/5",
                        //             style: TextStyle(
                        //               color: Colors.grey.shade400,
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
                /* plot */
                Padding(
                  padding:
                      const EdgeInsets.only(top: 14.0, left: 18, right: 18),
                  child: ReadMoreText(
                    movie.plot,
                    trimLines: 3,
                    colorClickableText: Colors.white,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'More',
                    trimExpandedText: 'Show less',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 14.0, left: 18, right: 18),
                  child: _buildCommentSection(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCommentSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: const Placeholder(
        fallbackHeight: 1500,
      ),
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
