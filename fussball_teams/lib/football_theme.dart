import 'package:flutter/material.dart';
import 'package:fussball_teams/constants.dart';

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
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    subtitle2: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
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
        backgroundColor: kHauptFarbe,
      ),
      textTheme: textTheme,
      primaryColor: kHauptFarbe,
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: kHauptFarbe,
      ),
    );
  }
}
