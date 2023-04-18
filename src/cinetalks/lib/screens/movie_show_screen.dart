import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinetalks/api/api_services.dart';
import 'package:cinetalks/database_service/app_database.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../models/movie_model.dart';
// import '../widgets/video_player.dart';
// import '../movie_app_icons_icons.dart';
import 'package:readmore/readmore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MovieShowScreen extends StatefulWidget {
  final String id;

  String? _commentError = null;

  MovieShowScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieShowScreen> createState() => _MovieShowScreenState();
}

class _MovieShowScreenState extends State<MovieShowScreen> {
  final AppDatabase _databaseService = AppDatabase();
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: Key(widget.id),
      future: fetchMovieTvShowDetails(widget.id),
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
    return Container(
      width: MediaQuery.of(context).size.width,
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
        child: TextField(
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 16,
          ),
          controller: _commentController,
          onSubmitted: (_) {
            if (_commentController.text.isNotEmpty) {
              _databaseService.writeNewComment(
                  FirebaseAuth.instance.currentUser!.uid,
                  widget.id,
                  _commentController.text);
            } else {
              setState(() {
                widget._commentError = 'Comment cannot be empty';
              });
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  widget._commentError = null;
                });
              });
            }
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  _databaseService.writeNewComment(
                      FirebaseAuth.instance.currentUser!.uid,
                      widget.id,
                      _commentController.text);
                } else {
                  setState(() {
                    widget._commentError = 'Comment cannot be empty';
                  });
                  Future.delayed(Duration(seconds: 3), () {
                    setState(() {
                      widget._commentError = null;
                    });
                  });
                }

                FocusScope.of(context).unfocus();
                _commentController.clear();
              },
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 24,
              ),
            ),
            fillColor: Colors.white.withOpacity(0.2),
            filled: true,
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            errorText: widget._commentError,
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
          onChanged: (value) {
            setState(() {
              widget._commentError = null;
            });
          },
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
                          // SizedBox(
                          //   child: Row(
                          //     children: [
                          //       GestureDetector(
                          //         onTap: () {
                          //           /* add to favorite */
                          //         },
                          //         child: const Icon(
                          //           Icons.favorite_border,
                          //           color: Colors.white,
                          //           size: 28,
                          //         ),
                          //       ),
                          //       GestureDetector(
                          //         onTap: () {
                          //           /* add to watchlist */
                          //         },
                          //         child: const Icon(
                          //           Icons.bookmark_border,
                          //           color: Colors.white,
                          //           size: 30,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
                            movie.duration == Duration(minutes: 0)
                                ? '${movie.category} • ${movie.year}'
                                : '${movie.duration.inHours}h ${movie.duration.inMinutes.remainder(60)} • ${movie.category} • ${movie.year}',
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
                  child: _buildCommentSection(context),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCommentSection(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: FutureBuilder<List<Map<dynamic, dynamic>>>(
          key: Key(widget.id),
          future: _databaseService.getComments(widget.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            print(snapshot.data);

            final comments = snapshot.data!;

            return Container(
              child: Column(
                children: [
                  for (var comment in comments)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0,
                                  right: 12.0,
                                  top: 4.0,
                                  bottom: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        comment['user'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        comment['comment'],
                                        style: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  //reply button
                                  // IconButton(
                                  //   onPressed: () {},
                                  //   icon: Icon(
                                  //     Icons.reply,
                                  //     color: Colors.white,
                                  //     size: 20,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            );
          },
        ),
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
