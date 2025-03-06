import 'package:flutter/material.dart';
import 'package:music_player/auth.dart';
import 'package:music_player/landing.dart';
import 'package:music_player/reg.dart';
import 'package:music_player/RecoveryPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_player/TrackListPage.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Supabase
  await Supabase.initialize(
    url: 'https://avlhfundbxtouuguzldi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF2bGhmdW5kYnh0b3V1Z3V6bGRpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAzODA5MDAsImV4cCI6MjA1NTk1NjkwMH0.MTEnVOd6cZkMtSA6KuWuzLEypwAng_GvTg7Nku1GAYI',
  );

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
        '/': (context) => LandingPage(),
        '/Track': (context) => TrackListPage(),
        '/auth': (context) => AuthPage(),
        '/reg': (context) => RegPage(),
        '/recovery': (context) => RecoveryPage(),
      },
    );
  }
}
