import 'package:flutter/material.dart';
import 'package:music_player/auth.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.white),
                  labelText: 'Write password',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:BorderSide(color: Colors.white)
                  ),
                  enabledBorder: OutlineInputBorder()
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.white),
                  labelText: 'Write the password a second time',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:BorderSide(color: Colors.white)
                  ),
                  enabledBorder: OutlineInputBorder()
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => AuthPage()));
              }, child: Text("Изменить пароль",
                style: TextStyle(color: Colors.black)
                ),
              ),
            ),

          ],
          
        ),

        
        
      ),
    );
  }
}