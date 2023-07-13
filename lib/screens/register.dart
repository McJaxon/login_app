import 'package:flutter/material.dart';
import 'package:kuunga_app/screens/login.dart';
import 'package:kuunga_app/screens/signup.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showSignIn = true;
  void alreadyLoggedin() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LogInScreen(switchlogin: alreadyLoggedin);
    } else {
      return SignUpScreen(switchSignUp: alreadyLoggedin);
    }
  }
}
