import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
  primarySwatch: Colors.brown,
  scaffoldBackgroundColor: Colors.orange[100],
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: Colors.white,
    unselectedLabelColor: Colors.white54,
  ),
  iconTheme: IconThemeData(
    color: Colors.brown,
    size: 25,
  ),
  cardTheme: CardTheme(
    elevation: 20,
    color: Colors.orange,
    shadowColor: Colors.brown,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 60,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w200,
    ),
    titleSmall: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
  ),
);
