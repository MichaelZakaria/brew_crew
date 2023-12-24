import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticat extends StatefulWidget {
  const Authenticat({super.key});

  @override
  State<Authenticat> createState() => _AuthenticatState();
}

class _AuthenticatState extends State<Authenticat> {

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIN(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }

  }
}

