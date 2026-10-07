import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/data/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_grid_view.dart';

class PokemonListScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonListAsyncValue = ref.watch(pokemonListProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Pokédex")),
      body: pokemonListAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(pokemonListProvider),
        ),
        data: (pokemonList) => PokemonGridView(pokemonList: pokemonList),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
