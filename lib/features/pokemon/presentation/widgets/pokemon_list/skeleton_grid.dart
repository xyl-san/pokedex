import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list/pokemon_grid_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonGrid extends StatelessWidget {
  const SkeletonGrid({super.key});

  /// Fake data — the *shape* matters, the values don't.
  static final _placeholderPokemon = List.generate(
    6,
    (i) => const Pokemon(
      id: 0,
      name: 'loading',
      types: [PokemonType.normal, PokemonType.normal],
      height: 0,
      weight: 0,
      imageUrl: '',
      description: '',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.78,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _placeholderPokemon.length,
        itemBuilder: (context, index) {
          return PokemonGridTile(
            pokemon: _placeholderPokemon[index],
            onTap: null,
          );
        },
      ),
    );
  }
}
