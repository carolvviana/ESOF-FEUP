import 'package:cinetalks/screens/profile_screen.dart';
import 'package:cinetalks/screens/search_screen.dart';
import 'package:flutter/material.dart';

import '../movie_app_icons_icons.dart';
import '../screens/home_screen.dart';

class bottomNavigationBar extends StatelessWidget {
  const bottomNavigationBar({super.key});

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
              /* push only if not already in page */
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
              );

              // print(ModalRoute.of(context)?.settings.name);
            },
            icon: const Icon(
              MovieAppIcons.home,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              /* push only if not already in page */
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchPage(),
                ),
              );
            },
            icon: const Icon(
              MovieAppIcons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              /* push only if not already in page */
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
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
