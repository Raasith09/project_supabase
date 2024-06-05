import 'package:flutter/material.dart';
import 'package:project_supabase/core/credentials.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseServices {
  // => GetData
  Future<List<Map<String, dynamic>>?> fetchTodo() async {
    try {
      final data = await Supabase.instance.client.from('mySmoothies').select();
      print(data);
      return data;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

// => PostData
  Future<PostgrestResponse?> addTodo(
      {required String title, required String description}) async {
    PostgrestResponse? response = await MyCredentials.supabaseClient
        .from("mySmoothies")
        .insert({"title": title, "description": description});

    if (response == null) {
      return response;
    }
    return response;
  }
}
