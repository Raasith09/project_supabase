import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_supabase/screens/home/bloc/home_bloc.dart';
import 'package:project_supabase/screens/splash_screen/splash_screen.dart';
import 'package:project_supabase/utils/themedata.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/credentials.dart';
import 'screens/sign_in/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: MyCredentials.apiUrl,
    anonKey: MyCredentials.apiKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Supabase_Project',
        theme: AppTheme.lightThemeData,
        home: const SplashScreen(),
      ),
    );
  }
}



    // final prefs = await SharedPreferences.getInstance();

    // var gotrueClient = GoTrueClient(
    //   url: MyCredentials.apiUrl.trim(),
    //   headers: {'apikey': MyCredentials.apiKey.trim()},
    //   asyncStorage: SharedPreferencesGotrueStorage(prefs),
    //   flowType: AuthFlowType.pkce, // This is set to PKCE by default
    // );