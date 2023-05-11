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
      key: const Key('navbar'),
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
            key: const Key('nav-HomeButton'),
            onPressed: () {
              /* push only if not already in page */
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                  settings: const RouteSettings(name: '/home'),
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
            key: const Key('nav-SearchButton'),
            onPressed: () {
              /* push only if not already in page */
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchPage(),
                  settings: const RouteSettings(name: '/search'),
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
            key: const Key('nav-ProfileButton'),
            onPressed: () {
              /* push only if not already in page */
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                  settings: const RouteSettings(name: '/profile'),
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
