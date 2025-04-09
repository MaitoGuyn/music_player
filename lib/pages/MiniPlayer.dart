import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_player/database/Track.dart';
import 'package:music_player/player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MiniPlayer extends StatefulWidget {
  final Track? initialTrack;
  
  const MiniPlayer({
    super.key,
    this.initialTrack,
  });

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  Track? currentTrack;
  Duration? _currentPosition;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    currentTrack = widget.initialTrack;
    _setupAudioPlayer();
    _restorePlayerState();
  }

  void _setupAudioPlayer() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() => isPlaying = state == PlayerState.playing);
    });
    
    audioPlayer.onPositionChanged.listen((position) {
      setState(() => _currentPosition = position);
    });
    
    audioPlayer.onPlayerComplete.listen((_) {
      setState(() => isPlaying = false);
    });
  }

  Future<void> _restorePlayerState() async {
    if (currentTrack == null) return;
    
    final prefs = await SharedPreferences.getInstance();
    final savedPosition = prefs.getInt('${currentTrack!.id}_position');
    
    if (savedPosition != null) {
      await audioPlayer.seek(Duration(milliseconds: savedPosition));
    }
  }

  Future<void> _savePlayerState() async {
    if (currentTrack == null) return;
    
    final prefs = await SharedPreferences.getInstance();
    final position = await audioPlayer.getCurrentPosition();
    
    if (position != null) {
      await prefs.setInt('${currentTrack!.id}_position', position.inMilliseconds);
    }
  }

  Future<void> _playPause() async {
    if (currentTrack == null) return;
    
    if (isPlaying) {
      await _savePlayerState();
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(UrlSource(currentTrack!.audioUrl!));
    }
  }

  void updateTrack(Track newTrack) {
    if (currentTrack?.id == newTrack.id) return;
    
    setState(() {
      currentTrack = newTrack;
      isPlaying = false;
    });
    
    _savePlayerState().then((_) {
      audioPlayer.stop().then((_) {
        audioPlayer.play(UrlSource(newTrack.audioUrl!));
        setState(() => isPlaying = true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentTrack == null) return const SizedBox();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border(top: BorderSide(color: Colors.grey[800]!)),
      ),
      child: ListTile(
       leading: currentTrack!.imageUrl != null
    ? ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          currentTrack!.imageUrl!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: 50,
            height: 50,
            color: Colors.grey[800],
            child: const Icon(Icons.music_note, color: Colors.white),
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
        child: const Icon(Icons.music_note, color: Colors.white),
      ),
        title: Text(
          currentTrack!.title,
          style: const TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          currentTrack!.authorName ?? 'Unknown',
          style: const TextStyle(color: Colors.white70),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: _playPause,
        ),
        onTap: () => _openFullPlayer(context),
      )
    ) 
    ;
  }

  void _openFullPlayer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerPage(
          urlMusic: currentTrack!.audioUrl,
          urlPhoto: currentTrack!.imageUrl,
          nameSound: currentTrack!.title,
          author: currentTrack!.authorName,
        ),
      ),
    ).then((_) {
      // При возврате с экрана плеера
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _savePlayerState();
    audioPlayer.dispose();
    super.dispose();
  }
}