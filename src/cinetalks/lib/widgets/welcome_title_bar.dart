import 'package:flutter/material.dart';

import '../database_service/app_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/profile_screen.dart';

final AppDatabase _databaseService = AppDatabase();

class WelcomeTitleBar extends StatelessWidget {
  const WelcomeTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
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
            FutureBuilder(
              future: _databaseService
                  .getUsername(FirebaseAuth.instance.currentUser!.uid),
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
          ],
        ),
        GestureDetector(
          key: const Key("ProfileButton"),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ),
          ),
          child: const CircleAvatar(
            radius: 18.0,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 66, 66, 66),
              radius: 17.0,
              backgroundImage: AssetImage("assets/images/629576-200.png"),
            ),
          ),
        ),
      ],
    );
  }
}
