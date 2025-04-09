import 'package:flutter/material.dart';
import 'package:music_player/database/Track.dart';
import 'package:music_player/database/user_table.dart';
import 'package:music_player/player.dart';
class PlaylistPage extends StatefulWidget {
  final int playlistId;
  final String playlistName;

  const PlaylistPage({
    super.key,
    required this.playlistId,
    required this.playlistName,
  });

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final UserTable _UserTable = UserTable();
  Track? _currentTrack;
  
  List<Track> _cachedTracks = [];
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(widget.playlistName),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
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
          Expanded(
            child: FutureBuilder<List<Track>>(
              future: _UserTable
                  .fetchPlaylistTracks(widget.playlistId)
                  .then((tracks) {
                _cachedTracks = tracks;
                return tracks;
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.white));
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Ошибка загрузки', 
                      style: TextStyle(color: Colors.white)
                    ),
                  );
                }

                final tracks = snapshot.data ?? [];
                final filteredTracks = _searchQuery.isEmpty
                    ? tracks
                    : tracks.where((track) => track.title
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()))
                        .toList();

                if (filteredTracks.isEmpty) {
                  return Center(
                    child: Text(
                      _searchQuery.isEmpty ? 'Нет треков' : 'Ничего не найдено',
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredTracks.length,
                  itemBuilder: (context, index) {
                    final track = filteredTracks[index];
                    return Card(
                      color: Colors.white.withOpacity(0.1),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () => _playTrack(track),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12),
                        leading: track.imagePath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  track.imagePath!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey[800],
                                    child: Icon(
                                        Icons.music_note, 
                                        color: Colors.white),
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
                                child: Icon(
                                    Icons.music_note, 
                                    color: Colors.white),
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
                          onPressed: () => _playTrack(track),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
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
}