import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list/pokemon_grid_tile.dart';

class PokemonGridView extends StatelessWidget {
  final List<Pokemon> pokemonList;
  const PokemonGridView({super.key, required this.pokemonList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: pokemonList.length, // Replace with your actual item count
      itemBuilder: (context, index) {
        return PokemonGridTile(
          pokemon: pokemonList[index],
          onTap: () {
            debugPrint('Tapped on ${pokemonList[index].name}');
            context.push('/pokemon/${pokemonList[index].id}');
          },
        );
      },
    );
  }
}
