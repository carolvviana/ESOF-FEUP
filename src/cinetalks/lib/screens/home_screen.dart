import 'dart:ui';

import 'package:flutter/material.dart';
import '../api/api_services.dart';
import '../movie_app_icons_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie_model.dart';
import 'movie_show_screen.dart';
import '../widgets/horizontal_scroll_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database_service/app_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _backgroundImagePath = "";
  // List<Movie> movies = Movie.movies;
  late PageController _pageController;
  final user = FirebaseAuth.instance.currentUser!;
  final AppDatabase _databaseService = AppDatabase();

  // final databaseReference = FirebaseDatabase.instance.ref();
  String _name = '';

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: 0.8,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2a2a2a),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   titleSpacing: 16.0,
      //   toolbarHeight: 54.0,
      //   title: _titleBar(),
      // ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ..._buildBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _titleBar(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: FutureBuilder(
                  future: fetchInTheaters(),
                  builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
                    if (snapshot.hasData) {
                      _backgroundImagePath = snapshot.data![0].imagePath;
                      return _carouselSlider(snapshot.data!);
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
                future: fetchTopMovies(),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    return HorizontalScrollList(
                      boxWidth: MediaQuery.of(context).size.width * 0.28,
                      boxHeight: MediaQuery.of(context).size.height * 0.19,
                      items: snapshot.data!,
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
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      height: 55.0,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(60, 255, 255, 255),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              MovieAppIcons.home,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              MovieAppIcons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              MovieAppIcons.user,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Row _titleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const Padding(padding: EdgeInsets.all(2.0)),
            GestureDetector(
              onTap: () {
                /* TODO go to profile page */
              },
              child: FutureBuilder(
                future: _databaseService.getUsername(user.uid),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () =>
              /*log out */
              FirebaseAuth.instance.signOut(),
          child: const CircleAvatar(
            radius: 18.0,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 17.0,
              backgroundImage: AssetImage("assets/images/profile_pic.jpg"),
            ),
          ),
        ),
      ],
    );
  }

  /* Animates when _currentIndex changes */
  // List<Widget> _buildBackground() {
  //   return <Widget>[
  //     AnimatedSwitcher(
  //       duration: const Duration(milliseconds: 300),
  //       child: Container(
  //         key: ValueKey<int>(_currentIndex),
  //         width: MediaQuery.of(context).size.width,
  //         height: MediaQuery.of(context).size.height * 0.65,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image:
  //                 CachedNetworkImageProvider(movies[_currentIndex].imagePath),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         child: BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
  //           child: Container(
  //             color: const Color(0xff2a2a2a).withOpacity(0.2),
  //           ),
  //         ),
  //       ),
  //     ),
  //     const Positioned.fill(
  //       child: DecoratedBox(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //               colors: [
  //                 Colors.transparent,
  //                 Color(0xff2a2a2a),
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //               stops: [0.2, 0.65]),
  //         ),
  //       ),
  //     ),
  //   ];
  // }

  Widget _carouselSlider(List<Movie> data) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        clipBehavior: Clip.none,
        enlargeCenterPage: true,
        height: 190,
        enableInfiniteScroll: true,
        viewportFraction: 0.92,
        enlargeFactor: 0.18,
        onPageChanged: (index, reason) {
          setState(() {
            _backgroundImagePath = data[index].imagePath;
          });
        },
      ),
      itemCount: data.length,
      itemBuilder: (context, index, realIndex) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieShowScreen(id: data[index].id),
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
                    image: CachedNetworkImageProvider(data[index].imagePath),
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
                                data[index].title,
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
                                '${data[index].year} • ${data[index].duration.inHours}h ${data[index].duration.inMinutes.remainder(60)}m • ${data[index].category}',
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
                                    data[index].imdbRating.toString(),
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
                      imageUrl: data[index].imagePath,
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
