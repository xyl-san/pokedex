import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/pokemon_type.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_detail/detail.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonDetail extends StatelessWidget {
  const SkeletonDetail({super.key});

  static const _placeholder = Pokemon(
    id: 0,
    name: 'loading loading',
    types: [PokemonType.normal, PokemonType.fire],
    height: 0,
    weight: 0,
    imageUrl: '',
    description:
        'Loading this Pokémon from the Pokédex. Please wait a moment while '
        'the data arrives from the server so we can display it here for you.',
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: DetailScaffold(pokemon: _placeholder),
    );
  }
}
