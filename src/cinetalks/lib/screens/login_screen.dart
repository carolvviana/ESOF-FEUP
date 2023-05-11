import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cinetalks/database_service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError = null;
  String? _passwordError = null;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        key: const Key("LoginPage"),
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
                    key: const Key("emailField"),
                    expands: false,
                    controller: _emailController,
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
                    onChanged: (_) {
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
                    controller: _passwordController,
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
                    onChanged: (_) {
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
                      key: const Key("Login"),
                      onPressed: signIn,
                      child: Text(
                        "Login",
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
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                /* Sign up button on the right side */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    ElevatedButton(
                      key: const Key("SignUp"),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                          settings: RouteSettings(name: "/signup")
                        ),
                      ),
                      child: Text(
                        "Sign up",
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
      );

  Future<void> signIn() async {
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = "Email cannot be empty";
      });
      return;
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = "Password cannot be empty";
      });
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //Display error message under email field
        setState(() {
          _emailError = "No user found for this email";
        });
      } else if (e.code == 'wrong-password') {
        //Display error message under password field
        setState(() {
          _passwordError = "Wrong password provided for this user";
        });
      } else if (e.code == 'invalid-email') {
        //Display error message under email field
        setState(() {
          _emailError = "Invalid email";
        });
      } else if (e.code == 'user-disabled') {
        //Display error message under email field
        setState(() {
          _emailError = "This user is disabled";
        });
      } else {
        //Display error message under email field
        setState(() {
          _emailError = "Please check your inputs";
        });
      }
    }
  }
}
