import 'package:flutter/material.dart';
import 'package:music_player/Home.dart';
import 'package:music_player/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
 bool _isLoggedIn = false;
  Future<void> _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  void initState() {
    _checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? const HomePage() : const AuthPage();
  }
}