import 'package:flutter/material.dart';

class AppTheme {
  static const _seed = Color.fromARGB(255, 255, 241, 46);
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: _seed),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.amber,
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    ),
  );
}
