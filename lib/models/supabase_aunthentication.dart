// import 'package:flutter/material.dart';
// import 'package:supabase/supabase.dart';

// const String supabaseUrl = "your supabase url goes here ";
// const String token = "your supabase token goes here";

// class SupabaseManager {
//   final client = SupabaseClient(supabaseUrl, token);

//   Future<void> signUpUser(context, {String? email, String? password}) async {
//     debugPrint("email:$email password:$password");
//     try {
//       final result =
//           await client.auth.signUp(email: email!, password: password!);

//       print(result);
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> signInUser(context, {String? email, String? password}) async {
//     debugPrint("email:$email password:$password");
//     try {
//       final result = await client.auth
//           .signInWithPassword(email: email!, password: password!);
//       print(result);
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> logout(context) async {
//     await client.auth.signOut();
//     Navigator.pushReplacementNamed(context, 'login');
//   }
// }
