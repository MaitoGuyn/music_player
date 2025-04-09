import 'package:supabase_flutter/supabase_flutter.dart';

class Track {
  final int id;
  final String title;
  final String? imagePath;
  final String? audioPath;
  final int genreId;
  final int authorId;
  String? authorName;
  String? genreName;

  Track({
    required this.id,
    required this.title,
    this.imagePath,
    this.audioPath,
    required this.genreId,
    required this.authorId,
    this.authorName,
    this.genreName,
  });

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      id: map['ID_Track'] as int,
      title: map['Name_Track'] as String,
      imagePath: map['Image'] as String?,
      audioPath: map['audio_path'] as String?, 
      genreId: map['ID_Genre'] as int,
      authorId: map['ID_Author'] as int,
      authorName: map['Author']?['Name_Author'] as String?,
      genreName: map['Genre']?['Name_Genre'] as String?,
    );
  }

  String? get imageUrl {
    if (imagePath == null) return null;
    return Supabase.instance.client.storage
      .from('trackimages')
      .getPublicUrl(imagePath!);
  }

  String? get audioUrl {
    if (audioPath == null) return null;
    return Supabase.instance.client.storage
      .from('trackaudio')
      .getPublicUrl(audioPath!);
  }

}