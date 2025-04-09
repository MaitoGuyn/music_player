// import 'package:music_player/database/user.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class CustomAuthService {
//   final SupabaseClient _supabase;

//   CustomAuthService(this._supabase);

//   Future<LocalUser?> signIn(String email, String password) async {
//     try {
//       // 1. Ищем пользователя в своей таблице
//       final userData = await _supabase
//           .from('Users')
//           .select()
//           .eq('Email_User', email)
//           .eq('Password_User', password)
//           .maybeSingle();

//       if (userData == null) return null;

//       // 2. Авторизуем через Supabase Auth (если нужно)
//       try {
//         await _supabase.auth.signInWithPassword(
//           email: email,
//           password: password,
//         );
//       } catch (e) {
//         print('Supabase auth fallback: $e');
//       }

//       return LocalUser(
//         id: userData['Id'] as String,
//         email: userData['Email_User'] as String,
//       );
//     } catch (e) {
//       print('Custom auth error: $e');
//       return null;
//     }
//   }
// }