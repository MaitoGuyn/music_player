import 'package:cache_audio_player_plus/cache_audio_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/AuthorPage.dart';
import 'package:music_player/players.dart';


class TrackListPage extends StatefulWidget {
  const TrackListPage({super.key});

  @override
  _TrackListPageState createState() => _TrackListPageState();
}

class _TrackListPageState extends State<TrackListPage> {

final List<Map<String, String>> tracks = [
    {'title': 'Трек 1', 'author': 'Автор 1'},
    {'title': 'Трек 2', 'author': 'Автор 2'},
    {'title': 'Трек 3', 'author': 'Автор 3'},
    {'title': 'Трек 4', 'author': 'Автор 4'},
    {'title': 'Трек 5', 'author': 'Автор 5'},
  ];

  final List<Map<String, String>> playlists = [
    {'title': 'Плейлист 1'},
    {'title': 'Плейлист 2'},
    {'title': 'Плейлист 3'},
    {'title': 'Плейлист 4'},
    {'title': 'Плейлист 5'},
    {'title': 'Плейлист 6'},
  ];

  final List<Map<String, String>> artists = [
    {'name': 'Исполнитель 1'},
    {'name': 'Исполнитель 2'},
    {'name': 'Исполнитель 3'},
    {'name': 'Исполнитель 4'},
    {'name': 'Исполнитель 5'},
  ];

  String searchQuery = '';
  int currentTrackIndex = 0;
  bool isPlaying = true;

  List<Map<String, String>> get filteredTracks => tracks
      .where((track) =>
          track['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          track['author']!.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Список треков'),
        backgroundColor: Colors.blueGrey,
        
      ),
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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80), // Отступ для нижнего плеера
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Поиск
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Поиск',
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white54),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) => setState(() => searchQuery = value),
                ),
              ),

              const SizedBox(height: 20),

              // Плейлисты
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Ваши плейлисты',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: playlists.map((playlist) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 50) / 2, // 2 колонки
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.image, color: Colors.white, size: 40),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            playlist['title']!,
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 30),

              // Исполнители
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Исполнители',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: artists.length,
                  itemBuilder: (context, index) {
                    final artist = artists[index];
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

              const SizedBox(height: 30),

              // Список треков
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Треки',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredTracks.length,
                itemBuilder: (context, index) {
                  final track = filteredTracks[index];
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.music_note, color: Colors.white),
                    ),
                    title: Text(
                      track['title']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      track['author']!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    //onTap: () => Navigator.push(
                     // context//,
                     // MaterialPageRoute(builder: (context) => TracksPage()),
                   // ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // Плеер внизу
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.music_note),
          title: Text('----------------------'),
          subtitle:  Text('Название'),
          trailing: IconButton(
            onPressed: () {
                Navigator.push(context, CupertinoPageRoute(
                  builder: (context) => PlayerPage(
                    nameSound: 'Тынларсынмы Яшьлек Хислэремне',
                    author: 'Гио Пика',
                    urlMusic: 'https://avlhfundbxtouuguzldi.supabase.co/storage/v1/object/public/storages//Ilkham_SHakirov_-_Tynlarsynmy_YAshlek_KHisljeremne_71715814.mp3',
                    urlPhoto: 'https://avlhfundbxtouuguzldi.supabase.co/storage/v1/object/public/storages//Ilkham_Shakirov_picture.png',
                  ),
                ));
            },
            icon: Icon(Icons.play_arrow)
          ),
        ),
      ),
      drawer: DrawerPage(),
      
    );
  }
}


