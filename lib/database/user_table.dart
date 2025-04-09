import 'dart:io';

import 'package:music_player/database/Author.dart';
import 'package:music_player/database/Track.dart';
import 'package:music_player/database/play_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class UserTable {
  final Supabase _supabase = Supabase.instance;

  Future<void> addUser(String name, String email, String Password) async{
     try{
      await _supabase.client.from('users').insert(
        {
          'name': name,
          'email': email,
          'password': Password,
          'avatar': 'https://avlhfundbxtouuguzldi.supabase.co/storage/v1/object/public/storages//images.png'
        }
      );
    }
    catch(e){
        return;
    }
  }

  Future<void> updateUser(dynamic uid, String url) async{
   try {
     await _supabase.client.from('users').update(
      {
        'avatar': url,
      }
     ).eq('id', uid);
   } catch (e) {
     return;
   }
  }

  Future<List<Author>> fetchAuthors() async {
    try {
      final response = await _supabase.client
          .from('Author')
          .select('ID_Author, Name_Author, Image')
          .order('Name_Author');

      return response.map<Author>((author) => Author.fromMap(author)).toList();
    } catch (e) {
      print('Error fetching authors: $e');
      return [];
    }
  }

  Future<List<Track>> fetchTracks() async {
    try {
      final response = await _supabase.client
          .from('Track')
          .select('''
            *,
            Author:ID_Author (Name_Author),
            Genre:ID_Genre (Name_Genre)
          ''')
          .order('Name_Track');

      return response.map<Track>((track) => Track.fromMap(track)).toList();
    } catch (e) {
      print('Error fetching tracks: $e');
      return [];
    }
  }

Future<List<Playlist>> fetchPlaylists() async {
  try {
    final response = await _supabase.client
        .from('List')
        .select('ID_List, Name_PlayList, ID_User')
        .order('Name_PlayList');

    return response.map<Playlist>((pl) => Playlist.fromMap(pl)).toList();
  } catch (e) {
    print('Error fetching playlists: $e');
    return [];
  }
}

Future<List<Track>> fetchPlaylistTracks(int playlistId) async {
  try {
    final response = await _supabase.client
        .from('playlist')
        .select('''
          Track: id_track (
            *,
            Author: ID_Author (Name_Author),
            Genre: ID_Genre (Name_Genre)
          )
        ''')
        .eq('id_list', playlistId)
        .order('Name_Track', referencedTable: 'id_track');

    return response.map<Track>((item) => Track.fromMap(item['Track'])).toList();
  } catch (e) {
    print('Error fetching playlist tracks: $e');
    return [];
  }
}


}