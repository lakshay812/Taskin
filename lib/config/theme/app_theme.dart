import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.orange,
      secondary: const Color(0xFFFEC532),
      background: Colors.white,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Colors.black,
      onSurface: Colors.black,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.orange,
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: ColorScheme.dark(
      primary: Colors.orange,
      secondary: const Color(0xFFFEC532),
      background: Colors.grey[900]!,
      surface: Colors.grey[800]!,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
  );
}