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
    {'name': 'Трэк 1'},
    {'name': 'Трэк 2'},
    {'name': 'Трэк 3'},
    {'name': 'Трэк 4'},
    {'name': 'Трэк 5'},
  ];
   
    @override
    Widget build(BuildContext context){
      return  Scaffold(
      body: Center(
        child: Column(
            children: [
               SizedBox(
                width: 250,
                height: 250,
                child: Container(
                  decoration:  BoxDecoration(
                  color: Colors.white ,
                  borderRadius:  BorderRadius.circular(10),
                  border: Border.all(color: Colors.black , width: 2)
                   ),
                ) 
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

               SizedBox(height: 10),
              ListView.builder(
                itemCount: tracks.length,
                itemBuilder: (BuildContext context, int index){
                  final track = tracks[index];
                  return Container(
                    width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                  );
                }
              ),

            ],
        )
        
      ),
      );
    }
}