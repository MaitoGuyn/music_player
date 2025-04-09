import 'package:flutter/material.dart';
import 'package:music_player/database/Track.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerManager with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Track? _currentTrack;
  bool _isPlaying = false;
  bool _isLoading = false;

  Track? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;

  Future<void> playTrack(Track track) async {
    if (_isLoading) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      if (_currentTrack?.id != track.id) {
        await _audioPlayer.stop();
        await _audioPlayer.play(UrlSource(track.audioUrl!));
        _currentTrack = track;
        _isPlaying = true;
      } else {
        if (_isPlaying) {
          await _audioPlayer.pause();
          _isPlaying = false;
        } else {
          await _audioPlayer.resume();
          _isPlaying = true;
        }
      }
    } catch (e) {
      debugPrint('Playback error: $e');
      _isPlaying = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}