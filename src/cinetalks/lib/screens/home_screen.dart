import 'dart:ui';

import 'package:cinetalks/screens/all_movies_page.dart';
import 'package:flutter/material.dart';
import '../api/api_services.dart';

import '../models/movie_model.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/carousel_slider.dart';
import '../widgets/welcome_title_bar.dart';

import '../widgets/horizontal_scroll_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2a2a2a),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          //..._buildBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: WelcomeTitleBar(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: FutureBuilder(
                  future: fetchInTheaters(),
                  builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
                    if (snapshot.hasData) {
                      return CarouselSliderWidget(movies: snapshot.data!);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: SizedBox(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Top 250 Movies",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          List<Movie>? movies = await fetchTop250Movies();
                          if (movies != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllMoviesPage(movies: movies),
                              ),
                            );
                          } else {
                            // handle error or show a message to the user
                          }
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(
                            color: Color(0xff2594f7),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: fetchTopMovies(),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    return HorizontalScrollList(
                      boxWidth: MediaQuery.of(context).size.width * 0.28,
                      boxHeight: MediaQuery.of(context).size.height * 0.19,
                      items: snapshot.data!,
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "An error occurred: ${snapshot.error}",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: SizedBox(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Top 250 TV Shows",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: const Text(
                      //     "See All",
                      //     style: TextStyle(
                      //       color: Color(0xff2594f7),
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: fetchTopTVShows(),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    return HorizontalScrollList(
                      boxWidth: MediaQuery.of(context).size.width * 0.596,
                      boxHeight: MediaQuery.of(context).size.height * 0.19,
                      items: snapshot.data!,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
