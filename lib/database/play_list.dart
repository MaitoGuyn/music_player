class Playlist {
  final int id;
  final String name;
  final String userId;

  Playlist({
    required this.id,
    required this.name,
    required this.userId,
  });

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['ID_List'] as int,
      name: map['Name_PlayList'] as String,
      userId: map['ID_User'] as String,
    );
  }
}