import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/data/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_detail/detail.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_detail/skeleton_detail.dart';

class PokemonDetailsScreen extends ConsumerWidget {
  final int id;

  const PokemonDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(pokemonByIdProvider(id));

    return pokemonAsync.when(
      loading: () => const SkeletonDetail(),
      error: (err, _) => _ErrorScaffold(error: err, id: id),
      data: (pokemon) => DetailScaffold(pokemon: pokemon),
    );
  }
}

// =============================================================================
// ERROR STATES
// =============================================================================

class _ErrorScaffold extends StatelessWidget {
  final Object error;
  final int id;

  const _ErrorScaffold({required this.error, required this.id});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$error',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
