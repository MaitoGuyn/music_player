import 'package:supabase_flutter/supabase_flutter.dart';

class Author {
  final int id;
  final String name;
  final String? imagePath; // Путь к изображению в Storage (например "author_1.jpg")

  Author({
    required this.id,
    required this.name,
    this.imagePath,
  });

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      id: map['ID_Author'] as int,
      name: map['Name_Author'] as String,
      imagePath: map['Image'] as String?, // Поле из таблицы Author
    );
  }

  String? get imageUrl {
    if (imagePath == null) return null;
    return Supabase.instance.client.storage
      .from('authorimages')
      .getPublicUrl(imagePath!);
  }
}