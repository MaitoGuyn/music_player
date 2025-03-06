import 'package:flutter/material.dart';
import 'package:music_player/TrackListPage.dart';
import 'package:music_player/auth.dart';
import 'package:music_player/database/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController RepeatpassController = TextEditingController();
  AuthServise authServise = AuthServise();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
            Text("Регистрация",textScaler: TextScaler.linear(3),),
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

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                
                controller: RepeatpassController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.white),
                  labelText: 'RepeatPassword',
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
              child: ElevatedButton(onPressed: ()async{
                //Navigator.push(context,MaterialPageRoute(builder: (context) => TrackListPage()));
                if(emailController.text.isEmpty || passController.text.isEmpty || RepeatpassController.text.isEmpty){
                 print("Поля пустые!");
                }
                else{
                  
                   if(passController.text == RepeatpassController.text){
                      var user = await authServise.signUp(emailController.text, passController.text);
                      if(user!= null){
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);
                        Navigator.popAndPushNamed(context, '/');
                        print("Пользователь создан!");
                      }else{
                        print("Пользователь не создан!");
                      }
                  }else{
                    print("Пароли не совпадают");
                  }
                }
              }, child: Text("Создать аккаунт",
                style: TextStyle(color: Colors.black)
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: OutlinedButton(onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => AuthPage()));
              }, child: Text("Войти",
              style: TextStyle(color: Colors.white)),),
            )

          ],
          
        ),

        
        
      ),
    );
  }
}