import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/data/sample_pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_grid_tile.dart';

class PokemonGridView extends StatelessWidget {
  const PokemonGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: samplePokemon.length, // Replace with your actual item count
      itemBuilder: (context, index) {
        return PokemonGridTile(pokemon: samplePokemon[index]);
      },
    );
  }
}
