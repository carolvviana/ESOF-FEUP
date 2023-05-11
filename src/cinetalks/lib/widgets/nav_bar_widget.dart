import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinetalks/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../models/movie_model.dart';
import '../screens/movie_show_screen.dart';
import '../movie_app_icons_icons.dart';
import '../screens/search_screen.dart';
import '../screens/home_screen.dart';

    void _searchPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }
    void _homePage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              _homePage(context );
            },
            icon: const Icon(
              MovieAppIcons.home,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              _searchPage(context);
            },
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
}