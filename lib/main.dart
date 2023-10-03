import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart'; // Import your login screen
import 'homePage.dart'; // Import your home page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer to navigate after 3 seconds
    Timer(Duration(seconds: 3), () {
      _checkUserLoggedIn();
    });
  }

  Future<void> _checkUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString("email");

    if (userEmail != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) {
          return HomePage();
        }),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) {
          return LoginWidget();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/logoGeekMessaging.png',
          width: 200,
          height: 200,
          // You can adjust the width and height as needed
        ),
      ),
    );
  }
}
