import 'package:flutter/material.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key});

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage>{
    final List<Map<String, String>> alboms = [
    {'name': 'Альбом 1'},
    {'name': 'Альбом 2'},
    {'name': 'Альбом 3'},
    {'name': 'Альбом 4'},
    {'name': 'Альбом 5'},
  ];

  final List<Map<String, String>> tracks = [
    {'name': 'Трек 1'},
    {'name': 'Трек 2'},
    {'name': 'Трек 3'},
    {'name': 'Трек 4'},
    {'name': 'Трек 5'},
  ];
   
    @override
    Widget build(BuildContext context){
      return  Scaffold(
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


        
          Row(
          children: 
          [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
                    child: Padding(padding: EdgeInsets.all(20),
                    child: ElevatedButton(onPressed: () {}, child: const Text('Треки'))),
                    ),
                    Padding(padding: EdgeInsets.all(20),
                    child: ElevatedButton(onPressed: () {}, child: const Text('Плейлисты'))),
                    Padding(padding: EdgeInsets.all(20),
                    child: ElevatedButton(onPressed: () {}, child: const Text('Enabled'))),
                    Padding(padding: EdgeInsets.all(20),
                    child: ElevatedButton(onPressed: () {}, child: const Text('Выйти')))
                  ],
                )
                 
                ),
              
                Align(
                  alignment: Alignment.topLeft,
                  child:  SizedBox(
                  width: 350,
                  height: 350,
                  child: Padding(padding:EdgeInsets.all(40),
                    child: Container(
                    decoration:  BoxDecoration(
                    color: Colors.white ,
                    borderRadius:  BorderRadius.circular(5),
                    border: Border.all(color: Colors.black , width: 2)
                    ),
                  ),
                  )
                )),
              Column(
                children: [
                  Text(
                  'Login',
                  style: TextStyle(   // зеленый цвет текста
                  fontSize: 26),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(   // зеленый цвет текста
                    fontSize: 26),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Любимый исполнитель:',
                    style: TextStyle(   // зеленый цвет текста
                    fontSize: 26),
                  ),
                ]
              )
                
               
          ]
        ),
      

        SizedBox(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: 
            [ 
              
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                   children: [  
                    IconButton(
                    onPressed: () {
                      
                    },
                    icon: Icon(
                    Icons.heart_broken_outlined,
                    color: Colors.white,
                  ),)
                  ]
              )
            ],
          ),
        ),

        
      
          ]
        )
      )
      );
    }
}

