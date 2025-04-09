import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/database/Track.dart';
import 'package:music_player/database/user_table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlayerPage extends StatefulWidget {
  String? urlMusic;
  String? urlPhoto;
  String? nameSound;
  String? author;
  PlayerPage({
    super.key,
    this.urlMusic,
    this.urlPhoto,
    this.nameSound,
    this.author,
  });

  static UserTable _userTable = new UserTable();

  static Future<void> playTrack({
  required BuildContext context,
  required Track track,
}) async {
  // Сначала получаем весь плейлист
  final playlist = await _userTable.fetchTracks();
  final initialIndex = playlist.indexWhere((t) => t.id == track.id);
  
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerPage(
          urlMusic: track.audioUrl,
          urlPhoto: track.imageUrl,
          nameSound: track.title,
          author: track.authorName,
        ),
      ),
    );
  }

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  String? _urlMusic;
  String? _urlPhoto;
  String? _nameSound;
  String? _author;
  bool isPlaying = false;
  late final AudioPlayer audioPlayer;
  late final UrlSource urlSource;
  Duration _duration = Duration();
  Duration _position = Duration();

  UserTable _userTable = new UserTable();
  late List<Track> _playlist;
  late int _currentTrackIndex;

  Future initPlayer() async {
    audioPlayer = AudioPlayer();
  
    /// Сюда с констуктора необходимо закинуть ссылку
    urlSource = UrlSource(_urlMusic!);

    // Чтобы следить за временем
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    /// Позиция песни
    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
    // Чтобы завершалась
    audioPlayer.onPlayerComplete.listen((comleted) {
      setState(() {
        _position = _duration;
        // isPlaying = !isPlaying;
      });
    });
  }


  void _initPlaylist(List<Track> playlist, int initialIndex) {
  setState(() {
    _playlist = playlist;
    _currentTrackIndex = initialIndex;
  });
}


  // Для проигрывания и паузы
  void playPause() async {
    if (isPlaying) {
      audioPlayer.pause();
      isPlaying = false;
    } else {
      audioPlayer.play(urlSource);
      isPlaying = true;
    }
    setState(() {});
  }

  
Future<void> _nextTrack() async {
  if (_playlist.isEmpty) return;
  
  final newIndex = (_currentTrackIndex + 1) % _playlist.length;
  await _switchTrack(newIndex);
}

// Метод для переключения на предыдущий трек
Future<void> _previousTrack() async {
  if (_playlist.isEmpty) return;
  
  // Если прошло больше 3 секунд - в начало текущего трека
  if (_position.inSeconds > 3) {
    await audioPlayer.seek(Duration.zero);
    return;
  }
  
  final newIndex = (_currentTrackIndex - 1) % _playlist.length;
  await _switchTrack(newIndex);
}


Future<void> _switchTrack(int newIndex) async {
  if (newIndex < 0 || newIndex >= _playlist.length) return;
  
  setState(() {
    _currentTrackIndex = newIndex;
    final track = _playlist[newIndex];
    _urlMusic = track.audioUrl;
    _urlPhoto = track.imageUrl;
    _nameSound = track.title;
    _author = track.authorName;
    isPlaying = true;
  });
  
  try {
    await audioPlayer.stop();
    await audioPlayer.play(UrlSource(_urlMusic!));
  } catch (e) {
    print('Ошибка переключения трека: $e');
    setState(() => isPlaying = false);
  }
}


void _updateCurrentTrack() {
  final track = _playlist[_currentTrackIndex];
  _urlMusic = track.audioUrl;
  _urlPhoto = track.imageUrl;
  _nameSound = track.title;
  _author = track.authorName;
}

Future<void> _loadPlaylist() async {
  try {
    _playlist = await _userTable.fetchTracks(); // Ваш метод
    if (_playlist.isEmpty) {
      print('Плейлист пуст');
    }
  } catch (e) {
    print('Ошибка загрузки плейлиста: $e');
    _playlist = [];
  }
}

  // Инициализация
  @override
  void initState() {
    _urlPhoto = widget.urlPhoto;
    _urlMusic = widget.urlMusic;
    _author = widget.author;
    _nameSound = widget.nameSound;

    _loadPlaylist().then((_) {
    // Находим индекс текущего трека в плейлисте
    if (_playlist.isNotEmpty) {
      _currentTrackIndex = _playlist.indexWhere(
        (t) => t.audioUrl == _urlMusic
      ).clamp(0, _playlist.length - 1);
    }
    
    // Инициализируем плеер после загрузки плейлиста
    initPlayer();
    });
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

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
            ClipRRect(
              borderRadius: BorderRadius.circular(20),

              /// Cюда с констуктора закинуть ссылку на картинку
              child: Image.network(
                _urlPhoto!,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            // Должно браться с бд
            ListTile(
              textColor: Colors.white,
              title: Text(
                _nameSound!,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _author!,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Slider(
              min: 0,
              max: _duration.inSeconds.toDouble(),
              activeColor: Colors.blue,
              inactiveColor: Colors.white,
              value: _position.inSeconds.toDouble(),
              onChanged: (value) async {
                await audioPlayer.seek(Duration(seconds: value.toInt()));
                setState(() {});
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _position.format(_position),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(" / ", style: TextStyle(color: Colors.white)),
                Text(
                  _duration.format(_duration),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Назад
                 IconButton(
                    icon: Icon(Icons.skip_previous, size: 40),
                    color: Colors.white,
                    onPressed: _previousTrack,
                  ),
                // Проигрывать
                IconButton(
                  color: Colors.white,
                  onPressed: playPause,
                  icon:
                      isPlaying
                          ? Icon(Icons.pause_circle, size: 60)
                          : Icon(Icons.play_circle, size: 60),
                ),
                // Дальше
                IconButton(
                  icon: Icon(Icons.skip_next, size: 40),
                  color: Colors.white,
                  onPressed: _nextTrack,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Форматирование времени при воспроизведении плеера
extension on Duration {
  String format(Duration duration) {
    String minutes = duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String seconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
