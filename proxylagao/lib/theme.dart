import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette - Updated to match design tokens
  static const Color textColor = Color(0xFF050315);
  static const Color backgroundColor = Color(0xFFFBFBFE);
  static const Color primaryColor = Color(0xFF2F27CE);
  static const Color secondaryColor = Color(0xFFDEDCFF);
  static const Color accentColor = Color(0xFF433BFF);
  
  // Additional colors for attendance status
  static const Color goodAttendance = Colors.green;
  static const Color poorAttendance = Colors.red;

  static ThemeData lightTheme = ThemeData(
    primarySwatch: MaterialColor(0xFF2F27CE, const {
      50: Color(0xFFF3F2FF),
      100: Color(0xFFE8E6FF),
      200: Color(0xFFD5D1FF),
      300: Color(0xFFBEB8FF),
      400: Color(0xFFA49AFF),
      500: Color(0xFF8A7CFF),
      600: Color(0xFF7866FF),
      700: Color(0xFF6651FF),
      800: Color(0xFF5541FF),
      900: Color(0xFF2F27CE),
    }),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: textColor,
      onSurface: textColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: textColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: textColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: textColor,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: textColor,
        fontSize: 12,
      ),
    ),
  );
}