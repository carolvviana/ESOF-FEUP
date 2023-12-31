import 'package:cinetalks/database_service/app_database.dart';
import 'package:cinetalks/screens/see_all_pages.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/bottom_navbar.dart';
import '../widgets/horizontal_scroll_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AppDatabase database = AppDatabase();

  List<Map<String, dynamic>> favorites = [];
  List<Map<String, dynamic>> watchlist = [];
  String username = '';

  @override
  void initState() {
    super.initState();
    database
        .getFavorites(FirebaseAuth.instance.currentUser!.uid)
        .then((value) => setState(() => favorites = value));
    database
        .getWatchlist(FirebaseAuth.instance.currentUser!.uid)
        .then((value) => setState(() => watchlist = value));
    database
        .getUsername(FirebaseAuth.instance.currentUser!.uid)
        .then((value) => setState(() => username = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('ProfilePage'),
      backgroundColor: const Color(0xff2a2a2a),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
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
                      IconButton(
                        key: const Key("LogoutButton"),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                // padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.27,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 66, 66, 66),
                        radius: 58.0,
                        backgroundImage:
                            AssetImage("assets/images/629576-200.png"),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
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
                      Row(
                        children: [
                          const Icon(Icons.check_rounded,
                              color: Colors.green, size: 28.0),
                          const SizedBox(
                            width: 8.0,
                          ),
                          const Text(
                            "Your Watched List",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          if (ModalRoute.of(context)!.settings.name !=
                              '/see_all_page') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeeAllPage(
                                    items: favorites,
                                    pageTitle: 'Your Favorites'),
                                settings:
                                    const RouteSettings(name: '/see_all_page'),
                              ),
                            );
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
              HorizontalScrollList(
                boxWidth: MediaQuery.of(context).size.width * 0.28,
                boxHeight: MediaQuery.of(context).size.height * 0.19,
                items: favorites,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: SizedBox(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 26,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          const Text(
                            "Your To-Watch List",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          if (ModalRoute.of(context)!.settings.name !=
                              '/see_all_page') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeeAllPage(
                                    items: watchlist,
                                    pageTitle: 'Your Watch List'),
                                settings:
                                    const RouteSettings(name: '/see_all_page'),
                              ),
                            );
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
              HorizontalScrollList(
                boxWidth: MediaQuery.of(context).size.width * 0.596,
                boxHeight: MediaQuery.of(context).size.height * 0.19,
                items: watchlist,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
