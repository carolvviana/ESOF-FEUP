import 'dart:ui';

import 'package:cinetalks/api/api_services.dart';
import 'package:cinetalks/widgets/movie_aspect_widgets.dart';
import 'package:cinetalks/widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../database_service/app_database.dart';
import 'package:readmore/readmore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FocusNode commentFocusNode = FocusNode();
bool isReply = false;
late Comment currentComment;

class MovieShowScreen extends StatefulWidget {
  final String id;

  MovieShowScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieShowScreen> createState() => _MovieShowScreenState();
}

class _MovieShowScreenState extends State<MovieShowScreen> {
  final AppDatabase _databaseService = AppDatabase();
  TextEditingController _commentController = TextEditingController();
  String? _commentError = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: Key(widget.id),
      future: fetchDetails(widget.id),
      builder: (context, AsyncSnapshot<Movie> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: const Color(0xff2a2a2a),
            body: Stack(
              children: [
                BuildMovieImageBackground(movie: snapshot.data as Movie),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: BuildMovieImage(movie: snapshot.data as Movie),
                ),
                _DraggableScrollableSheet(movie: snapshot.data as Movie),
                Positioned(
                  bottom: 0,
                  child: _bottomCommentBar(context),
                ),
              ],
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: const Color(0xff2a2a2a),
          ));
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
          focusNode: commentFocusNode,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          controller: _commentController,
          onSubmitted: (_) async {
            if (_commentController.text.isNotEmpty) {
              if (!isReply) {
                String username = await _databaseService
                    .getUsername(FirebaseAuth.instance.currentUser!.uid);
                _databaseService.writeNewComment(
                    widget.id,
                    Comment(username, _commentController.text),
                    FirebaseAuth.instance.currentUser!.uid);
              } else {
                _databaseService.replyToComment(
                    widget.id,
                    currentComment,
                    Reply(FirebaseAuth.instance.currentUser!.uid,
                        _commentController.text));

                setState(() {
                  isReply = false;
                });
              }
            } else {
              setState(() {
                _commentError = isReply
                    ? 'Reply cannot be empty'
                    : 'Comment cannot be empty';
              });
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  _commentError = null;
                  isReply = false;
                });
              });
            }

            FocusScope.of(context).unfocus();
            _commentController.clear();
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () async {
                if (_commentController.text.isNotEmpty) {
                  if (!isReply) {
                    String username = await _databaseService
                        .getUsername(FirebaseAuth.instance.currentUser!.uid);
                    _databaseService.writeNewComment(
                        widget.id,
                        Comment(username, _commentController.text),
                        FirebaseAuth.instance.currentUser!.uid);
                  } else {
                    _databaseService.replyToComment(
                        widget.id,
                        currentComment,
                        Reply(FirebaseAuth.instance.currentUser!.uid,
                            _commentController.text));

                    setState(() {
                      isReply = false;
                    });
                  }
                } else {
                  setState(() {
                    _commentError = isReply
                        ? 'Reply cannot be empty'
                        : 'Comment cannot be empty';
                  });
                  Future.delayed(Duration(seconds: 3), () {
                    setState(() {
                      _commentError = null;
                      isReply = false;
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
            hintText: isReply ? 'Add a reply...' : 'Add a comment...',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
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
            errorText: _commentError,
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
          onChanged: (_) {
            setState(() {
              _commentError = null;
            });
          },
        ),
      ),
    );
  }
}

class _DraggableScrollableSheet extends StatefulWidget {
  final Movie movie;

  const _DraggableScrollableSheet({Key? key, required this.movie})
      : super(key: key);

  @override
  State<_DraggableScrollableSheet> createState() =>
      __DraggableScrollableSheetState();
}

class __DraggableScrollableSheetState extends State<_DraggableScrollableSheet> {
  final AppDatabase _databaseService = AppDatabase();
  late Future<bool> _isFavoriteFuture;
  late Future<bool> _isInWatchListFuture;
  bool _isFavorite = false;
  bool _isInWatchList = false;

  @override
  void initState() {
    super.initState();
    _isFavoriteFuture = _databaseService.isFavorite(
      FirebaseAuth.instance.currentUser!.uid,
      widget.movie.id,
    );
    _isInWatchListFuture = _databaseService.isInWatchlist(
      FirebaseAuth.instance.currentUser!.uid,
      widget.movie.id,
    );
    _isFavoriteFuture.then((value) => setState(() => _isFavorite = value));
    _isInWatchListFuture
        .then((value) => setState(() => _isInWatchList = value));
  }

  @override
  Widget build(BuildContext context) {
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              widget.movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          /* TODO: buttons are placeholder for now */
                          SizedBox(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _isFavorite
                                        ? _databaseService.removeFromFavorites(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            widget.movie.id)
                                        : _databaseService.addToFavorites(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            widget.movie.id,
                                            widget.movie.title,
                                            widget.movie.imagePath);
                                    setState(() {
                                      _isFavorite = !_isFavorite;
                                    });
                                  },
                                  child: _isFavorite
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 28,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _isInWatchList
                                        ? _databaseService.removeFromWatchlist(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            widget.movie.id)
                                        : _databaseService.addToWatchlist(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            widget.movie.id,
                                            widget.movie.title,
                                            widget.movie.imagePath);
                                    setState(() {
                                      _isInWatchList = !_isInWatchList;
                                    });
                                  },
                                  child: _isInWatchList
                                      ? const Icon(
                                          Icons.bookmark,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                      : const Icon(
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Text(
                              widget.movie.duration == Duration(minutes: 0)
                                  ? '${widget.movie.category} • ${widget.movie.year}'
                                  : '${widget.movie.duration.inHours}h ${widget.movie.duration.inMinutes.remainder(60)} • ${widget.movie.category} • ${widget.movie.year}',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
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
                                    widget.movie.imdbRating,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Popularity",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.movie.ranking,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "My rating",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  RatingWidget(
                                      id: widget.movie.id,
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid),

                                  // rating == 0 ?
                                  //   const Text(
                                  //     "?",
                                  //     style: TextStyle(
                                  //     color: Colors.white,
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ):

                                  //   Text(
                                  //     rating.toString(),
                                  //     style: TextStyle(
                                  //     color: Colors.white,
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),

                                  //   Text(
                                  //     "/5",
                                  //     style: TextStyle(
                                  //     color: Colors.grey.shade400,
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                /* plot */
                Padding(
                  padding:
                      const EdgeInsets.only(top: 14.0, left: 18, right: 18),
                  child: ReadMoreText(
                    widget.movie.plot,
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
      padding: const EdgeInsets.only(bottom: 72.0),
      child: FutureBuilder<List<Comment>>(
        key: Key(widget.movie.id),
        future: _databaseService.getComments(widget.movie.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Comment> comments = snapshot.data!;

          if (comments.length > 0) {
            return Column(
              children: [
                for (Comment comment in comments)
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    padding: EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.95,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.username,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    comment.text,
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: IconButton(
                                onPressed: () {
                                  //open the keyboard to start typing on the comment box
                                  FocusScope.of(context)
                                      .requestFocus(commentFocusNode);
                                  setState(() {
                                    isReply = true;
                                    currentComment = comment;
                                  });
                                },
                                icon: Icon(
                                  Icons.reply,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (Reply reply in comment.replies)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  color: Colors.white.withOpacity(0.5),
                                  size: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.765,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reply.username,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        reply.text,
                                        style: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            );
          } else {
            return Center(
              child: Text(
                "No comments yet",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        },
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
