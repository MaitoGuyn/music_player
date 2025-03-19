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
                    ElevatedButton(onPressed: () {}, child: const Text('Tracks')),
                    ElevatedButton(onPressed: () {}, child: const Text('Enabled')),
                    ElevatedButton(onPressed: () {}, child: const Text('Enabled')),
                    ElevatedButton(onPressed: () {}, child: const Text('Enabled')),
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
    
                Text(
                'Author',
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

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        SizedBox(
          height: 130,  
          child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: alboms.length,
                  itemBuilder: (context, index) {
                    final artist = alboms[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AuthorPage()));
                              },
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                  ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            artist['name']!,
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              SizedBox(
                height: 500,
                
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: alboms.length,
                  itemBuilder: (context, index) {
                    final artist = tracks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AuthorPage()));
                              },
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                  ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            artist['name']!,
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      
          ]
        )
      )
      );
    }
}

