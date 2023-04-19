import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';
import 'signup_widget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _emailError = null;
  String? _passwordError = null;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.015,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: TextField(
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
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.015,
                // ),
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
                      // onPressed: () => navigatorKey.currentState!.push(
                      //   MaterialPageRoute(
                      //     builder: (context) => SignUpWidget(),
                      //   ),
                      // ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpWidget(),
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
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
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
