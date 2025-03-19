import 'package:flutter/material.dart';
import 'package:music_player/RecoveryPage.dart';
import 'package:music_player/TrackListPage.dart';
import 'package:music_player/database/auth.dart';
import 'package:music_player/reg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AuthServise authServise = AuthServise();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blueGrey],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
            Text("Вход",textScaler: TextScaler.linear(3),),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: emailController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.white),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: passController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.white),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:BorderSide(color: Colors.white)
                  ),
                  enabledBorder: OutlineInputBorder()
                ),
              ),
            ),
            
            Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Text("Забыли пароль?"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RecoveryPage()));
                },
              )
              ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(onPressed: () async{
               // Navigator.push(
                 // context,
                //  MaterialPageRoute(builder: (context) => const TrackListPage()),
                 // );
                if(emailController.text.isEmpty || passController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Поля пустые", style: TextStyle(color: Colors.black)),
                    backgroundColor: Colors.white,),
                  );

                }
                else{
                  var user = await authServise.signIn(emailController.text, passController.text);
                  if(user!= null){
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', true);
                    Navigator.popAndPushNamed(context, '/Track');
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Авторизирован: ${user.email!}", style: TextStyle(color: Colors.black)),
                    backgroundColor: Colors.white,)
                  );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Пользователь не найден", style: TextStyle(color: Colors.black)),
                    backgroundColor: Colors.white,),
                  );
                  }
                }
              },
               child: Text("Войти",
               style: TextStyle(color: Colors.black),
              
              ),),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: OutlinedButton(onPressed: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => RegPage())
                );
              }, child: Text("Создать аккаунт",
                 style: TextStyle(color: Colors.white)
                ),
              ),
            )

          ],
          
        ),

        
        
      ),
    );
  }
}