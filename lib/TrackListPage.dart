import 'package:cache_audio_player_plus/cache_audio_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/AuthorPage.dart';
import 'package:music_player/database/Author.dart';
import 'package:music_player/database/Track.dart';
import 'package:music_player/database/play_list.dart';
import 'package:music_player/database/user_table.dart';
import 'package:music_player/pages/MiniPlayer.dart';
import 'package:music_player/pages/PagePlaylist.dart';
import 'package:music_player/pages/drawer.dart';
import 'package:music_player/player.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TrackListPage extends StatefulWidget {
  const TrackListPage({super.key});

  @override
  _TrackListPageState createState() => _TrackListPageState();
}

class _TrackListPageState extends State<TrackListPage> {

final UserTable _UserTable = UserTable();
final Supabase _supabase = Supabase.instance;

 Track? _currentTrack;
 
  void _playTrack(Track track) {
    print('Playing track: ${track.title}');
    setState(() {
      _currentTrack = track;
    });

    PlayerPage.playTrack(
      context: context,
      track: track,
    );
  }

  Future<void> createPlaylist(String name) async {
  try {
    final user = _supabase.client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // Получаем максимальный ID
    final maxId = await _supabase.client
        .from('List')
        .select('ID_List')
        .order('ID_List', ascending: false)
        .limit(1)
        .maybeSingle()
        .then((data) => (data?['ID_List'] as int? ?? 10) + 1);

    // Создаем плейлист
    await _supabase.client.from('List').insert({
      'ID_List': maxId,
      'Name_PlayList': name,
      'ID_User': user.id, // Используем ID из auth
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Плейлист создан!')),
      );
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }
}

Future<void> _showAddPlaylistDialog(BuildContext context) async {
  final textController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Новый плейлист'),
      content: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: 'Название плейлиста',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (textController.text.isNotEmpty) {
              await createPlaylist(textController.text);
              Navigator.pop(context);
            }
          },
          child: Text('Создать'),
        ),
      ],
    ),
  );
}

  String searchQuery = '';
  // int currentTrackIndex = 0;
  bool isPlaying = true;
  List<Track>? cachedTracks ;  
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
          padding: const EdgeInsets.only(bottom: 80),
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
FutureBuilder<List<Playlist>>(
  future: _UserTable.fetchPlaylists(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return SizedBox(
        height: 130,
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
    
    if (snapshot.hasError) {
      return SizedBox(
        height: 130,
        child: Center(
          child: Text(
            'Ошибка загрузки',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return SizedBox(
        height: 130,
        child: Center(
          child: Text(
            'Нет плейлистов',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    
    final playlists = snapshot.data!;

    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaylistPage(
                          playlistId: playlist.id,
                          playlistName: playlist.name,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.queue_music,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 70,
                  child: Text(
                    playlist.name,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  },
),
const SizedBox(height: 30),
FloatingActionButton(
  onPressed: () => _showAddPlaylistDialog(context),
  child: Icon(Icons.add),
  backgroundColor: Colors.blue,
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
              FutureBuilder<List<Author>>(
                future: _UserTable.fetchAuthors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 130,
                      child: Center(child: CircularProgressIndicator(color: Colors.white)),
                    );
                  }
                  
                  if (snapshot.hasError) {
                    return SizedBox(
                      height: 130,
                      child: Center(
                        child: Text(
                          'Ошибка загрузки',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: 130,
                      child: Center(
                        child: Text(
                          'Нет исполнителей',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  
                  final authors = snapshot.data!;
              
                  return SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: authors.length,
                      itemBuilder: (context, index) {
                        final author = authors[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Column(
                            children: [
                              
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AuthorPage(),//author: author),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(50),
                                    image: author.imageUrl != null
                                        ? DecorationImage(
                                            image: NetworkImage(author.imageUrl!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: author.imageUrl == null
                                      ? Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Имя исполнителя
                              SizedBox(
                                width: 70,
                                child: Text(
                                  author.name,
                                  style: const TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

          const SizedBox(height: 30),

              // Список треков
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
Expanded( // Добавляем Expanded для занимания всего доступного пространства
  child: FutureBuilder<List<Track>>(
     future: _UserTable.fetchTracks().then((tracks) {
     cachedTracks = tracks; // Сохраняем треки при первой загрузке
     return tracks;
  }),
  builder: (context, snapshot) {
    
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator(color: Colors.white));
    }
    
    if (snapshot.hasError) {
      return Center(child: Text('Ошибка загрузки', style: TextStyle(color: Colors.white)));
    }
    
    final tracks = snapshot.data ?? [];
    
    // Фильтрация прямо здесь
    final filteredTracks = searchQuery.isEmpty
        ? tracks
        : tracks.where((track) => 
            track.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    
    if (filteredTracks.isEmpty) {
      return Center(
        child: Text(
          searchQuery.isEmpty ? 'Нет треков' : 'Ничего не найдено',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
      
      return ListView.builder(
        // Убираем shrinkWrap: true,
        // Убираем physics: const NeverScrollableScrollPhysics(),
        itemCount: filteredTracks.length,
        itemBuilder: (context, index) {
          final track = filteredTracks[index];
          return Card(
            color: Colors.white.withOpacity(0.1),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              onTap: () => _playTrack(track),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              leading: track.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        track.imageUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[800],
                          child: Icon(Icons.music_note, color: Colors.white),
                        ),
                      ),
                    )
                  : Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.music_note, color: Colors.white),
                    ),
              title: Text(
                track.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                track.authorName ?? 'Неизвестный исполнитель',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                            icon: Icon(Icons.play_arrow, color: Colors.white),
                            onPressed: () => _playTrack(track), // Тот же обработчик
                          ),
            ),
          );
        },
      );
    },
  ),
),

          
            ]
            
          )
          
          
          )
          
          ),
          bottomNavigationBar: _currentTrack != null 
            ? MiniPlayer(
                key: ValueKey(_currentTrack!.id),
                initialTrack: _currentTrack,
              )
            : null,
          drawer: DrawerPage(),
          
    );
  }
}


