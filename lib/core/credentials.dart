import 'package:supabase_flutter/supabase_flutter.dart';

class MyCredentials {
  static const String apiKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15bnZxdXBmZGZxeXZ6YWFyanZ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc0NzQwMDUsImV4cCI6MjAzMzA1MDAwNX0.NuJdr_XQfsH9mYTR4clibob7iOChlhs4RzELYsOGbdw";
  static const String apiUrl = "https://mynvqupfdfqyvzaarjvu.supabase.co";
  static SupabaseClient supabaseClient = SupabaseClient(apiUrl, apiKey);
}
