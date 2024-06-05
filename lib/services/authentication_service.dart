import 'package:flutter/material.dart';
import 'package:project_supabase/core/credentials.dart';
import 'package:project_supabase/core/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationService {
  Future<String?> signUp(
      {required String email, required String password}) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user != null) {
      await prefs.setString('userId', response.user!.id);
      await prefs.setString('userEmail', response.user!.email!);

      return "success";
    } else {
      debugPrint("Signup failed: no user returned");
    }

    return "failure";
  }

  Future<String?> logIn(
      {required String email, required String password}) async {
    AuthResponse response =
        await MyCredentials.supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    debugPrint(response.session.toString());
    debugPrint(response.user.toString());
    if (response.user != null) {
      var prefs = await SharedPref.getSharedPrefInstance();
      prefs.setString("userId", response.user!.id);

      return "success";
    }

    return "failure";
  }

  Future<String> logOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await MyCredentials.supabaseClient.auth.signOut();
      return "success";
    } catch (e) {
      return "failed";
    }
  }
}
