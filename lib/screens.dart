import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        child: Center(
          child: Text(
            "This is Home Screen",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        child: Center(
          child: Text(
            "This is Settings Screen",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
