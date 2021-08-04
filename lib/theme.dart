import 'dart:ui';

import 'package:flutter/material.dart';

///theme of entire app
class AppTheme {
  //_themeData is fed into AppState.
  static final ThemeData _themeData = ThemeData.light();

  static get theme {
    return _themeData.copyWith(
        scaffoldBackgroundColor: Colors.white,
        tabBarTheme: TabBarTheme(labelColor: Colors.white),
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.blue,
            ),
            textTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold))));
  }
}
