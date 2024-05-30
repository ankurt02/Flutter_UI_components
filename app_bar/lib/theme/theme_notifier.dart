// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme = true;

  bool get isDarkTheme => _isDarkTheme;

  ThemeData get currentTheme => _isDarkTheme ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black87,
    primaryColor: Colors.black87,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.black87,
      iconTheme: IconThemeData(color: Colors.white70),
      titleTextStyle: TextStyle(color: Colors.white70, fontSize: 20),
      toolbarTextStyle: TextStyle(color: Colors.white70, fontSize: 20),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white70),
      labelLarge: TextStyle(color: Colors.white70),
      labelSmall: TextStyle(color: Colors.white70),
      labelMedium: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.white70,
      brightness: Brightness.dark,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20),
      toolbarTextStyle: TextStyle(color: Colors.black87, fontSize: 20),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black87),
      labelLarge: TextStyle(color: Colors.black87),
      labelSmall: TextStyle(color: Colors.black87),
      labelMedium: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.black87,
      brightness: Brightness.light,
    ),
  );
}
