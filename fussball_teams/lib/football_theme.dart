import 'package:flutter/material.dart';

class FootballTheme {
  static const TextTheme textTheme = TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 16.0,
      color: Colors.black,
    ),
    subtitle2: TextStyle(
      fontSize: 14.0,
      color: Colors.grey,
    ),
    headline1: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline6: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );

  static ThemeData themeData() {
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF01C13B),
      ),
      textTheme: textTheme,
      primaryColor: const Color(0xFF01C13B),
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: const Color(0xFF01C13B),
      ),
    );
  }
}
