import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:project_supabase/screens/sign_in/ui/sign_in.dart';
import 'package:project_supabase/utils/colors.dart';
import 'package:project_supabase/utils/my_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryThemeColor,
      body: Center(
        child: BounceInDown(
          duration: const Duration(milliseconds: 1000),
          child: Image.asset(
            MyAssets.splashImage,
            height: 250,
            width: 250,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void goToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
    });
  }
}
