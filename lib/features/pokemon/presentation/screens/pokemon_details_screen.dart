import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/data/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/pokemon.dart';

class PokemonDetailsScreen extends ConsumerWidget {
  final int pokemonId;

  const PokemonDetailsScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsyncValue = ref.watch(pokemonByIdProvider(pokemonId));

    return pokemonAsyncValue.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
      data: (pokemon) => _PokemonDetailsView(pokemon: pokemon),
    );
  }
}

class _PokemonDetailsView extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonDetailsView({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final primaryType = pokemon.types.first;
    final typeColor = primaryType.color;

    return Scaffold(
      backgroundColor: typeColor,
      appBar: AppBar(
        title: Text(
          pokemon.displayName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add your Pokémon details UI here
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'ID: ${pokemon.id}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Types: ${pokemon.types.map((type) => type.name).join(', ')}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
