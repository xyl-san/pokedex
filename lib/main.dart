import 'package:flutter/material.dart';
import 'package:pokedex/app/theme.dart';
import 'package:pokedex/features/pokemon/presentation/screens/pokemon_list_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex App',
      theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
      home: const PokemonListScreen(),
    );
  }
}
