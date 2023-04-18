import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cinetalks/models/movie_model.dart';
import 'package:cinetalks/screens/home_screen.dart';

Widget createHomeScreen() => ChangeNotifierProvider(create: create)

void main() {
  testWidgets(description, (tester) async {

    await tester.pumpWidget()
  })
}