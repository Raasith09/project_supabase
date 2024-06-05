import 'package:flutter/material.dart';
import 'package:project_supabase/utils/colors.dart';

class AppTheme {
  static ThemeData lightThemeData = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.mainThemeColor,
    useMaterial3: true,
    splashColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    fontFamily: "Poppins",
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.secondaryThemeColor),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: AppColors.secondaryThemeColor),
  );
}
