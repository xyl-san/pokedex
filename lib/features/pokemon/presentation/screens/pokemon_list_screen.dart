import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_grid_view.dart';

class PokemonListScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokédex")),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: PokemonGridView(),
        ),
      ),
    );
  }
}
