import 'dart:ui';

import 'package:cinetalks/api/api_services.dart';
import 'package:cinetalks/models/movie_model.dart';
import 'package:cinetalks/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BuildMovieImageBackground extends StatefulWidget {
  final Movie movie;

  BuildMovieImageBackground({Key? key, required this.movie}) : super(key: key);

  @override
  State<BuildMovieImageBackground> createState() =>
      _BuildMovieImageBackgroundState();
}

class _BuildMovieImageBackgroundState extends State<BuildMovieImageBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(widget.movie.imagePath),
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
}

class BuildMovieImage extends StatefulWidget {
  final Movie movie;

  const BuildMovieImage({Key? key, required this.movie}) : super(key: key);

  @override
  State<BuildMovieImage> createState() => _BuildMovieImageState();
}

class _BuildMovieImageState extends State<BuildMovieImage> {
  late Future<String> _trailerUrlFuture;
  String _trailerUrl = "";

  @override
  void initState() {
    super.initState();
    _trailerUrlFuture = fetchYoutubeTrailer(widget.movie.id);
    _trailerUrlFuture.then((value) => setState(() => _trailerUrl = value));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (_trailerUrl != "") {
              if (ModalRoute.of(context)?.settings.name != "/trailer") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(
                      videoUrl: _trailerUrl,
                    ),
                    settings: RouteSettings(name: "/trailer"),
                  ),
                );
              }
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.movie.imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  child: IconButton(
                    key: const Key("BackButton"),
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
                if (_trailerUrl != "")
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 100,
                        ),
                        /* play trailer */
                        Text(
                          "Play Trailer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
