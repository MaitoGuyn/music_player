import 'package:flutter/material.dart';
import 'package:music_player/auth.dart';

void main() {
  runApp(const AppTheme());
}

class AppTheme extends StatelessWidget {
  const AppTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthPage(),
      },
    );
  }
}
