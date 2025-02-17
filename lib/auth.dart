import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
            Text("Вход",textScaler: TextScaler.linear(3),),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:BorderSide(color: Colors.white)
                  ),
                  enabledBorder: OutlineInputBorder()
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}