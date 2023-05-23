import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<UserCredential> firebaseSignIn(TextEditingController emailController,
    TextEditingController passwordController) {
  FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
  );

  throw {FirebaseAuthException};
}
