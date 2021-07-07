import 'dart:ui';

import 'package:flutter/material.dart';

///theme of entire app
class AppTheme {
  //_themeData is fed into AppState.
  static final ThemeData _themeData = ThemeData.light();

  static get theme {
    return _themeData.copyWith(
        tabBarTheme: TabBarTheme(labelColor: Colors.black),
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.blue,
            ),
            backgroundColor: Colors.white,
            textTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold))));
  }
}
