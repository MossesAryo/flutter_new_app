import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final String email;

  HomeScreen({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome, $username!", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Email: $email", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
