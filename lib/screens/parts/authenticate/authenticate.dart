import 'package:flutter/material.dart';
import 'package:subtwo/screens/parts/authenticate/login.dart';
import 'package:subtwo/screens/parts/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AutheticateState createState() => _AutheticateState();
}

class _AutheticateState extends State<Authenticate> {
  bool showLogin = true;
  void toggleView() {
    setState(() => showLogin = !showLogin);
  }

  @override
  Widget build(BuildContext context) {
    return showLogin == true
        ? Login(toggleView: toggleView)
        : Register(toggleView: toggleView);
  }
}
