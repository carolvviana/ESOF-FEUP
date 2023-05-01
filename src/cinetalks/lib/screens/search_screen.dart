import 'dart:ui';

import 'package:flutter/material.dart';
import '../api/api_services.dart';
import '../movie_app_icons_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie_model.dart';
import 'movie_show_screen.dart';
import '../widgets/vertical_scroll_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/nav_bar_widget.dart';

import '../database_service/app_database.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Movie> results = [];
  final TextEditingController _searchController = TextEditingController();

  int _currentIndex = 0;
  // List<Movie> movies = Movie.movies;
  late PageController _pageController;
  final user = FirebaseAuth.instance.currentUser!;
  final AppDatabase _databaseService = AppDatabase();

  // final databaseReference = FirebaseDatabase.instance.ref();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff2a2a2a),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            TextField(
              controller: _searchController,
              // onSubmitted: _submitSearch,
              onChanged: (value) async {
                if (value.length > 2) {
                    List<Movie> aux = await searchMedia(value);
                  setState((){
                    results = aux;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            // MySearchBar(),
            // Add the rest of your widgets here
            // FutureBuilder(
            //   future: fetchTop250Movies(),
            //       builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
            //         if (snapshot.hasData) {
            //           return VerticalScrollList(
            //             boxWidth: MediaQuery.of(context).size.width * 0.28,
            //             boxHeight: MediaQuery.of(context).size.height * 0.19,
            //             items: snapshot.data!,
            //           );
            //         } else {
            //           return const Center(child: CircularProgressIndicator());
            //         }
            //       },
            //     ),
            VerticalScrollList(
              boxWidth: MediaQuery.of(context).size.width*0.45,
              boxHeight: MediaQuery.of(context).size.height*0.25,
              items: results,
            )
          ],
        ),
        bottomNavigationBar: MyBottomNavigationBar());
  }
}