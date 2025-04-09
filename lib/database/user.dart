import 'package:supabase_flutter/supabase_flutter.dart';

class LocalUser{
  final int id;
  final String email;
  final String Password;

  LocalUser({
    required this.id,
    required this.email,
    required this.Password,
  });
  
  factory LocalUser.fromMap(Map<String, dynamic> map) {
    return LocalUser(
      id: map['id'] as int,
      email: map['Email_User'] as String,
      Password: map['Password_User'] as String, // Поле из таблицы Author
    );
  }

  // LocalUser.fromSupabase(User user){
  //   id = user.id;
  //   email = user.email;
  // }
  // final int id;
  // final String name;
  // final String? imagePath; // Путь к изображению в Storage (например "author_1.jpg")

  // Author({
  //   required this.id,
  //   required this.name,
  //   this.imagePath,
  // });

  // factory Author.fromMap(Map<String, dynamic> map) {
  //   return Author(
  //     id: map['ID_Author'] as int,
  //     name: map['Name_Author'] as String,
  //     imagePath: map['Image'] as String?, // Поле из таблицы Author
  //   );
  // }

  //  LocalUser({required this.id, required this.email});

  // factory LocalUser.fromJson(Map<String, dynamic> json) {
  //   return LocalUser(
  //     id: json['Id'] as String,
  //     email: json['Email_User'] as String,
  //   );
  // }
}

