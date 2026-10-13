import 'package:flutter/material.dart';
import 'package:netflixclone/src/core/app_colors.dart';

class AppTheme{
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundBlack,
      primaryColor: AppColors.netflixRed,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.netflixRed,
        surface: AppColors.darkGray
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundBlack,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundBlack,
        selectedItemColor: AppColors.textLight,
        unselectedItemColor: AppColors.darkGray,
        type: BottomNavigationBarType.fixed
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.netflixRed,
          foregroundColor: AppColors.textLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
          ),
          minimumSize: const Size(double.infinity, 50)
        )
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: AppColors.textLight, 
                          fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: AppColors.textLight, 
                          fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: AppColors.textLight, 
                          fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: AppColors.textLight),
        bodyMedium: TextStyle(color: AppColors.textGray),
      )
    );
  }
}