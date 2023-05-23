import 'package:cinetalks/api/api_services.dart';
import 'package:cinetalks/models/movie_model.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key}) : super(key: key);

  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  List<Movie> results = [];
  final TextEditingController _searchController = TextEditingController();

  void _submitSearch(String query) {
    // Do something with the search query, like update a search result list
    print('Search submitted: $query');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _searchController,
        onSubmitted: _submitSearch,
        onChanged: (value) async {
              if (value.length > 2) {
                List<Movie> queryResults = await searchMedia(value);
                setState(() {results = queryResults;});
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
    );
  }
}
