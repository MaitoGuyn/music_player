import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player/database/auth.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  AuthServise auth = new AuthServise();
  final String user_id = Supabase.instance.client.auth.currentUser!.id.toString();
  dynamic docs;
  getUserById()async{
    final userGet = await Supabase.instance.client.from('users').select().eq('id', user_id).single();

    setState(() {
      docs = userGet;
    });
  }
  @override

  void initState(){
    getUserById();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blueGrey],
          ),
        ),
      child: ListView(
        children: [
            DrawerHeader(child: UserAccountsDrawerHeader(accountName: Text(docs['name'])
            , accountEmail: Text("Email"),//docs['Email_User']),
            currentAccountPicture: Container(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                maxRadius: 20,
                minRadius: 10,
                //backgroundImage: NetworkImage(docs['avatar']),
              ),
            ),
            otherAccountsPictures: [
              IconButton(onPressed: (){}, icon: Icon(Icons.logout))
            ],)),
            ListTile(
              tileColor: Colors.white,
              title: Text("Моя музыка"),
              leading: Icon(Icons.featured_play_list)
            ),
            ListTile(

              title: Text("Плейлисты"),
              leading: Icon(Icons.featured_play_list),
            ),
            
        ],
      ),
    ));
  }
}