import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

import '../database_service/app_database.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  final AppDatabase _databaseService = AppDatabase();

  String? _emailError = null;
  String? _passwordError = null;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: const Key("CreateAccountPage"),
        backgroundColor: const Color(0xff2a2a2a),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Image(
                    image: AssetImage("assets/images/Logo.png"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: TextField(
                      key: const Key("usernameField"),
                      controller: usernameController,
                      cursorColor: Colors.white.withOpacity(0.5),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: TextField(
                      key: const Key("emailField"),
                      expands: false,
                      controller: emailController,
                      cursorColor: Colors.white.withOpacity(0.5),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        errorText: _emailError,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        errorStyle: TextStyle(height: 0.8),
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _emailError = null;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: TextField(
                      key: const Key("passwordRegisterField"),
                      expands: false,
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      cursorColor: Colors.white.withOpacity(0.5),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        errorText: _passwordError,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        errorStyle: TextStyle(height: 0.8),
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _passwordError = null;
                        });
                      },
                    ),
                  ),

                  /* Login button on the right side */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        key: const Key("SignUpButton"),
                        onPressed: signUp,
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: Size(100, 40),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  /* Sign up button on the right side */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      ElevatedButton(
                        // onPressed: () => navigatorKey.currentState!
                        //     .popUntil((route) => route.isFirst),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          minimumSize: Size(120, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          _emailError = 'The account already exists for that email.';
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          _emailError = 'The email is invalid.';
        });
      } else if (e.code == 'operation-not-allowed') {
        setState(() {
          _emailError = 'Email/password accounts are not enabled.';
        });
      } else if (e.code == 'weak-password') {
        setState(() {
          _passwordError = 'The password is too weak.';
        });
      }
    }
  }
}
