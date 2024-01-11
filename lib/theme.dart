import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.green[800],
      hintColor: Colors.green[600],
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.green[800],
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
