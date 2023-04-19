import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../lib/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() async {
  // This line enables the extension
  enableFlutterDriverExtension();

  await Firebase.initializeApp();

  //logout if already logged in
  await FirebaseAuth.instance.signOut();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  runApp(MyApp());
}