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

  Future<void> deleteUser() async{
    
  }
}