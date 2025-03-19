import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class StorageCloud {
  final SupabaseClient _client;

  StorageCloud() : _client = Supabase.instance.client;

  Future<void> uploadImage(XFile imageFile) async {
    try {
      final fileName = path.basename(imageFile.path);
      await _client.storage
          .from('storage')
          .upload(fileName, File(imageFile.path));
      print("Upload completed");
    } catch (e) {
      print("Error uploading image: $e");
      // Можно добавить обработку ошибок или повторную попытку
    }
  }
}