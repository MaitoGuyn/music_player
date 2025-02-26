import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
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
                            child: const Icon(Icons.person, color: Colors.white, size: 40),
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade700,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.music_note, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tracks[currentTrackIndex]['title']!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      tracks[currentTrackIndex]['author']!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () => setState(() => isPlaying = !isPlaying),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.3,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey.shade900,
    );
  }
}


