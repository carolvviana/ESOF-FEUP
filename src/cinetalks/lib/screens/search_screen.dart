import 'dart:ui';

import 'package:flutter/material.dart';
import '../api/api_services.dart';

import '../models/movie_model.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/vertical_scroll_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        key: const Key('SearchPage'),
        backgroundColor: const Color(0xff2a2a2a),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                child: TextField(
                  key: const Key('SearchBar'),
                  style: TextStyle(color: Colors.white),
                  controller: _searchController,
                  // onSubmitted: _submitSearch,
                  onChanged: (value) async {
                    if (value.length > 2) {
                      List<Movie> aux = await searchMedia(value);
                      setState(() {
                        results = aux;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    // labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIconColor: Colors.white,
                    fillColor: Colors.white.withOpacity(0.2),
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
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
            results.length == 0
                ? Expanded(
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Looks like its empty here",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Start your search by typing in the box above!",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16),
                        )
                      ],
                    ),
                  )
                : VerticalScrollList(
                    boxWidth: MediaQuery.of(context).size.width * 0.45,
                    boxHeight: MediaQuery.of(context).size.height * 0.26,
                    items: results,
                  )
          ],
        ),
        bottomNavigationBar: bottomNavigationBar());
  }
}
