import 'package:flutter/material.dart';
import 'package:music_player/auth.dart';
import 'package:music_player/reg.dart';

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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            foregroundColor:  WidgetStatePropertyAll(Colors.blueGrey),
          )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor:  WidgetStatePropertyAll(Colors.white),
            side: WidgetStatePropertyAll(
              BorderSide(color: Colors.white)
            )
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white)
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RegPage(),
      },
    );
  }
}
