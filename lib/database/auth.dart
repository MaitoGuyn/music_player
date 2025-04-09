import 'package:music_player/database/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServise{
  final Supabase _supabase = Supabase.instance;

  // Future<LocalUser?> signIn( String email , String password)async {
  //   try{
  //     var userGet = await _supabase.client.auth.signInWithPassword(password: password, email: email);

  //     User user = userGet.user!;
  //     return LocalUser.fromSupabase(user);
  //   }
  //   catch(e){
  //     return null;
  //   }
  // }

  Future<LocalUser?> signIn(String email, String password) async {
  try {
    // Прямой запрос к вашей таблице Users
    final response = await _supabase.client
        .from('users')
        .select('id, Email_User, Password_User')
          .order('Email_User');

    List<LocalUser> users = response.map<LocalUser>((user) => LocalUser.fromMap(user)).toList();
    return users.firstWhere(
    (user) => user.email == email && user.Password == password,);
  } 
  catch (e) {
    print('SignIn error: $e');
    return null;
  }
}

//   Future<LocalUser?> signUp(String email, String password) async {
//   try {
//     var userGet = await _supabase.client.auth.signUp(password: password, email: email);
//     User user = userGet.user!;
//     return LocalUser.fromSupabase(user);
//   } catch (e) {
//     print("Ошибка при регистрации: $e"); // Вывод ошибки в консоль
//     return null;
//   }
// }

  Future<void> logOut()async{
    try{
      await _supabase.client.auth.signOut();
    }
    catch(e){
      return;
    }
  }

  Future<void> RecoveryPassword(String email)async{
    try{
      await _supabase.client.auth.resetPasswordForEmail(email);
    }
    catch(e){
      return;
    }
  }

}